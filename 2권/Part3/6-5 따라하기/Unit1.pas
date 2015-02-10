unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Viewport3D, FMX.Controls3D, FMX.Objects3D,
  FMX.StdCtrls, FMX.Layouts, FMX.MaterialSources, FMX.ListBox, FMX.Types3D,
  System.Math.Vectors;

type
  TForm1 = class(TForm)
    MViewport3D: TViewport3D;
    StatusBar1: TStatusBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Layout1: TLayout;
    Cylinder1: TCylinder;
    LightMaterialSource1: TLightMaterialSource;
    Light1: TLight;
    ComboBox1: TComboBox;
    Cylinder2: TCylinder;
    TextureMaterialSource1: TTextureMaterialSource;
    Cylinder3: TCylinder;
    Cylinder4: TCylinder;
    RoundCube1: TRoundCube;
    RoundCube2: TRoundCube;
    Cylinder5: TCylinder;
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

//******************************************************************
// TLightType 상수를 사용하기 위해서 Uses 절에 FMX.Types3D를 추가한다.
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
   case ComboBox1.ItemIndex of
     0 :  Light1.LightType := TLightType.ltDirectional;
     1 :  Light1.LightType := TLightType.ltPoint;
     2 :  Light1.LightType := TLightType.ltSpot;
   end;

   Light1.Repaint();
end;

end.
