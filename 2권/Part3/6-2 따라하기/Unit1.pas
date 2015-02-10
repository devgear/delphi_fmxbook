unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Viewport3D, FMX.Controls3D, FMX.Objects3D,
  FMX.StdCtrls, FMX.Layouts;

type
  TForm1 = class(TForm)
    MViewport3D: TViewport3D;
    StatusBar1: TStatusBar;
    MyGrid3D: TGrid3D;
    Button1: TButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Layout1: TLayout;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  MyGrid3D.RotationAngle.X := MyGrid3D.RotationAngle.X + 20;
end;

end.
