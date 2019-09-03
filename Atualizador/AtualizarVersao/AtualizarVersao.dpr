program AtualizarVersao;

uses
  Vcl.Forms,
  Dialogs,
  System.SysUtils,
  uPrincipal in 'uPrincipal.pas' {fPrincipal},
  Luar.RestApi.Client.Impl in '..\Luar\Luar.RestApi.Client.Impl.pas',
  Luar.RestApi.Client.Interfaces in '..\Luar\Luar.RestApi.Client.Interfaces.pas',
  Luar.Utils.SmartPointer in '..\Luar\Luar.Utils.SmartPointer.pas',
  Luar.Utils.VersaoApp in '..\Luar\Luar.Utils.VersaoApp.pas',
  AtualizarVersao.Facade in 'AtualizarVersao.Facade.pas',
  DadosConf in 'DadosConf.pas' {$R *.res},
  AtualizarVersao.Interfaces in 'AtualizarVersao.Interfaces.pas',
  Luar.Utils.FTP in '..\Luar\Luar.Utils.FTP.pas',
  Luar.Utils.FTP.Interfaces in '..\Luar\Luar.Utils.FTP.Interfaces.pas',
  AtualizarVersao.Eventos in 'AtualizarVersao.Eventos.pas';

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  oAtualizarVersaoFacade:= TAtualizarVersaoFacade.New('', '');

  if oAtualizarVersaoFacade.ClienteAtualizado then
    exit;

  Application.CreateForm(TfPrincipal, fPrincipal);
  Application.Run;
end.
