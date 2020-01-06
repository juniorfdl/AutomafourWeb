unit AtualizarVersao.Facade;

interface

uses Luar.Utils.SmartPointer,
  System.SysUtils, forms,
  System.Classes, Luar.RestApi.Client.Impl, DadosConf,

  ormbr.jsonutils.DataSnap,
  ormbr.rest.Json, AtualizarVersao.Interfaces,
  Luar.Utils.FTP, AtualizarVersao.Eventos, Luar.Utils.FTP.Interfaces,
  ShellAPI, Windows, Luar.Utils.VersaoApp;

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
  public
    constructor create(const pDocCliente:String; const pApp:String);
    destructor Destroy; override;

    class function New(const pDocCliente:String; const pApp:String): IAtualizarVersaoInterfaces;
  End;

implementation

{ TAtualizarVersaoFacade }
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

  Status('Conectando: '+ vIPFTP, 0, 0);
  oLuarUtilsFTP := TLuarUtilsFTP.New(vIPFTP, fDadosConf.FTP_USER, fDadosConf.FTP_PASS).Conectar;
  oLuarUtilsFTP.SetStatus(fevStatus);
  Status('Conexão OK', 0, 0);
  BaixarArquivos;
  DerrubarAplicacao;
  CopiarArquivosOrigem;
end;

procedure TAtualizarVersaoFacade.BaixarArquivos;
begin
  Status('Localizado pasta: '+ fPastaOrigem, 0, 0);
  oLuarUtilsFTP.BaixarDaPasta(fPastaOrigem,
    fCaminhoDestino
  );
end;

function TAtualizarVersaoFacade.ClienteAtualizado: Boolean;
var
  vEndPoint, vRet, vVersaoAtualAPP:String;
begin
  if fDadosConf.DATA_ATUALIZACAO = FormatDateTime('dd/mm/yyyy', Now) then
  begin
    Exit(True);
  end;

  if Trim(fDadosConf.DOC_CLI) = '' then
  begin
    Exit(True);
  end;

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

  vRet:= '';
  TLuarRestApiClientImpl.New(fDadosConf.BASE_URL)
      .SetResource(vEndPoint)
      .Get
      .GetRetorno.TryGetValue('mensagem_erro', vRet);

  Result := not(Pos('Cliente nao atualizado', vRet) > 0);
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

      CopyFile(PChar(fCaminhoDestino+'\'+vNomeArq), PChar(fPATH_APP+'\'+vNomeArq), false);
    end;
  end;

  SalvarDataAtualizacao;
end;

constructor TAtualizarVersaoFacade.create(const pDocCliente, pApp: String);
begin
  fDocCliente:= pDocCliente;
  fApp := pApp;
  fPATH_APP:= ExtractFileDir(Application.ExeName);
  fCaminhoDestino :=
    fPATH_APP+'\New'+FormatDateTime('ddmmyyyy', Now);
  GetConf;
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
  if not FileExists(ExtractFilePath(ParamStr(0))+'\Conf.Json') then
  begin
    raise Exception.Create('Arquivo Conf.Json não configurado');
  end;

  fDadosConf := TDadosConf.New(ExtractFilePath(ParamStr(0))+'\Conf.Json');
  
end;

class function TAtualizarVersaoFacade.New(const pDocCliente, pApp: String):IAtualizarVersaoInterfaces;
begin
  Result := Self.create(pDocCliente, pApp);
end;

procedure TAtualizarVersaoFacade.SalvarDataAtualizacao;
var
  oList: TSmartPointer<TStringList>;
begin
  fDadosConf.DATA_ATUALIZACAO := FormatDateTime('dd/mm/yyyy', Now);
  oList.Value.Text := TORMBrJson.ObjectToJsonString(fDadosConf);
  oList.Value.SaveToFile(ExtractFilePath(ParamStr(0))+'\Conf.Json');
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
    fevStatus(Value, Posicao, Max);
  end;
end;

end.
