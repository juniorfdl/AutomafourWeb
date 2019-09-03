program GravarVersao;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.JSON,
  System.Classes,
  Luar.Utils.VersaoApp in '..\Luar\Luar.Utils.VersaoApp.pas',
  Luar.RestApi.Client.Impl in '..\Luar\Luar.RestApi.Client.Impl.pas',
  Luar.RestApi.Client.Interfaces in '..\Luar\Luar.RestApi.Client.Interfaces.pas',
  Luar.Utils.SmartPointer in '..\Luar\Luar.Utils.SmartPointer.pas',
  DadosConf in '..\AtualizarVersao\DadosConf.pas';

var
  vObs, vVersao:String;
  JsonPost: TSmartPointer<TJSONObject>;
  oConf: TSmartPointer<TStringList>;
  fDadosConf: TDadosConf;

  procedure GetConf;
  begin
    fDadosConf := TDadosConf.New(ExtractFilePath(ParamStr(0))+'\Conf.Json');
  end;

begin
  try
    Writeln('Deseja informar uma observação para versão?');
    ReadLn(vObs);

    GetConf;

    Writeln('Gravando Versão . . .');
    vVersao := TLuarUtilsVersaoApp.GetVersao(ExtractFilePath(ParamStr(0)) + fDadosConf.APP + '.exe');

    JsonPost.Value.AddPair('VERSAO',vVersao);
    JsonPost.Value.AddPair('OBSERVACAO',vObs);
    JsonPost.Value.AddPair('NOME_APP', fDadosConf.APP);
    JsonPost.Value.AddPair('FTP', fDadosConf.FTP);
    JsonPost.Value.AddPair('FTP_USER', fDadosConf.FTP_USER);
    JsonPost.Value.AddPair('FTP_PASS', fDadosConf.FTP_PASS);

    TLuarRestApiClientImpl.New(fDadosConf.BASE_URL)
        .SetResource(fDadosConf.CAD_VERSAO)
        .Post(JsonPost);

    fDadosConf.Free;
    Writeln('Operação finalizada com sucesso!');
    Writeln('Precione enter para sair');
    ReadLn;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
