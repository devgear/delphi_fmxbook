unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Layouts, FMX.Viewport3D,
  FMX.Layers3D, FMX.Objects, IdHTTP, FMX.Controls3D, FMX.Objects3D, System.Math, FMX.ListBox;

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
    PrePosX : single;         // PSlide 우측 첫번째 IMG 좌표
    PMouse : Boolean;
    PDown : TPointF;
    procedure Object_Clear;
    procedure Cylinder_Make( iNo, nKind:integer );
    procedure Cylinder_Rotate( CCW : Boolean );
  end;

var
  Form1: TForm1;

implementation

const
  MAX_FACE = 50;

var
  IM_FACE : array[0..MAX_FACE] of TImage3D;        // FMX.Layers3D
  Make_Face_No : integer = 0;

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  {$IFDEF IOS}
  ResPath := GetHomePath() + PathDelim + 'Library' + PathDelim;    //  StartUp\Library
  {$ELSE}
  ResPath := GetHomePath() + PathDelim;                          // .\assets\internal
  {$ENDIF}                                                       // c:\Users\userid\AppData\Roaming\

  Cylinder_Make( 8, 0 );
end;


procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  case Combobox1.ItemIndex of
    0 : Cylinder_Make( 8, 0 );
    1 : Cylinder_Make( 8, 1 );
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


//*****************************************************************************
procedure TForm1.Cylinder_Make( iNo, nKind:integer );
var
  i : integer;
  alpha, A, R, rWidth, rHeight : single;

begin
  Object_Clear();

  rWidth  := 5;
  rHeight := 5;

  if nKind > 1 then // 0 = Cylinder / 1 = Twisted_Cylinder
     alpha := nKind / iNo       // 360 -> Theta : 각이 Theta인 호를 그릴수 있음.
  else
     alpha := 360.0 / iNo;

  A := Pi() / 180.0 * alpha;            // 삼각함수 Radian 변경
  R := 0.5 * rWidth / tan( 0.5 * A );   // 원점에서 Face까지 회전반경

  for i  := 0 to  iNo -1 do
  begin
    IM_FACE[ i ] := TImage3D.Create( nil );
    IM_FACE[ i ].Parent := MViewport3D;
    IM_FACE[ i ].Bitmap.LoadFromFile( ResPath + '00' + IntToStr( i+1 ) + '.png' );
    IM_FACE[ i ].Tag := i;
    IM_FACE[ i ].HitTest := FALSE;  // MViewport3D 를 터치함.
    IM_FACE[ i ].TwoSide := TRUE;

    IM_FACE[ i ].Width   := rWidth;
    IM_FACE[ i ].Height  := rHeight;
    IM_FACE[ i ].Depth   := 0.01;

    IM_FACE[ i ].Position.X :=  R*sin(i*A);
    IM_FACE[ i ].Position.Z := -R*cos(i*A);
    IM_FACE[ i ].Position.Y :=  - IM_FACE[ i ].Height * 0.5;   // Cylinder 일때만 Twist는 아래 if에서 정의
    IM_FACE[ i ].RotationAngle.X := 0;
    IM_FACE[ i ].RotationAngle.Z := 0;
    IM_FACE[ i ].RotationAngle.Y := -i*alpha;

    if nKind = 1 then
       IM_FACE[ i ].Position.Y := -( i*A + IM_FACE[ i ].Height*0.5 );   // Twisted Z 좌표, 1.5=간격
  end;

  Make_Face_No :=  iNo;                   // Face(bmp) 갯수를 전역변수에 저장
  Cur_imgNo := 0;
end;


//******************************************************************************
procedure TForm1.Cylinder_Rotate( CCW : Boolean );
var
  i : integer;
  dr, xp0, yp0, zp0, YA0 : single;
begin
  dr := 0.5;
  RotateTimer.Interval := 500;  // dr * 1000;

  if CCW = FALSE then
  begin
    xp0 := IM_FACE[ 0 ].Position.X;
    yp0 := IM_FACE[ 0 ].Position.Y;
    zp0 := IM_FACE[ 0 ].Position.Z;   // 나선형 일때 사용.
    YA0 := IM_FACE[ 0 ].RotationAngle.Y;

    for i := 0 to Make_Face_No-2 do // 맨마지막 Face 제외
    begin
      IM_FACE[ i ].AnimateFloat('Position.X', IM_FACE[i+1].Position.X, dr );
      IM_FACE[ i ].AnimateFloat('Position.Y', IM_FACE[i+1].Position.Y, dr );
      IM_FACE[ i ].AnimateFloat('Position.Z', IM_FACE[i+1].Position.Z, dr );
      IM_FACE[ i ].AnimateFloat('RotationAngle.Y', IM_FACE[i+1].RotationAngle.Y, dr );
    end;
    // 맨 마지막 Face 여기서 이동
    IM_FACE[ Make_Face_No-1 ].AnimateFloat('Position.X', xp0, dr );
    IM_FACE[ Make_Face_No-1 ].AnimateFloat('Position.Y', yp0, dr );
    IM_FACE[ Make_Face_No-1 ].AnimateFloat('Position.Z', zp0, dr );
    IM_FACE[ Make_Face_No-1 ].AnimateFloat('RotationAngle.Y', YA0, dr );
  end

  //-------------------------------
  else if CCW = TRUE then
  begin
    xp0 := IM_FACE[ Make_Face_No-1 ].Position.X;
    yp0 := IM_FACE[ Make_Face_No-1 ].Position.Y;
    zp0 := IM_FACE[ Make_Face_No-1 ].Position.Z;
    YA0 := IM_FACE[ Make_Face_No-1 ].RotationAngle.Y;

    for i :=  Make_Face_No-1 downto 1 do // IM_Face[0] 은 제외
    begin
      IM_FACE[ i ].AnimateFloat('Position.X', IM_FACE[i-1].Position.X, dr );
      IM_FACE[ i ].AnimateFloat('Position.Y', IM_FACE[i-1].Position.Y, dr );
      IM_FACE[ i ].AnimateFloat('Position.Z', IM_FACE[i-1].Position.Z, dr );
      IM_FACE[ i ].AnimateFloat('RotationAngle.Y', IM_FACE[i-1].RotationAngle.Y, dr );
    end;
    //  Face[0] 여기서 이동
    IM_FACE[ 0 ].AnimateFloat('Position.X', xp0, dr );
    IM_FACE[ 0 ].AnimateFloat('Position.Y', yp0, dr );
    IM_FACE[ 0 ].AnimateFloat('Position.Z', zp0, dr );
    IM_FACE[ 0 ].AnimateFloat('RotationAngle.Y', YA0, dr );
  end;
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

  Cylinder_Rotate( TRUE );
end;


procedure TForm1.Right_SBClick(Sender: TObject);
begin
  if   RotateTimer.Enabled = TRUE then exit
  else RotateTimer.Enabled := TRUE;

  Cylinder_Rotate( FALSE );
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
