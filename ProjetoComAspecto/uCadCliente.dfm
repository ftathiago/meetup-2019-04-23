object frmCliente: TfrmCliente
  Left = 0
  Top = 0
  Caption = 'frmCliente'
  ClientHeight = 518
  ClientWidth = 1084
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 27
    Height = 13
    Caption = 'Nome'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 16
    Top = 64
    Width = 42
    Height = 13
    Caption = 'Telefone'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 16
    Top = 104
    Width = 28
    Height = 13
    Caption = 'E-mail'
    FocusControl = DBEdit3
  end
  object Label4: TLabel
    Left = 16
    Top = 364
    Width = 17
    Height = 13
    Caption = 'Log'
  end
  object Label5: TLabel
    Left = 16
    Top = 204
    Width = 61
    Height = 13
    Caption = 'Performance'
  end
  object dbgPerformance: TDBGrid
    Left = 16
    Top = 223
    Width = 1049
    Height = 120
    TabStop = False
    DataSource = dtsPerformance
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dbgLog: TDBGrid
    Left = 16
    Top = 383
    Width = 1049
    Height = 120
    TabStop = False
    DataSource = dtsLog
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBEdit1: TDBEdit
    Left = 16
    Top = 40
    Width = 500
    Height = 21
    DataField = 'NOME'
    DataSource = dtsCliente
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 16
    Top = 80
    Width = 147
    Height = 21
    DataField = 'TELEFONE'
    DataSource = dtsCliente
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 16
    Top = 120
    Width = 500
    Height = 21
    DataField = 'EMAIL'
    DataSource = dtsCliente
    TabOrder = 2
  end
  object DBGrid1: TDBGrid
    Left = 522
    Top = 24
    Width = 543
    Height = 148
    DataSource = dtsCliente
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NOME'
        Width = 500
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 276
    Top = 147
    Width = 240
    Height = 25
    DataSource = dtsCliente
    TabOrder = 6
  end
  object cdsCliente: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 16
    Top = 152
    object cdsClienteID: TAutoIncField
      FieldName = 'ID'
    end
    object cdsClienteNOME: TStringField
      FieldName = 'NOME'
      Size = 500
    end
    object cdsClienteTELEFONE: TStringField
      FieldName = 'TELEFONE'
      Size = 11
    end
    object cdsClienteEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 500
    end
  end
  object ActionList1: TActionList
    Left = 72
    Top = 152
    object actSalvar: TAction
      Caption = 'Salvar'
    end
  end
  object dtsCliente: TDataSource
    DataSet = cdsCliente
    Left = 200
    Top = 72
  end
  object dtsPerformance: TDataSource
    Left = 120
    Top = 263
  end
  object dtsLog: TDataSource
    Left = 104
    Top = 439
  end
end
