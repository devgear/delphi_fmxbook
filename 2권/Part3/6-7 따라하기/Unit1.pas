unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.MaterialSources, FMX.Controls3D,
  FMX.Objects3D, FMX.Ani;

type
  TForm1 = class(TForm3D)
    EDummy: TDummy;
    EarthSphere: TSphere;
    MDummy: TDummy;
    MoonSphere: TSphere;
    FloatAnimation2: TFloatAnimation;
    FloatAnimation1: TFloatAnimation;
    Grid3D1: TGrid3D;
    SunSphere: TSphere;
    Light1: TLight;
    VDummy: TDummy;
    VenusSphere: TSphere;
    FloatAnimation3: TFloatAnimation;
    LightMaterialSource1: TLightMaterialSource;
    LightMaterialSource2: TLightMaterialSource;
    LightMaterialSource3: TLightMaterialSource;
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
