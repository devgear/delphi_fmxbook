unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls3D, FMX.MaterialSources, FMX.Objects3D,
  FMX.Layouts, FMX.Viewport3D, FMX.StdCtrls, FMX.Ani, System.Math.Vectors,
  FMX.Types3D;

type
  TForm1 = class(TForm)
    MViewport3D: TViewport3D;
    Layout1: TLayout;
    Grid3D1: TGrid3D;
    Cone1: TCone;
    Camera1: TCamera;
    Light1: TLight;
    LabelZ: TLabel;
    AngleZ_TrackBar: TTrackBar;
    LightMaterialSource1: TLightMaterialSource;
    Cylinder1: TCylinder;
    Cylinder2: TCylinder;
    AngleX_TrackBar: TTrackBar;
    LabelX: TLabel;
    CheckBox1: TCheckBox;
    CameraAniButton: TButton;
    procedure AngleX_TrackBarChange(Sender: TObject);
    procedure AngleZ_TrackBarChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CameraAniButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure Add_Camera;
    procedure CameraInit;
  public
    { Public declarations }

  end;

var
  Form1: TForm1;
  Camera2 : TCamera;
  CrDummy : TDummy;

implementation

{$R *.fmx}

// 추가 카메라 ---------------------------------------------
procedure TForm1.Add_Camera;
begin
  CrDummy := TDummy.Create(nil);
  CrDummy.Parent := MViewport3D;

  Camera2 := TCamera.Create(nil);
  Camera2.Parent := CrDummy;
  Camera2.Target := Cone1;
  Camera2.Position.Vector := Vector3D( 10,-10,15);
end;

//*********************************************************
procedure TForm1.CameraAniButtonClick(Sender: TObject);
var
  crAni : TFloatAnimation;    // FMX.Ani
begin
  crAni := TFloatAnimation.Create(nil);
  crAni.Parent := CrDummy;
  crAni.PropertyName := 'RotationAngle.Y';
  crAni.StartValue := 0;
  crAni.StartValue := 360;
  crAni.Duration := 6;
  crAni.Start;
end;

//*********************************************************
procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  case CheckBox1.IsChecked of
    FALSE : MViewport3D.Camera := Camera1;
    TRUE :  MViewport3D.Camera := Camera2;
  end;
end;


//*********************************************************
procedure TForm1.FormCreate(Sender: TObject);
begin
  CameraInit;
  Add_Camera;
end;


//*********************************************************
procedure TForm1.CameraInit;
begin
  Camera1.Position.Vector := Vector3D( 0, 0, 0 );
  Camera1.Position.Vector := Vector3D( 0, -5, -10 );
  Camera1.RotationAngle.Vector := Vector3D( 0,0,0 );

  AngleX_Trackbar.Value := AngleX_Trackbar.Tag;
  AngleZ_Trackbar.Value := AngleZ_Trackbar.Tag;
end;


//*********************************************************
procedure TForm1.AngleX_TrackBarChange(Sender: TObject);
begin
  Camera1.RotationAngle.X := AngleX_Trackbar.Value;
  LabelX.Text := 'Angle.X= '+ Format( '%f', [Camera1.RotationAngle.X] );
end;

procedure TForm1.AngleZ_TrackBarChange(Sender: TObject);
begin
  Camera1.RotationAngle.Z := AngleZ_Trackbar.Value;
  LabelZ.Text := 'Angle.Z= '+ Format( '%f', [Camera1.RotationAngle.Z] );
end;


end.
