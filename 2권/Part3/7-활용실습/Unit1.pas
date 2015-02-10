unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls3D, FMX.Layers3D, FMX.StdCtrls,
  FMX.Viewport3D, System.Math.Vectors;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    StatusBar1: TStatusBar;
    MViewport3D: TViewport3D;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    Image3D_Sample: TImage3D;
    procedure TrackBar1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Camera_Init;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  MyCamera : TCamera;

implementation

{$R *.fmx}


procedure TForm1.FormCreate(Sender: TObject);
begin
  Camera_Init;
end;


procedure TForm1.Camera_Init;
begin
  MyCamera := TCamera.Create(nil);
  MyCamera.Parent := MViewport3D;
  MyCamera.Position.Z := -100;
  MViewport3D.Camera := MyCamera;
  MViewport3D.UsingDesignCamera := FALSE;

  TrackBar1.Min := -200;
  TrackBar1.Max := -5;
  TrackBar1.Value := -100;
end;


procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  MyCamera.Position.Z  := TrackBar1.Value;
end;

end.
