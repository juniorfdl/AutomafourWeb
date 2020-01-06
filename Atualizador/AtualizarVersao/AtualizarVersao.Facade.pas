unit AtualizarVersao.Facade;

interface

uses Luar.Utils.SmartPointer,
  System.SysUtils, forms,
  System.Classes, Luar.RestApi.Client.Impl, DadosConf,

  ormbr.jsonutils.DataSnap,
  ormbr.rest.Json, AtualizarVersao.Interfaces,
  Luar.Utils.FTP, AtualizarVersao.Eventos, Luar.Utils.FTP.Interfaces,
  ShellAPI, Windows, Luar.Utils.VersaoApp, System.Zip;

Type
  TAtualizarVersaoFacade = Class(TInterfacedObject, IAtualizarVersaoInterfaces)
  private
    fPATH_APP:String;
    fCaminhoDestino: String;
    FDocCliente: string;
    FApp: string;
    fDadosConf: TDadosConf;
    fevStatus: TevStatus;
    fPastaOrigem:String;
    fCOD_CADPESSOA: String;
    fCOD_CADVERSAO: String;
    oLuarUtilsFTP: ILuarUtilsFTPInterfaces;

    procedure BaixarArquivos;
    function AtualizarVersao: IAtualizarVersaoInterfaces;
    function ClienteAtualizado: Boolean;
    procedure GetConf;
    procedure Status(Value: String; Posicao, Max:Integer);
    function SetStatus(Value: TevStatus):IAtualizarVersaoInterfaces;
    procedure DerrubarAplicacao;
    procedure CopiarArquivosOrigem;
    procedure AbrirVersao;
    procedure SalvarDataAtualizacao;
    procedure DescompactarArquivo(const pArquivo, pPastaDestino: String);
    procedure SalvarAtualizacaoServidor;
    function GravarErro(Value: String): IAtualizarVersaoInterfaces;
    function GravarLog(Value: String): IAtualizarVersaoInterfaces;
  public
    constructor create(const pDocCliente:String; const pApp:String);
    destructor Destroy; override;

    class function New(const pDocCliente:String; const pApp:String): IAtualizarVersaoInterfaces;
  End;

implementation

uses
  System.JSON;

{ TAtualizarVersaoFacade }

procedure TAtualizarVersaoFacade.DescompactarArquivo(const pArquivo: String;
  const pPastaDestino: String);
var
  z: TSmartPointer<TZipFile>;
begin
  if fileExists(pArquivo) then
  begin
    z.Value.Open(pArquivo, zmRead);
    z.Value.ExtractAll(pPastaDestino);
    z.Value.Close;
  end;
end;

function TAtualizarVersaoFacade.AtualizarVersao: IAtualizarVersaoInterfaces;
var
  vIPFTP:String;
begin
  Result := Self;
  //ftp://200.98.170.118/Sistema/ATUALIZACAO_SISTEMA/Checkout/
  vIPFTP := StringReplace(fDadosConf.FTP,'ftp://', '', [rfReplaceAll, rfIgnoreCase]);
  fPastaOrigem := vIPFTP;
  vIPFTP := Copy(vIPFTP, 1, Pos('/',vIPFTP)-1);
  fPastaOrigem:= StringReplace(fPastaOrigem, vIPFTP, '', []);

  if Copy(fPastaOrigem,1,1) = '/' then
    Delete(fPastaOrigem,1,1);

  GravarLog('AtualizarVersao: '+ vIPFTP);
  Status('Conectando: '+ vIPFTP, 0, 0);
  oLuarUtilsFTP := TLuarUtilsFTP.New(vIPFTP, fDadosConf.FTP_USER, fDadosConf.FTP_PASS).Conectar;
  oLuarUtilsFTP.SetStatus(fevStatus);
  Status('Conexão OK', 0, 0);
  BaixarArquivos;
  DerrubarAplicacao;
  CopiarArquivosOrigem;
  SalvarAtualizacaoServidor;
  SalvarDataAtualizacao;
end;

procedure TAtualizarVersaoFacade.BaixarArquivos;
begin
  GravarLog('BaixarArquivos');
  Status('Localizado pasta: '+ fPastaOrigem, 0, 0);
  oLuarUtilsFTP.BaixarDaPasta(fPastaOrigem,
    fCaminhoDestino
  );
end;

function TAtualizarVersaoFacade.ClienteAtualizado: Boolean;
var
  vEndPoint, vRet, vVersaoAtualAPP:String;
  oRet: TJSonObject;
