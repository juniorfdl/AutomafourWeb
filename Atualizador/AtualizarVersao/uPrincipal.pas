unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  AtualizarVersao.Interfaces, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, Vcl.StdCtrls;

type
  TfPrincipal = class(TForm)
    pConfirmar: TPanel;
    pStatus: TPanel;
    SpeedButton1: TSpeedButton;
    ProgressBar1: TProgressBar;
    MemoStatus: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure HabilitarConfirmar;
    procedure HabilitarStatus;
    procedure ExecutarAtualizacao;
    procedure AtualizarStatus(const Value: String; const Posicao, Max: Integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPrincipal: TfPrincipal;

implementation

{$R *.dfm}

procedure TfPrincipal.AtualizarStatus(const Value: String; const Posicao, Max: Integer);
begin
  MemoStatus.Text := Value;

  if Max > 0 then
    ProgressBar1.Max := Max
  else
    ProgressBar1.Max := 100;

  ProgressBar1.Position := Posicao;

  {if (Posicao = 0)or(ProgressBar1.Position >= ProgressBar1.Max) then
    ProgressBar1.Position := 0
  else
    ProgressBar1.Position := ProgressBar1.Position + 1; }

  Application.ProcessMessages;
end;

procedure TfPrincipal.ExecutarAtualizacao;
begin
  try
    oAtualizarVersaoFacade.SetStatus(AtualizarStatus);
    oAtualizarVersaoFacade.AtualizarVersao;
  except
    on E: Exception do
    begin
      AtualizarStatus(E.Message,0,0);
      oAtualizarVersaoFacade.GravarErro(E.Message);
      raise;
    end;
  end;
  AtualizarStatus('Sistema atualizado com sucesso',0,0);
  Sleep(2000);
  Close;
end;

procedure TfPrincipal.FormCreate(Sender: TObject);
begin
  HabilitarConfirmar;
end;

procedure TfPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
    Close;
end;

procedure TfPrincipal.HabilitarConfirmar;
begin
  pConfirmar.Visible := True;
  pConfirmar.Align := alClient;
  pStatus.Visible := False;
  pStatus.Align := alNone;
end;

procedure TfPrincipal.HabilitarStatus;
begin
  pConfirmar.Visible := False;
  pConfirmar.Align := alNone;
  pStatus.Visible := True;
  pStatus.Align := alClient;
end;

procedure TfPrincipal.SpeedButton1Click(Sender: TObject);
begin
  HabilitarStatus;
  ExecutarAtualizacao;
end;

end.
