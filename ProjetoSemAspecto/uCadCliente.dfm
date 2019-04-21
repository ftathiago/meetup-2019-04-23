object frmCliente: TfrmCliente
  Left = 0
  Top = 0
  Caption = 'frmCliente'
  ClientHeight = 594
  ClientWidth = 684
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
    Top = 445
    Width = 17
    Height = 13
    Caption = 'Log'
  end
  object Label5: TLabel
    Left = 16
    Top = 285
    Width = 61
    Height = 13
    Caption = 'Performance'
  end
  object Button1: TButton
    Left = 441
    Top = 147
    Width = 75
    Height = 25
    Action = actSalvar
    TabOrder = 3
  end
  object dbgPerformance: TDBGrid
    Left = 16
    Top = 304
    Width = 657
    Height = 120
    TabStop = False
    DataSource = dtsPerformance
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dbgLog: TDBGrid
    Left = 16
    Top = 464
    Width = 657
    Height = 120
    TabStop = False
    DataSource = dtsLog
    ReadOnly = True
    TabOrder = 5
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
    DataSource = DataSource1
    TabOrder = 0
  end
  object DBEdit2: TDBEdit
    Left = 16
    Top = 80
    Width = 147
    Height = 21
    DataField = 'TELEFONE'
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 16
    Top = 120
    Width = 500
    Height = 21
    DataField = 'EMAIL'
    DataSource = DataSource1
    TabOrder = 2
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
      OnExecute = actSalvarExecute
    end
  end
  object DataSource1: TDataSource
    DataSet = cdsCliente
    Left = 584
    Top = 368
  end
  object dtsPerformance: TDataSource
    Left = 912
    Top = 120
  end
  object dtsLog: TDataSource
    Left = 104
    Top = 520
  end
end
