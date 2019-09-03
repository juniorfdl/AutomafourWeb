unit DadosConf;

interface

uses System.SysUtils, Luar.Utils.SmartPointer, System.JSON,
  System.Classes,
  ormbr.jsonutils.DataSnap,
  ormbr.rest.Json,
  ormbr.mapping.attributes;

type
  [Entity]
  TDadosConf = class
  Strict private
    fBASE_URL:String;
    fCAD_VERSAO:String;
    fAPP:String;
    fFTP:String;
    fCONSULTA_VERSAO:String;
    fVERSAO_ATUAL:String;
    fFTP_PASS: String;
    fFTP_USER: String;
    fDATA_ATUALIZACAO: String;
    fDOC_CLI: String;
  public
    property BASE_URL: String read fBASE_URL write fBASE_URL;
    property CAD_VERSAO: String read fCAD_VERSAO write fCAD_VERSAO;
    property APP: String read fAPP write fAPP;
    property FTP: String read fFTP write fFTP;
    property CONSULTA_VERSAO: String read fCONSULTA_VERSAO write fCONSULTA_VERSAO;
    property VERSAO_ATUAL: String read fVERSAO_ATUAL write fVERSAO_ATUAL;
    property FTP_USER:String read fFTP_USER write fFTP_USER;
    property FTP_PASS:String read fFTP_PASS write fFTP_PASS;
    property DOC_CLI:String read fDOC_CLI write fDOC_CLI;
    property DATA_ATUALIZACAO:String read fDATA_ATUALIZACAO write fDATA_ATUALIZACAO;

    class function New(const pPath:String): TDadosConf;
  end;

implementation

{ TDadosConf }

class function TDadosConf.New(const pPath: String): TDadosConf;
var
  oConf: TSmartPointer<TStringList>;
begin
  oConf.Value.LoadFromFile(pPath);
  Result:= TORMBrJson.JsonToObject<TDadosConf>(oConf.Value.Text);
end;

end.
