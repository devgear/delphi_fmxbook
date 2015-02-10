unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls3D, FMX.Layers3D,
  FMX.MaterialSources, FMX.Objects3D, System.Math.Vectors;

type
  TForm1 = class(TForm3D)
    Plane1: TPlane;
    TextureMaterialSource1: TTextureMaterialSource;
    Plane2: TPlane;
    Plane3: TPlane;
    Plane4: TPlane;
    TextureMaterialSource2: TTextureMaterialSource;
    TextureMaterialSource3: TTextureMaterialSource;
    TextureMaterialSource4: TTextureMaterialSource;
    procedure Plane1Click(Sender: TObject);
    procedure Plane4Click(Sender: TObject);
    procedure Plane2Click(Sender: TObject);
    procedure Plane3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Plane1Click(Sender: TObject);
begin
  Plane1.AnimateFloat('RotationAngle.Y', Plane1.RotationAngle.Y+360,0.5);
end;

procedure TForm1.Plane2Click(Sender: TObject);
begin
  Plane2.AnimateFloat('RotationAngle.Z',Plane1.RotationAngle.Z+360,0.5);
end;

procedure TForm1.Plane3Click(Sender: TObject);
begin
  Plane3.AnimateFloat('RotationAngle.X',Plane1.RotationAngle.X+360,0.5);
end;

procedure TForm1.Plane4Click(Sender: TObject);
begin
  Plane4.AnimateFloat('RotationAngle.X',Plane1.RotationAngle.X+360,0.5);
end;

end.
