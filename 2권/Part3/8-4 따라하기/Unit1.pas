unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Layouts, FMX.Viewport3D,
  FMX.Layers3D, FMX.Objects, IdHTTP, FMX.Controls3D, FMX.Objects3D, System.Math, FMX.ListBox;

type
  TForm1 = class(TForm)
    MViewport3D: TViewport3D;
    RotateTimer: TTimer;
    Left_SB: TSpeedButton;
    Right_SB: TSpeedButton;
    Grid3D1: TGrid3D;
    Camera1: TCamera;
    Dummy1: TDummy;
    procedure RotateTimerTimer(Sender: TObject);
    procedure Left_SBClick(Sender: TObject);
    procedure Right_SBClick(Sender: TObject);
    procedure MViewport3DMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure MViewport3DMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single);
    procedure MViewport3DMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure FormCreate(Sender: TObject);
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
    procedure PSlide_Make( iNo : integer );
    procedure PSlide_Rotate( CCW : Boolean );
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

  PSlide_Make( 8 );
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

//----------------------------------------------------------------------------
procedure TForm1.PSlide_Make( iNo : integer );
var
  i : integer;
begin
  Object_Clear();

  for i := 0 to iNo-1 do
  begin
    IM_FACE[ i ] := TImage3D.Create( nil );
    IM_FACE[ i ].Parent := MViewport3D;
    IM_FACE[ i ].Bitmap.LoadFromFile( ResPath + '00' + IntToStr( i+1 ) + '.png' );
    IM_FACE[ i ].WrapMode := TImageWrapMode.iwFit;         // FMX.Objects
    IM_FACE[ i ].HitTest := FALSE;  // MViewport3D 를 터치함.
    IM_FACE[ i ].Tag := i;

    IM_FACE[ i ].Width  := 6;
    IM_FACE[ i ].Height := 6;
    IM_FACE[ i ].Depth  := 0.01;

    if i = 0 then
    begin
       IM_FACE[ i ].Position.X := 0;
       IM_FACE[ i ].Position.Y := - IM_FACE[ i ].Height * 0.5;
       IM_FACE[ i ].Position.Z := -5.0;  // 중앙이미지는 앞으로 튀어나와 보이게
       IM_FACE[ i ].Opacity := 1.0;
    end
    else
    begin
      IM_FACE[ i ].Position.X := IM_FACE[ i ].Width * (i+1) * 0.5;  // Width/2 만큼씩 X좌표 설정
      IM_FACE[ i ].Position.Y := - IM_FACE[ i ].Height * 0.5;
      IM_FACE[ i ].Position.Z := 10;
      IM_FACE[ i ].RotationAngle.Y := 70;
      IM_FACE[ i ].Opacity := 0.4;
    end;
  end;

  Make_Face_No :=  iNo;                   // Face(bmp) 갯수를 전역변수에 저장
  Cur_imgNo := 0;                         // PSlide_Rotate 한번 호출시 하나씩 증가.
  PrePosX := IM_FACE[ 1 ].Position.X;     // Rotate 처리위해 우측 첫번째 IMG 좌표 기억.
end;


//------------------------------------------------------------------------------
procedure TForm1.PSlide_Rotate( CCW : Boolean );
var
  i : integer;
  dr : single;
begin
  dr := 0.5;
  RotateTimer.Interval := 500;  // dr * 1000;

  if CCW = TRUE then
  begin
    for i := 0 to Make_Face_No-1 do
    begin
      IM_FACE[ i ].StopPropertyAnimation('Position.Z');
      IM_FACE[ i ].StopPropertyAnimation('Position.X');
      IM_FACE[ i ].StopPropertyAnimation('RotationAngle.Y');

      if IM_FACE[ i ].Position.X = 0 then    // 중앙은 -X 축으로 빠짐
      begin
        IM_FACE[ i ].AnimateFloat('RotationAngle.Y', -70, dr );
        IM_FACE[ i ].AnimateFloat('Position.X', -PrePosX, dr );
        IM_FACE[ i ].AnimateFloat('Position.Z',  10, dr );
        IM_FACE[ i ].AnimateFloat( 'Opacity', 0.4, dr);
      end
      else if IM_FACE[ i ].Position.X = PrePosX then  // 우측 첫번째 중앙이동
      begin
        IM_FACE[ i ].AnimateFloat('RotationAngle.Y', 0, dr );
        IM_FACE[ i ].AnimateFloat('Position.X', 0, dr );
        IM_FACE[ i ].AnimateFloat('Position.Z', -5.0, dr );
        IM_FACE[ i ].AnimateFloat( 'Opacity', 1.0, dr);
      end
      else    // 나머지는 한칸씩 좌로 이동
      begin
        if  i = 0 then
          IM_FACE[ i ].AnimateFloat('Position.X',IM_FACE[i].Position.X -PrePosX*0.5, dr)
        else
          IM_FACE[ i ].AnimateFloat('Position.X', IM_FACE[i-1].Position.X, dr );
      end;
    end;
   end
  //-------------------------------
  else if CCW = FALSE then
  begin
    for i := 0 to Make_Face_No -1 do
    begin
      IM_FACE[ i ].StopPropertyAnimation('Position.Z');
      IM_FACE[ i ].StopPropertyAnimation('Position.X');
      IM_FACE[ i ].StopPropertyAnimation('RotationAngle.Y');

      if IM_FACE[ i ].Position.X = 0 then    // 중앙은 +X 축으로 빠짐
      begin
        IM_FACE[ i ].AnimateFloat('RotationAngle.Y', 70, dr );
        IM_FACE[ i ].AnimateFloat('Position.X', PrePosX, dr );
        IM_FACE[ i ].AnimateFloat('Position.Z', 10, dr );
        IM_FACE[ i ].AnimateFloat( 'Opacity', 0.4, dr);
      end
      else if IM_FACE[ i ].Position.X = -PrePosX then  // 좌측 첫번째 중앙이동
      begin
        IM_FACE[ i ].AnimateFloat('RotationAngle.Y', 0, dr );
        IM_FACE[ i ].AnimateFloat('Position.X', 0, dr );
        IM_FACE[ i ].AnimateFloat('Position.Z', -5.0, dr );
        IM_FACE[ i ].AnimateFloat( 'Opacity', 1.0, dr);
      end
      else    // 나머지는 한칸씩 우로 이동
      begin
        if  i = Make_Face_No-1 then
          IM_FACE[ i ].AnimateFloat('Position.X',IM_FACE[i].Position.X + PrePosX*0.5, dr)
        else
          IM_FACE[ i ].AnimateFloat('Position.X', IM_FACE[i+1].Position.X, dr );
      end;
    end;
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

  PSlide_Rotate( TRUE );
end;


procedure TForm1.Right_SBClick(Sender: TObject);
begin
  if   RotateTimer.Enabled = TRUE then exit
  else RotateTimer.Enabled := TRUE;

  PSlide_Rotate( FALSE );
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
