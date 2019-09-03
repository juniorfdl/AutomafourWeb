unit Luar.Utils.FTP;

interface

uses
  System.SysUtils, System.Classes,
  Luar.Utils.FTP.Interfaces, IdFTP, Luar.Utils.SmartPointer,
  AtualizarVersao.Eventos, IdComponent;

type
  TLuarUtilsFTP = class (TInterfacedObject, ILuarUtilsFTPInterfaces)
  strict private
    fListaArquivos: TSmartPointer<TStringList>;
    fWorkCountMax: Int64;
    fNomeArquivo:String;
    fFTP: String;
    fIdFTP: TIdFTP;
    fevStatus: TevStatus;
    function SetStatus(Value: TevStatus):ILuarUtilsFTPInterfaces;
    function GetListaArquivos: TStringList;

    procedure WorkBeginEvent(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure WorkEndEvent(ASender: TObject; AWorkMode: TWorkMode);
    procedure WorkEvent(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
  public
    function Conectar: ILuarUtilsFTPInterfaces;
    function BaixarArquivo(const pOrigem, pDestino:String): ILuarUtilsFTPInterfaces;
    function BaixarDaPasta(const pPasta, pPastaDestino:String): ILuarUtilsFTPInterfaces;

    constructor create(const FTP, FTP_USER, FTP_PASS:String);
    destructor destroy; override;

    class function New(const FTP, FTP_USER, FTP_PASS:String): ILuarUtilsFTPInterfaces;
  end;

implementation

{ TLuarUtilsFTP }

function TLuarUtilsFTP.BaixarArquivo(const pOrigem,
  pDestino: String): ILuarUtilsFTPInterfaces;
begin
  Result := Self;
end;

function TLuarUtilsFTP.Conectar: ILuarUtilsFTPInterfaces;
begin
  Result := Self;
  fIdFTP.Connect;
end;

constructor TLuarUtilsFTP.create(const FTP, FTP_USER, FTP_PASS: String);
begin
  fFTP := FTP;
  fIdFTP := TIdFTP.Create(nil);
  fIdFTP.OnWork := WorkEvent;
  fIdFTP.OnWorkBegin := WorkBeginEvent;
  fIdFTP.OnWorkEnd := WorkEndEvent;
  fIdFTP.Host := FTP;
  fIdFTP.Port := 21;
  fIdFTP.Username := FTP_USER;
  fIdFTP.Password := FTP_PASS;
  fIdFTP.Passive := false; { usa modo ativo }
  fIdFTP.ConnectTimeout := 10000;
end;

destructor TLuarUtilsFTP.destroy;
begin
  if Assigned(fIdFTP) then
  begin
    if fIdFTP.Connected then
      fIdFTP.Disconnect;
    FreeAndNil(fIdFTP);
  end;

  inherited;
end;

function TLuarUtilsFTP.GetListaArquivos: TStringList;
begin
  Result := fListaArquivos;
end;

class function TLuarUtilsFTP.New(const FTP, FTP_USER, FTP_PASS: String): ILuarUtilsFTPInterfaces;
begin
  Result := Self.create(FTP, FTP_USER, FTP_PASS);
end;

function TLuarUtilsFTP.BaixarDaPasta(
  const pPasta, pPastaDestino: String): ILuarUtilsFTPInterfaces;
var
  indice:Integer;
begin
  Result := Self;

  if not DirectoryExists(pPastaDestino) then
    MkDir(pPastaDestino);

  fListaArquivos := TStringList.Create;
  fIdFTP.ChangeDir(pPasta);
  fIdFTP.List(fListaArquivos.Value,'',false);

  for indice:= 0 to fListaArquivos.Value.Count -1 do
  begin
    fNomeArquivo:= fListaArquivos.Value.Strings[indice];
    if (UpperCase(fNomeArquivo) <> 'CONF.JSON')and(UpperCase(fNomeArquivo) <> 'GRAVARVERSAO.EXE') then
    begin
      fWorkCountMax := fIdFTP.Size(fNomeArquivo);
      fIdFTP.Get(fNomeArquivo,pPastaDestino + '\' + fNomeArquivo,true);
    end;
  end;

end;

function TLuarUtilsFTP.SetStatus(Value: TevStatus): ILuarUtilsFTPInterfaces;
begin
  Result := Self;
  fevStatus := Value;
end;

procedure TLuarUtilsFTP.WorkBeginEvent(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  if not Assigned(fevStatus) then
    Exit;

  if AWorkCountMax > 0 then
    fWorkCountMax := AWorkCountMax;

  fevStatus('Baixando: '+ fNomeArquivo, 0, fWorkCountMax);
end;

procedure TLuarUtilsFTP.WorkEndEvent(ASender: TObject; AWorkMode: TWorkMode);
begin
  if not Assigned(fevStatus) then
    Exit;

  fevStatus('Arquivo: '+fNomeArquivo+' baixado', fWorkCountMax, fWorkCountMax);
end;

procedure TLuarUtilsFTP.WorkEvent(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  if not Assigned(fevStatus) then
    Exit;

  fevStatus('Baixando: '+ fNomeArquivo+' . . .', AWorkCount, fWorkCountMax);
end;

end.
