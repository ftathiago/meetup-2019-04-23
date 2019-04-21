unit uPerformance;

interface

uses
  Data.DB, Datasnap.DBClient, System.Generics.Collections;

type
  IPerformanceCheck = interface(IInterface)
    ['{8A7EC44F-CF9A-44E1-A43A-981650F5BCA8}']
    procedure IniciarContagemParaOMetodo(const NomeDoMetodo: string);
    procedure PararContagemParaOMetodo(const NomeDoMetodo: string);
    function PegarDataSetInterno: TDataSet;
  end;

  TPerformanceMetodo = class
    Nome: string;
    Profundidade: integer;
    Inicio: int64;
    Fim: int64;
  end;

  TPerformanceCheck = class(TInterfacedObject, IPerformanceCheck)
  private
    FcdsPerformance: TClientDataSet;
    FNomeMetodo: TField;
    FTempoExecucao: TField;
    FPilhaProfundidade: integer;
    FContagem: TDictionary<string, TPerformanceMetodo>;
    FCampoProfundidade: TField;
    procedure ConfigurarDataSet;
    procedure RegistrarPerformance(const Metodo: TPerformanceMetodo);
  public
    constructor Create;
    destructor Destroy; override;
    procedure IniciarContagemParaOMetodo(const NomeDoMetodo: string);
    procedure PararContagemParaOMetodo(const NomeDoMetodo: string);
    function PegarDataSetInterno: TDataSet;
  end;

function PegarPerformanceCheck: IPerformanceCheck;

implementation

uses
  Winapi.Windows, System.SysUtils;

var
  _performanceCheck: IPerformanceCheck;

function PegarPerformanceCheck: IPerformanceCheck;
begin
  if not Assigned(_performanceCheck) then
    _performanceCheck := TPerformanceCheck.Create;
  result := _performanceCheck;
end;

constructor TPerformanceCheck.Create;
var
  _frequency64: int64;
begin
  inherited;
  QueryPerformanceFrequency(_frequency64);
  if _frequency64 = 0 then
    raise Exception.Create('O sistema operacional não suporta análise de performance');
  FContagem := TDictionary<string, TPerformanceMetodo>.Create;
  FcdsPerformance := TClientDataSet.Create(nil);
  ConfigurarDataSet;
  FPilhaProfundidade := 0;
end;

procedure TPerformanceCheck.ConfigurarDataSet;
const
  SEM_TAMANHO_DEFINIDO = 0;
  CAMPO_OBRIGATORIO = True;
  TAMANHO_MAXIMO_NOME_METODO = 500;
begin
  FcdsPerformance.FieldDefs.Add('id', ftAutoInc, SEM_TAMANHO_DEFINIDO, not CAMPO_OBRIGATORIO);
  FcdsPerformance.FieldDefs.Add('NOME_METODO', ftString, TAMANHO_MAXIMO_NOME_METODO,
    CAMPO_OBRIGATORIO);
  FcdsPerformance.FieldDefs.Add('TEMPO_EXECUCAO', ftInteger, SEM_TAMANHO_DEFINIDO,
    CAMPO_OBRIGATORIO);
  FcdsPerformance.FieldDefs.Add('PROFUNDIDADE', ftInteger, SEM_TAMANHO_DEFINIDO, CAMPO_OBRIGATORIO);
  FcdsPerformance.CreateDataSet;
  FNomeMetodo := FcdsPerformance.FieldByName('NOME_METODO');
  FTempoExecucao := FcdsPerformance.FindField('TEMPO_EXECUCAO');
  FCampoProfundidade := FcdsPerformance.FindField('PROFUNDIDADE');
  FcdsPerformance.IndexFieldNames := 'ID';
end;

destructor TPerformanceCheck.Destroy;
begin
  FcdsPerformance.Close;
  FcdsPerformance.Free;
  inherited;
end;

procedure TPerformanceCheck.IniciarContagemParaOMetodo(const NomeDoMetodo: string);
var
  _metodo: TPerformanceMetodo;
  _inicio: int64;
begin
  _metodo := TPerformanceMetodo.Create;
  _metodo.Nome := NomeDoMetodo;
  _metodo.Profundidade := FPilhaProfundidade;
  QueryPerformanceCounter(_inicio);
  _metodo.Inicio := _inicio;
  FContagem.Add(NomeDoMetodo, _metodo);
  inc(FPilhaProfundidade);
end;

procedure TPerformanceCheck.PararContagemParaOMetodo(const NomeDoMetodo: string);
var
  _metodo: TPerformanceMetodo;
  _fim: int64;
begin
  _metodo := FContagem.Items[NomeDoMetodo];
  try
    QueryPerformanceCounter(_fim);
    _metodo.Fim := _fim;
    RegistrarPerformance(_metodo);
  finally
    Dec(FPilhaProfundidade);
    FContagem.Remove(NomeDoMetodo);
    _metodo.Free;
  end;
end;

procedure TPerformanceCheck.RegistrarPerformance(const Metodo: TPerformanceMetodo);
begin
  FcdsPerformance.Insert;
  FNomeMetodo.AsString := Metodo.Nome;
  FTempoExecucao.AsInteger := Metodo.Fim - Metodo.Inicio;
  FCampoProfundidade.AsInteger := FPilhaProfundidade;
  FcdsPerformance.Post;
end;

function TPerformanceCheck.PegarDataSetInterno: TDataSet;
begin
  result := FcdsPerformance;
end;

end.
