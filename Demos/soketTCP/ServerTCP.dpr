program ServerTCP;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMainFormServer in 'uMainFormServer.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;

  ReportMemoryLeaksOnShutdown := True;

  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
