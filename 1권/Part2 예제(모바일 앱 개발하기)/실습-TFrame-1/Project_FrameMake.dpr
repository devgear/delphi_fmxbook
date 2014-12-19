program Project_FrameMake;

uses
  System.StartUpCopy,
  FMX.MobilePreview,
  FMX.Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {MyFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
