object DM: TDM
  OldCreateOrder = False
  Left = 400
  Top = 125
  Height = 409
  Width = 595
  object DB: TDatabase
    AliasName = 'Easy_Gestao'
    DatabaseName = 'DB'
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=SYSDBA'
      'PASSWORD=masterkey')
    SessionName = 'Default'
    Left = 32
    Top = 8
  end
  object sqlCONFIG_ATUALIZADOR: TRxQuery
    DatabaseName = 'DB'
    SQL.Strings = (
      'SELECT * FROM CONFIG_ATUALIZADOR')
    Macros = <>
    Left = 112
    Top = 28
    object sqlCONFIG_ATUALIZADORAPP: TStringField
      FieldName = 'APP'
      Origin = 'DB.CONFIG_ATUALIZADOR.APP'
      Size = 100
    end
    object sqlCONFIG_ATUALIZADORBASE_URL: TStringField
      FieldName = 'BASE_URL'
      Origin = 'DB.CONFIG_ATUALIZADOR.BASE_URL'
      Size = 200
    end
    object sqlCONFIG_ATUALIZADORCAD_VERSAO: TStringField
      FieldName = 'CAD_VERSAO'
      Origin = 'DB.CONFIG_ATUALIZADOR.CAD_VERSAO'
      Size = 100
    end
    object sqlCONFIG_ATUALIZADORFTP: TStringField
      FieldName = 'FTP'
      Origin = 'DB.CONFIG_ATUALIZADOR.FTP'
      Size = 200
    end
    object sqlCONFIG_ATUALIZADORCONSULTA_VERSAO: TStringField
      FieldName = 'CONSULTA_VERSAO'
      Origin = 'DB.CONFIG_ATUALIZADOR.CONSULTA_VERSAO'
      Size = 200
    end
    object sqlCONFIG_ATUALIZADORVERSAO_ATUAL: TStringField
      FieldName = 'VERSAO_ATUAL'
      Origin = 'DB.CONFIG_ATUALIZADOR.VERSAO_ATUAL'
      Size = 200
    end
    object sqlCONFIG_ATUALIZADORFTP_USER: TStringField
      FieldName = 'FTP_USER'
      Origin = 'DB.CONFIG_ATUALIZADOR.FTP_USER'
      Size = 30
    end
    object sqlCONFIG_ATUALIZADORFTP_PASS: TStringField
      FieldName = 'FTP_PASS'
      Origin = 'DB.CONFIG_ATUALIZADOR.FTP_PASS'
      Size = 30
    end
  end
end
