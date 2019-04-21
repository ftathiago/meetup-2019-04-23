unit uPerformanceAspect;

interface

uses
  System.SysUtils, System.Rtti, Aspect4D;

type
  TPerformanceAspect = class(TAspect, IAspect)
  private
    function PodeExecutar(const method: TRttiMethod): boolean;
  public
    function GetName: string;

    procedure DoAfter(instance: TObject; method: TRttiMethod;
      const args: System.TArray<System.Rtti.TValue>; var result: TValue);
    procedure DoBefore(instance: TObject; method: TRttiMethod;
      const args: System.TArray<System.Rtti.TValue>; out invoke: boolean; out result: TValue);

    procedure DoException(instance: TObject; method: TRttiMethod;
      const args: System.TArray<System.Rtti.TValue>; out raiseException: boolean;
      theException: Exception; out result: TValue);
  end;

implementation

uses
  uPerformance;

procedure TPerformanceAspect.DoAfter(instance: TObject; method: TRttiMethod;
  const args: System.TArray<System.Rtti.TValue>; var result: TValue);
begin
  if not PodeExecutar(method) then
    Exit;
  PegarPerformanceCheck.PararContagemParaOMetodo(method.Name);
end;

procedure TPerformanceAspect.DoBefore(instance: TObject; method: TRttiMethod;
  const args: System.TArray<System.Rtti.TValue>; out invoke: boolean; out result: TValue);
begin
  if not PodeExecutar(method) then
    Exit;
  PegarPerformanceCheck.IniciarContagemParaOMetodo(method.Name);
end;

procedure TPerformanceAspect.DoException(instance: TObject; method: TRttiMethod;
  const args: System.TArray<System.Rtti.TValue>; out raiseException: boolean;
  theException: Exception; out result: TValue);
begin
  if not PodeExecutar(method) then
    Exit;
  PegarPerformanceCheck.PararContagemParaOMetodo(method.Name);
end;

function TPerformanceAspect.GetName: string;
begin
  result := QualifiedClassName;
end;

function TPerformanceAspect.PodeExecutar(const method: TRttiMethod): boolean;
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
