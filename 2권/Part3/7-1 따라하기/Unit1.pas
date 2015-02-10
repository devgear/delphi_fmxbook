unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls3D, FMX.MaterialSources, FMX.Objects3D,
  FMX.Layouts, FMX.Viewport3D, FMX.StdCtrls;

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
    procedure AngleX_TrackBarChange(Sender: TObject);
    procedure AngleZ_TrackBarChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CameraInit;
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

//*********************************************************
procedure TForm1.FormCreate(Sender: TObject);
begin
  CameraInit;
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
