object fPrincipal: TfPrincipal
  Left = 0
  Top = 0
  ActiveControl = pConfirmar
  BorderIcons = [biSystemMenu]
  Caption = 'Automafour - Existem atualiza'#231#245'es pendentes'
  ClientHeight = 97
  ClientWidth = 704
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pConfirmar: TPanel
    Left = 0
    Top = 0
    Width = 331
    Height = 97
    Align = alLeft
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 1
      Top = 1
      Width = 329
      Height = 95
      Hint = 'Existem atualiza'#231#245'es, deseja atualizar? '
      Align = alClient
      Caption = 'Deseja atualizar? '
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton1Click
      ExplicitLeft = 45
      ExplicitTop = 60
      ExplicitWidth = 136
      ExplicitHeight = 22
    end
  end
  object pStatus: TPanel
    Left = 331
    Top = 0
    Width = 373
    Height = 97
    Align = alClient
    TabOrder = 1
    object ProgressBar1: TProgressBar
      Left = 1
      Top = 60
      Width = 371
      Height = 36
      Align = alBottom
      TabOrder = 0
    end
    object MemoStatus: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 365
      Height = 53
      Align = alClient
      Alignment = taCenter
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
    end
  end
end
