unit uDM;

interface

uses
  SysUtils, Classes, DB, DBTables, RxQuery, Registry, Windows;

type
  TDM = class(TDataModule)
    DB: TDatabase;
    sqlCONFIG_ATUALIZADOR: TRxQuery;
    sqlCONFIG_ATUALIZADORAPP: TStringField;
    sqlCONFIG_ATUALIZADORBASE_URL: TStringField;
    sqlCONFIG_ATUALIZADORCAD_VERSAO: TStringField;
    sqlCONFIG_ATUALIZADORFTP: TStringField;
    sqlCONFIG_ATUALIZADORCONSULTA_VERSAO: TStringField;
    sqlCONFIG_ATUALIZADORVERSAO_ATUAL: TStringField;
    sqlCONFIG_ATUALIZADORFTP_USER: TStringField;
    sqlCONFIG_ATUALIZADORFTP_PASS: TStringField;
  private
    { Private declarations }
    fNomeComputador: String;
    function RetornarDocumentoEmpresa: String;
    function ExecutarBuscarConfiguracoes: String;
    function RetornarNomeComputador: String;
    function RetornarNomeTerminal: String;
    function RetornarUltimaAtualizacao: String;
  public
    { Public declarations }

    class function BuscarConfiguracoes: String;
  end;

implementation

{$R *.dfm}

{ TDM }

class function TDM.BuscarConfiguracoes: String;
var
  DM: TDM;
begin
  DM:= TDM.Create(nil);
  try
    Result := DM.ExecutarBuscarConfiguracoes;
  finally
    FreeAndNil(DM);
  end;
end;

function TDM.ExecutarBuscarConfiguracoes: String;
CONST
  JSON = ' {"APP": "%s", "BASE_URL": "%s", "CAD_VERSAO":"%s", '
  +' "FTP":"%s", "CONSULTA_VERSAO":"%s", "VERSAO_ATUAL":"%s", '
  +' "FTP_USER": "%s", "FTP_PASS": "%s", "DOC_CLI": "%s", '
  +' "DATA_ATUALIZACAO":"%s", "TERMINAL": "%s", "COMPUTADOR":"%s" } ';
begin
  DB.Open;
  try
    fNomeComputador :=  RetornarNomeComputador;
    sqlCONFIG_ATUALIZADOR.Open;
    Result := String(Format(JSON,
      [sqlCONFIG_ATUALIZADORAPP.AsString, sqlCONFIG_ATUALIZADORBASE_URL.AsString,
       sqlCONFIG_ATUALIZADORCAD_VERSAO.AsString, sqlCONFIG_ATUALIZADORFTP.AsString,
       sqlCONFIG_ATUALIZADORCONSULTA_VERSAO.AsString, sqlCONFIG_ATUALIZADORVERSAO_ATUAL.AsString,
       sqlCONFIG_ATUALIZADORFTP_USER.AsString, sqlCONFIG_ATUALIZADORFTP_PASS.AsString,
       RetornarDocumentoEmpresa, RetornarUltimaAtualizacao, RetornarNomeTerminal, fNomeComputador]
    ));
  Finally
    sqlCONFIG_ATUALIZADOR.Close;
    Db.Close;
  end;
end;

function TDM.RetornarNomeComputador: String;
var
  Texto: TextFile;
  Registro: TRegistry;
  Info: String;
begin
  Registro := TRegistry.Create;
  try
    Registro.RootKey := HKEY_LOCAL_MACHINE;
    Registro.Openkey('System\CurrentControlSet\Services\VXD\VNETSUP', false);
    Result := Registro.ReadString('ComputerName');
    if Result = '' then
    begin
      Registro.RootKey := HKEY_LOCAL_MACHINE;
      Registro.Openkey('SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName', false);
      Result := Registro.ReadString('ComputerName');
    end;
    if (Result = '') and FileExists('Terminal.txt') then
    begin
      AssignFile(Texto, 'Terminal.txt');
      try
        Reset(Texto);
        Readln(Texto, Info);
      finally
        CloseFile(Texto);
      end;
      Result := Info;
    end;
  except
    Result:= ('Não foi possível encontrar o nome do computador! Por favor entre em contato com o suporte!');
  end;
end;

function TDM.RetornarDocumentoEmpresa: String;
var
  oSql: TRxQuery;
begin
  oSql:= TRxQuery.Create(nil);
  oSql.DatabaseName := DB.Name;
  oSql.SQL.Text := 'SELECT EMPRA14CGC FROM EMPRESA';
  oSql.Open;
  try
    Result := oSql.FieldByName('EMPRA14CGC').AsString;
  finally
    oSQl.Close;
    FreeandNil(oSql);
  end;    
end;

function TDM.RetornarNomeTerminal: String;
var
  oSql: TRxQuery;
begin
  if fNomeComputador = EmptyStr then
  begin
    Result := EmptyStr;
    Exit;
  end;   

  oSql:= TRxQuery.Create(nil);
  oSql.DatabaseName := DB.Name;
  oSql.SQL.Text := 'select TERMA60DESCR from TERMINAL where TERMA60NOMECOMPUT = '+ QuotedStr(fNomeComputador);
  oSql.Open;
  try
    Result := oSql.FieldByName('TERMA60DESCR').AsString;
  finally
    oSQl.Close;
    FreeandNil(oSql);
  end;
end;

function TDM.RetornarUltimaAtualizacao: String;
var
  Texto: TextFile;
begin
  if not FileExists('UltimaAtualizacao.txt') then
  begin
    Result := '';
    exit;
  end;

  AssignFile(Texto, 'UltimaAtualizacao.txt');
  try
   Reset(Texto);
   Readln(Texto, Result);
  finally
    CloseFile(Texto);
  end;
end;

end.
