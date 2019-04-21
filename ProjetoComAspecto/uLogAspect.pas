unit uLogAspect;

interface

uses
  System.Rtti, System.SysUtils, Aspect4D, uLog;

type
  TLogAspect = class(TAspect, IAspect)
  private
    FLog: ILog;
    function PodeExecutar(const method: TRttiMethod): boolean;
  public
    constructor Create(const LogObject: ILog);
    procedure DoAfter(instance: TObject; method: TRttiMethod;
      const args: System.TArray<System.Rtti.TValue>; var result: TValue);
    procedure DoBefore(instance: TObject; method: TRttiMethod;
      const args: System.TArray<System.Rtti.TValue>; out invoke: boolean; out result: TValue);
    procedure DoException(instance: TObject; method: TRttiMethod;
      const args: System.TArray<System.Rtti.TValue>; out raiseException: boolean;
      theException: Exception; out result: TValue);
    function GetName: string;
  end;

implementation

const
  MENSAGEM_INICIO = 'O método %s foi iniciado';
  MENSAGEM_SUCESSO = 'O método %s foi executado com sucesso.';
  MENSAGEM_ERRO = 'O método %s finalizou com erro [%s - %s]!';

constructor TLogAspect.Create(const LogObject: ILog);
begin
  FLog := LogObject;
end;

procedure TLogAspect.DoAfter(instance: TObject; method: TRttiMethod;
  const args: System.TArray<System.Rtti.TValue>; var result: TValue);
begin
  if not PodeExecutar(method) then
    Exit;
  FLog.AdicionarMensagem(tlInfo, Format(MENSAGEM_SUCESSO, [method.Name]));
end;

procedure TLogAspect.DoBefore(instance: TObject; method: TRttiMethod;
  const args: System.TArray<System.Rtti.TValue>; out invoke: boolean; out result: TValue);
begin
  if not PodeExecutar(method) then
    Exit;
  FLog.AdicionarMensagem(tlInfo, Format(MENSAGEM_INICIO, [method.Name]));
end;

procedure TLogAspect.DoException(instance: TObject; method: TRttiMethod;
  const args: System.TArray<System.Rtti.TValue>; out raiseException: boolean;
  theException: Exception; out result: TValue);
begin
  if not PodeExecutar(method) then
    Exit;
  FLog.AdicionarMensagem(tlErro, Format(MENSAGEM_ERRO, [method.Name, theException.ClassName,
    theException.Message]));
end;

function TLogAspect.GetName: string;
begin
  result := QualifiedClassName;
end;

function TLogAspect.PodeExecutar(const method: TRttiMethod): boolean;
var
  _methodName: string;
begin
  result := False;
  _methodName := method.Name.ToUpper;

  if _methodName.Equals('POST') then
    Exit(True);

  if _methodName.Equals('DOBEFOREDELETE') then
    Exit(True);

  if _methodName.Equals('DOAFTERDELETE') then
    Exit(True);
end;

end.
