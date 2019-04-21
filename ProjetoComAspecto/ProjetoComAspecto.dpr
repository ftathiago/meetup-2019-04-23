program ProjetoComAspecto;

uses
  Vcl.Forms,
  uCadCliente in 'uCadCliente.pas' {frmCliente},
  uLog in 'uLog.pas',
  uPerformance in 'uPerformance.pas',
  Vcl.Themes,
  Vcl.Styles,
  uPerformanceAspect in 'uPerformanceAspect.pas',
  uLogAspect in 'uLogAspect.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCliente, frmCliente);
  Application.Run;
end.
