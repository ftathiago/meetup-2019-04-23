unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Data.DB, Datasnap.DBClient,
  uLog, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls;

type
  TfrmCliente = class(TForm)
    cdsCliente: TClientDataSet;
    ActionList1: TActionList;
    actSalvar: TAction;
    cdsClienteNOME: TStringField;
    cdsClienteTELEFONE: TStringField;
    cdsClienteEMAIL: TStringField;
    cdsClienteID: TAutoIncField;
    DataSource1: TDataSource;
    Button1: TButton;
    dbgPerformance: TDBGrid;
    dtsPerformance: TDataSource;
    dbgLog: TDBGrid;
    dtsLog: TDataSource;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    procedure actSalvarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FLog: ILog;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCliente: TfrmCliente;

implementation

{$R *.dfm}

uses uPerformance;

procedure TfrmCliente.actSalvarExecute(Sender: TObject);
begin
  PegarPerformanceCheck.IniciarContagemParaOMetodo('actSalvarExecute');
  try
    FLog.AdicionarMensagem(tlInfo, 'Salvando Cliente');
    try
      cdsCliente.Post;
      FLog.AdicionarMensagem(tlInfo, 'Cliente salvo!');
    except
      on E: Exception do
      begin
        FLog.AdicionarMensagem(tlErro, 'Erro ao salvar: ' + E.Message);
        raise;
      end;
    end;
  finally
    PegarPerformanceCheck.PararContagemParaOMetodo('actSalvarExecute');
  end;
end;

procedure TfrmCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dtsPerformance.DataSet := nil;
  dtsLog.DataSet := nil;
end;

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
  cdsCliente.CreateDataSet;
  dtsPerformance.DataSet := PegarPerformanceCheck.PegarDataSetInterno;
  FLog := TLog.Create;
  dtsLog.DataSet := FLog.PegarDataSetLog;
end;

end.
