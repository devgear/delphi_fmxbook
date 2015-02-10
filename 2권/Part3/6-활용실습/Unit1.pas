unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.MaterialSources, FMX.Controls3D,
  FMX.Objects3D, FMX.Ani, FMX.Layers3D, FMX.StdCtrls, System.Math.Vectors,
  FMX.Types3D;

type
  TForm1 = class(TForm3D)
    RoadGrid3D: TGrid3D;
    CarBodyCube: TCube;
    Light1: TLight;
    LightMaterialSource1: TLightMaterialSource;
    WheelCylinder1: TCylinder;
    DirectionDummy: TDummy;
    WheelCylinder2: TCylinder;
    FloatAnimation_Wheel: TFloatAnimation;
    FloatAniRoad_XP: TFloatAnimation;
    LightMaterialSource2: TLightMaterialSource;
    Cube1: TCube;
    WheelDummy: TDummy;
    FloatAniRoad_Z: TFloatAnimation;
    FloatAniRoad_XM: TFloatAnimation;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


end.

