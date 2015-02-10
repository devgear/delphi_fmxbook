unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls3D, FMX.Objects3D, FMX.Layouts,
  FMX.Viewport3D, FMX.StdCtrls, FMX.MaterialSources, FMX.Ani;

type
  TForm1 = class(TForm)
    MViewport3D: TViewport3D;
    Layout1: TLayout;
    Grid3D1: TGrid3D;
    ArcDial1: TArcDial;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    HText3D: TText3D;
    LightMaterialSource1: TLightMaterialSource;
    procedure MViewport3DMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure MViewport3DMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure MViewport3DMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    CameraDummyX, CameraDummyY : TDummy;
    Camera1 : TCamera;
    CLight   : TLight;
    isMouse : Boolean;
    DownPoint : TPointF;
    procedure CameraView_Init();
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


//**********************************************************
procedure TForm1.FormCreate(Sender: TObject);
begin
  CameraView_Init();
end;

//-----------------------------------------------------------
procedure TForm1.CameraView_Init;
begin
  CameraDummyY := TDummy.Create(nil);
  CameraDummyY.Parent := MViewport3D;

  CameraDummyX := TDummy.Create(nil);
  CameraDummyX.Parent := CameraDummyY;
  CameraDummyX.RotationAngle.X := -20;
  CameraDummyX.RotationAngle.Y := 0;
  CameraDummyX.RotationAngle.Z := 0;
  CameraDummyX.Position.Y := -5;      // 화면 상하 위치 조절

  Camera1 := TCamera.Create(nil);
  Camera1.Parent := CameraDummyX;
  Camera1.Position.Z := -20;           // 적절한 거리값.

  MViewport3D.Camera := Camera1;
  MViewport3D.UsingDesignCamera := False;

  CLight := TLight.Create(nil);
  CLight.Parent := MViewport3D;
  CLight.Position.Vector := Vector3D( 0,0,-30 );
  CLight.RotationAngle.Vector := Vector3D( -20, 0,0 );
end;


//**********************************************************
procedure TForm1.MViewport3DMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  isMouse := True;
  DownPoint := PointF(X,Y);
end;

procedure TForm1.MViewport3DMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
var
  tCz : single;
begin
  if (ssLeft in Shift) and isMouse then
  begin
    // View
    if ArcDial1.Value = 0 then
    begin
      CameraDummyX.RotationAngle.X := CameraDummyX.RotationAngle.X - (Y - DownPoint.Y)* 0.5;
      CameraDummyY.RotationAngle.Y := CameraDummyY.RotationAngle.Y + (X - DownPoint.X)* 0.5;
    end

    // Zoom
    else if ArcDial1.Value = 120 then
    begin
      tCz := Camera1.Position.Z;                  // 이동전 좌표 저장해둠.
      Camera1.Position.Z := Camera1.Position.Z - (Y - DownPoint.Y)* 0.6;
      if ( Camera1.Position.Z < -200 ) or ( -2 < Camera1.Position.Z ) then
         Camera1.Position.Z := tCz;              // 범위 밖을 벗어나면 원상 복귀
    end

    // Pan
    else if ArcDial1.Value= -120 then
    begin
      CameraDummyX.Position.X := CameraDummyX.Position.X - (X - DownPoint.X)* 0.05 ;
      CameraDummyY.Position.Y := CameraDummyY.Position.Y - (Y - DownPoint.Y)* 0.05 ;
    end;

    DownPoint.X := X;
    DownPoint.Y := Y;
  end;
end;

procedure TForm1.MViewport3DMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  isMouse := False;
end;

end.