begin
  if fDadosConf.DATA_ATUALIZACAO = FormatDateTime('dd/mm/yyyy', Now) then
  begin
    Exit(True);
  end;

  if Trim(fDadosConf.DOC_CLI) = '' then
  begin
    Exit(True);
  end;

  try
  FDocCliente:= fDadosConf.DOC_CLI;
  FApp := fDadosConf.APP;

  if FileExists(fPATH_APP +'\'+ FApp +'.exe') then
  begin
    vVersaoAtualAPP := TLuarUtilsVersaoApp.GetVersao(fPATH_APP +'\'+ FApp +'.exe');
    vVersaoAtualAPP := StringReplace(vVersaoAtualAPP, '.', '-', [rfReplaceAll]);
  end
  else begin
    vVersaoAtualAPP := '-999';
  end;

  vEndPoint:= fDadosConf.CONSULTA_VERSAO;
  vEndPoint:= Format(vEndPoint,[FApp, FDocCliente, vVersaoAtualAPP]);

  GravarLog('ClienteAtualizado: '+ fDadosConf.BASE_URL+'/'+vEndPoint);
  vRet:= '';
  oRet := TLuarRestApiClientImpl.New(fDadosConf.BASE_URL)
      .SetResource(vEndPoint)
      .Get
      .GetRetorno;

  GravarLog('ClienteAtualizado: '+ oRet.ToJSON);
  oRet.TryGetValue('mensagem_erro', vRet);
  oRet.TryGetValue('COD_CADPESSOA', fCOD_CADPESSOA);
  oRet.TryGetValue('COD_CADVERSAO', fCOD_CADVERSAO);

  Result := not(Pos('Cliente nao atualizado', vRet) > 0);
  except
    on E: Exception do
    begin
      GravarErro(E.Message);
      raise;
    end;
  end;
end;

procedure TAtualizarVersaoFacade.CopiarArquivosOrigem;
var
  i:Integer;
  vCaminhoOld:String;
  vNomeArq:String;
  vListaArquivos:TStringList;
begin
  if not DirectoryExists(fCaminhoDestino) then
    Exit;

  vCaminhoOld := StringReplace(fCaminhoDestino, 'New', 'Old', [rfIgnoreCase]);

  if not DirectoryExists(vCaminhoOld) then
    MkDir(vCaminhoOld);

  Status('Substituindo Arquivos . . .',0,0);

  vListaArquivos := oLuarUtilsFTP.GetListaArquivos;

  for i:= 0 to Pred(vListaArquivos.Count) do
  begin
    vNomeArq:= vListaArquivos.Strings[i];

    if (UpperCase(vNomeArq) <> 'CONF.JSON')and(UpperCase(vNomeArq) <> 'GRAVARVERSAO.EXE') then
    begin
      Status('Substituindo Arquivo:'+ vNomeArq,0,0);

      if FileExists(fPATH_APP+'\'+vNomeArq) then
      begin
        RenameFile(PChar(fPATH_APP+'\'+vNomeArq), PChar(fPATH_APP+'\'+vNomeArq+'.old'));
        CopyFile(PChar(fPATH_APP+'\'+vNomeArq+'.old'), PChar(vCaminhoOld+'\'+vNomeArq), false);
      end;

      if (Pos('.zip', LowerCase(vNomeArq)) > 0) then
      begin
        DescompactarArquivo(fCaminhoDestino+'\'+vNomeArq, fPATH_APP);
      end
      else
        CopyFile(PChar(fCaminhoDestino+'\'+vNomeArq), PChar(fPATH_APP+'\'+vNomeArq), false);
    end;
  end;
end;

constructor TAtualizarVersaoFacade.create(const pDocCliente, pApp: String);
begin
  try
    fDocCliente:= pDocCliente;
    fApp := pApp;
    fPATH_APP:= ExtractFileDir(Application.ExeName);
    fCaminhoDestino :=
    fPATH_APP+'\New'+FormatDateTime('ddmmyyyy', Now);
    GetConf;
  except
    on E: Exception do
    begin
      GravarErro(E.Message);
      raise;
    end;
  end;
end;

procedure TAtualizarVersaoFacade.DerrubarAplicacao;
begin
  {if not DirectoryExists(fCaminhoDestino) then
    Exit;

  if not FileExists(fCaminhoDestino+'\Stop.cmd') then
    Exit;

  Status('Derrubando aplicação . . .',0,0);

  CopyFile(PChar(fCaminhoDestino+'\Stop.cmd'),
    PChar(ExtractFileDir(Application.ExeName)+'\Stop.cmd'), False);

  ShellExecute(0, 'open',
    PChar(ExtractFileDir(Application.ExeName)+'\Stop.cmd'),
    nil, nil, SW_HIDE);  }
end;

destructor TAtualizarVersaoFacade.Destroy;
begin
  AbrirVersao;

  FreeAndNil(fDadosConf);
  inherited;
end;

procedure TAtualizarVersaoFacade.GetConf;
begin
  {if not FileExists(ExtractFilePath(ParamStr(0))+'\Conf.Json') then
  begin
    raise Exception.Create('Arquivo Conf.Json não configurado');
  end;}

  fDadosConf := TDadosConf.New;
end;

function TAtualizarVersaoFacade.GravarErro(
  Value: String): IAtualizarVersaoInterfaces;
var
  oList: TSmartPointer<TStringList>;
begin
  Result := Self;
  if FileExists(ExtractFileDir(Application.ExeName)+ '\erroatualizacao.txt') then
    oList.Value.LoadFromFile(ExtractFileDir(Application.ExeName)+ '\erroatualizacao.txt');

  oList.Value.Add(Value);
  oList.Value.SaveToFile(ExtractFileDir(Application.ExeName)+ '\erroatualizacao.txt');
end;

function TAtualizarVersaoFacade.GravarLog(
  Value: String): IAtualizarVersaoInterfaces;
var
  oList: TSmartPointer<TStringList>;
begin
  Result := Self;
  if FileExists(ExtractFileDir(Application.ExeName)+ '\logatualizacao.txt') then
    oList.Value.LoadFromFile(ExtractFileDir(Application.ExeName)+ '\logatualizacao.txt');


  oList.Value.Add(FormatDateTime('dd/mm/yyyy', Now)+': '+Value);
  oList.Value.SaveToFile(ExtractFileDir(Application.ExeName)+ '\logatualizacao.txt');
end;

class function TAtualizarVersaoFacade.New(const pDocCliente, pApp: String):IAtualizarVersaoInterfaces;
begin
  Result := Self.create(pDocCliente, pApp);
end;

procedure TAtualizarVersaoFacade.SalvarAtualizacaoServidor;
var
  JsonPost: TSmartPointer<TJSONObject>;
begin
  JsonPost.Value.AddPair('COD_CADPESSOA',fCOD_CADPESSOA);
  JsonPost.Value.AddPair('COD_CADVERSAO',fCOD_CADVERSAO);
  JsonPost.Value.AddPair('DADOS_MAQUINA', fDadosConf.COMPUTADOR);
  JsonPost.Value.AddPair('TERMINAL', fDadosConf.TERMINAL);

  GravarLog('SalvarAtualizacaoServidor: '+ JsonPost.Value.ToJSON);

  TLuarRestApiClientImpl.New(fDadosConf.BASE_URL)
      .SetResource('CAD_PESSOAVERSAO')
      .Post(JsonPost).GetRetorno.ToJSON;
end;

procedure TAtualizarVersaoFacade.SalvarDataAtualizacao;
var
  oList: TSmartPointer<TStringList>;
begin
  fDadosConf.DATA_ATUALIZACAO := FormatDateTime('dd/mm/yyyy', Now);
  oList.Value.Text := fDadosConf.DATA_ATUALIZACAO;
  oList.Value.SaveToFile(ExtractFileDir(Application.ExeName)+ '\UltimaAtualizacao.txt');
end;

procedure TAtualizarVersaoFacade.AbrirVersao;
begin
  if FileExists(fPATH_APP + '\Start.cmd') then
  begin
    ShellExecute(0, 'open', PChar(fPATH_APP + '\Start.cmd'), nil, nil, SW_HIDE);
    Halt(0);
  end;
end;

function TAtualizarVersaoFacade.SetStatus(Value: TevStatus): IAtualizarVersaoInterfaces;
begin
  Result := Self;
  fevStatus := Value;
end;

procedure TAtualizarVersaoFacade.Status(Value: String; Posicao, Max:Integer);
begin
  if Assigned(fevStatus) then
  begin
    GravarLog('Status: '+ Value);
    fevStatus(Value, Posicao, Max);
  end;
end;

end.
