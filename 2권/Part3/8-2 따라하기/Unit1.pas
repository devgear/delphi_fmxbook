unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Layouts, FMX.Viewport3D,
  FMX.Layers3D, FMX.Objects, IdHTTP, FMX.Controls3D, FMX.Objects3D, System.Math, FMX.ListBox,
  System.Math.Vectors;

type
  TForm1 = class(TForm)
    MViewport3D: TViewport3D;
    Layout1: TLayout;
    RotateTimer: TTimer;
    Left_SB: TSpeedButton;
    Right_SB: TSpeedButton;
    Grid3D1: TGrid3D;
    Camera1: TCamera;
    ComboBox1: TComboBox;
    Dummy1: TDummy;
    procedure RotateTimerTimer(Sender: TObject);
    procedure Left_SBClick(Sender: TObject);
    procedure Right_SBClick(Sender: TObject);
    procedure MViewport3DMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure MViewport3DMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure MViewport3DMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ResPath : string;
    Cur_imgNo : integer;      // 중앙 PSlide : 결정값
    PMouse : Boolean;
    PDown : TPointF;
    procedure Object_Clear;
    procedure Cube_Make;
    procedure Windmill_Make;
    procedure Object_Rotate( CCW : Boolean );
  end;

var
  Form1: TForm1;

implementation

const
  MAX_FACE = 24;

var
  IM_FACE : array[0..MAX_FACE] of TImage3D;        // FMX.Layers3D
  Make_Face_No : integer = 0;

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  {$IFDEF IOS}
  ResPath := GetHomePath() + PathDelim + 'Library' + PathDelim;    //  StartUp\Library
  {$ELSE}     // Android : .\assets\internal   Winows: c:\Users\userid\AppData\Roaming\
  ResPath := GetHomePath() + PathDelim;
  {$ENDIF}

  Cube_Make();
end;


procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  case Combobox1.ItemIndex of
    0 : Cube_Make();
    1 : WindMill_Make();
  end;
end;

// 기존 Object Clear all ----------------
procedure TForm1.Object_Clear();
var
  i : integer;
begin
  if Make_Face_No > 0 then
  begin
    for i := 0 to Make_Face_No-1 do
    begin
      IM_FACE[ i ].Release;
      IM_FACE[ i ] := nil;
    end;
  end;

  Cur_imgNo := 0;
end;


//******************************************************************************
procedure TForm1.Cube_Make;
var
  i : integer;
  sWd : single;
begin
  Object_Clear();

  for i := 0 to 3 do
  begin
    IM_FACE[ i ] := TImage3D.Create( nil );
    IM_FACE[ i ].Parent := Dummy1;
    IM_FACE[ i ].Bitmap.LoadFromFile( ResPath + '00' + IntToStr( i+1 ) + '.png' );
    IM_FACE[ i ].WrapMode := TImageWrapMode.iwStretch;         // FMX.Objects
    IM_FACE[ i ].HitTest := FALSE;  // MViewport3D 를 터치함.
    IM_FACE[ i ].Tag := i;

    IM_FACE[ i ].Width  := 8;
    IM_FACE[ i ].Height := 8;
    IM_FACE[ i ].Depth  := 0.01;
  end;

  sWd := - IM_FACE[ 1 ].Width * 0.5;

  IM_FACE[ 0 ].Position.Vector      := Vector3D( 0, sWd, -sWd );
  IM_FACE[ 0 ].RotationAngle.Vector := Vector3D( 0, 0, 0 );

  IM_FACE[ 1 ].Position.Vector      := Vector3D( sWd, sWd, 0 );
  IM_FACE[ 1 ].RotationAngle.Vector := Vector3D( 0, 90, 0 );

  IM_FACE[ 2 ].Position.Vector      := Vector3D( 0,  sWd, sWd );
  IM_FACE[ 2 ].RotationAngle.Vector := Vector3D( 0, 180, 0 );

  IM_FACE[ 3 ].Position.Vector      := Vector3D( -sWd,sWd, 0 );
  IM_FACE[ 3 ].RotationAngle.Vector := Vector3D( 0,  270, 0 );

  Make_Face_No :=  4;                   // Face(bmp) 갯수를 전역변수에 저장
end;


//******************************************************************************
procedure TForm1.Windmill_Make;
var
  i : integer;
  sWd : single;
begin
  Object_Clear();

  for i := 0 to 3 do
  begin
    IM_FACE[ i ] := TImage3D.Create( nil );
    IM_FACE[ i ].Parent := Dummy1;
    IM_FACE[ i ].Bitmap.LoadFromFile( ResPath + '00' + IntToStr( i+1 ) + '.png' );
    IM_FACE[ i ].WrapMode := TImageWrapMode.iwStretch;         // FMX.Objects
    IM_FACE[ i ].HitTest := FALSE;  // MViewport3D 를 터치함.
    IM_FACE[ i ].Tag := i;

    IM_FACE[ i ].Width  := 8;
    IM_FACE[ i ].Height := 8;
    IM_FACE[ i ].Depth  := 0.01;
  end;

  sWd := - IM_FACE[ 1 ].Width * 0.5;

  IM_FACE[ 0 ].Position.Vector      := Vector3D( 0, sWd, -sWd );
  IM_FACE[ 0 ].RotationAngle.Vector := Vector3D( 0, 90, 0 );

  IM_FACE[ 1 ].Position.Vector      := Vector3D( sWd, sWd, 0 );
  IM_FACE[ 1 ].RotationAngle.Vector := Vector3D( 0, 00, 0 );

  IM_FACE[ 2 ].Position.Vector      := Vector3D( 0,  sWd, sWd );
  IM_FACE[ 2 ].RotationAngle.Vector := Vector3D( 0, 90, 0 );

  IM_FACE[ 3 ].Position.Vector      := Vector3D( -sWd,sWd, 0 );
  IM_FACE[ 3 ].RotationAngle.Vector := Vector3D( 0, 0, 0 );

  Make_Face_No :=  4;                   // Face(bmp) 갯수를 전역변수에 저장
end;


//******************************************************************************
procedure TForm1.Object_Rotate( CCW : Boolean );
begin
  if CCW = TRUE then
     dummy1.AnimateFloat( 'RotationAngle.Y', dummy1.RotationAngle.Y+45, 0.5 )
  else
     dummy1.AnimateFloat( 'RotationAngle.Y', dummy1.RotationAngle.Y-45, 0.5 );
end;


//******************************************************************************
procedure TForm1.RotateTimerTimer(Sender: TObject);
begin
  RotateTimer.Enabled := FALSE;
end;


//******************************************************************************
procedure TForm1.Left_SBClick(Sender: TObject);
begin
  if   RotateTimer.Enabled = TRUE then exit     // Rotate Animation 실행중에 재실행 방지
  else RotateTimer.Enabled := TRUE;

  Object_Rotate( TRUE )
end;


procedure TForm1.Right_SBClick(Sender: TObject);
begin
  if   RotateTimer.Enabled = TRUE then exit
  else RotateTimer.Enabled := TRUE;

  Object_Rotate( FALSE )
end;


//------------------------------------------------------------------------------------------------------------
procedure TForm1.MViewport3DMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  PMouse := True;
  PDown := PointF(X,Y);
end;

procedure TForm1.MViewport3DMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
begin
 if (ssLeft in Shift) and PMouse then
  begin
    if PDown.X > X then
       Left_SBClick( Sender )
    else
       Right_SBClick( Sender );

    PMouse := False;

    PDown.X := X;
    PDown.Y := Y;
  end;
end;

procedure TForm1.MViewport3DMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
   PMouse := False;
end;


end.
