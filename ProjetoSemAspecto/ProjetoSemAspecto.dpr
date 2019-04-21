program ProjetoSemAspecto;

uses
  Vcl.Forms,
  uCadCliente in 'uCadCliente.pas' {frmCliente},
  uLog in 'uLog.pas',
  uPerformance in 'uPerformance.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Charcoal Dark Slate');
  Application.CreateForm(TfrmCliente, frmCliente);
  Application.Run;
end.
