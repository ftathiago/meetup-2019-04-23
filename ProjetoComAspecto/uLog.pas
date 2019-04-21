unit uLog;

interface

uses
  DataSnap.DBClient, DB;

type
  TTipoLog = (tlInfo, tlAviso, tlErro);

  TTipoLogHelper = record helper for TTipoLog
    function AsByte: Byte;
  end;

  ILog = Interface(IInterface)
    procedure AdicionarMensagem(const Tipo: TTipoLog; const Mensagem: string);
    function PegarDataSetLog: TDataSet;
  end;

  TLog = class(TInterfacedObject, ILog)
  private
    FcdsLog: TClientDataSet;
    FTipoMensagem: TField;
    FMensagem: TField;
    procedure ConfigurarCdsLog;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AdicionarMensagem(const Tipo: TTipoLog; const Mensagem: string);
    function PegarDataSetLog: TDataSet;
  end;

function PegarLog: ILog;

implementation

var
  _log: ILog;

function PegarLog: ILog;
begin
  if not Assigned(_log) then
    _log := TLog.Create;
  Result := _log;
end;

constructor TLog.Create;
begin
  FcdsLog := TClientDataSet.Create(nil);
  ConfigurarCdsLog;
end;

destructor TLog.Destroy;
begin
  FcdsLog.Close;
  FcdsLog.Free;
  inherited;
end;

function TLog.PegarDataSetLog: TDataSet;
begin
  Result := FcdsLog;
end;

procedure TLog.ConfigurarCdsLog;
const
  OBRIGATORIO = true;
  SEM_TAMANHO_DEFINIDO = 0;
  CAMPO_TAMANHO_STRING = 500;
begin
  FcdsLog.FieldDefs.Add('id', ftAutoInc, SEM_TAMANHO_DEFINIDO, not OBRIGATORIO);
  FcdsLog.FieldDefs.Add('TipoMensagem', ftInteger, SEM_TAMANHO_DEFINIDO, OBRIGATORIO);
  FcdsLog.FieldDefs.Add('Mensagem', ftString, CAMPO_TAMANHO_STRING, OBRIGATORIO);
  FcdsLog.CreateDataSet;
  FTipoMensagem := FcdsLog.FieldByName('TipoMensagem');
  FMensagem := FcdsLog.FieldByName('Mensagem');
  FcdsLog.IndexFieldNames := 'ID';
end;

procedure TLog.AdicionarMensagem(const Tipo: TTipoLog; const Mensagem: string);
begin
  FcdsLog.Insert;
  FTipoMensagem.AsInteger := Tipo.AsByte;
  FMensagem.AsString := Mensagem;
  FcdsLog.Post;
end;

{ TTipoLogHelper }

function TTipoLogHelper.AsByte: Byte;
begin
  Result := ord(Self);
end;

end.
