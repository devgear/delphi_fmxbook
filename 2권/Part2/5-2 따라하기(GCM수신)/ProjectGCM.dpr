program ProjectGCM;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  MainForm in 'MainForm.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
