unit uCadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Data.DB, Datasnap.DBClient,
  uLog, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, Aspect4D, Vcl.ExtCtrls;

type
  TfrmCliente = class(TForm)
    cdsCliente: TClientDataSet;
    ActionList1: TActionList;
    actSalvar: TAction;
    cdsClienteNOME: TStringField;
    cdsClienteTELEFONE: TStringField;
    cdsClienteEMAIL: TStringField;
    cdsClienteID: TAutoIncField;
    dtsCliente: TDataSource;
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
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FAspectContext: IAspectContext;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCliente: TfrmCliente;

implementation

{$R *.dfm}

uses Aspect4D.Impl, uPerformance, uPerformanceAspect,  ULogAspect;

procedure TfrmCliente.FormCreate(Sender: TObject);
begin
  cdsCliente.CreateDataSet;
  FAspectContext := TAspectContext.Create;
  FAspectContext.Register(TPerformanceAspect.Create);
  FAspectContext.Register(TLogAspect.Create(PegarLog));
  FAspectContext.Weaver.Proxify(cdsCliente);

  dtsPerformance.DataSet := PegarPerformanceCheck.PegarDataSetInterno;
  dtsLog.DataSet := PegarLog.PegarDataSetLog;
end;

procedure TfrmCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dtsPerformance.DataSet := nil;
  dtsLog.DataSet := nil;
end;

end.
