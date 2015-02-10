unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Controls3D, FMX.Layers3D,
  FMX.ListBox, FMX.Layouts, FMX.Gestures, FMX.Objects;

type
  TForm1 = class(TForm3D)
    ALayer3D: TLayer3D;
    Label1: TLabel;
    BLayer3D: TLayer3D;
    TrackBar1: TTrackBar;
    CLayer3D: TLayer3D;
    ToolBar1: TToolBar;
    ToolBar2: TToolBar;
    Label2: TLabel;
    ToolBar3: TToolBar;
    Label3: TLabel;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    GestureManager1: TGestureManager;
    Panel1: TPanel;
    Image1: TImage;
    Button1: TButton;
    Switch1: TSwitch;
    Layout1: TLayout;
    procedure Form3DResize(Sender: TObject);
    procedure Form3DCreate(Sender: TObject);
    procedure ListBox1Gesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    CenterPosX, LeftPosX, RightPosX : single;
    procedure XPosMove_Left();
    procedure XPosMove_Right();
  end;

var
  Form1: TForm1;

implementation

const RotAngle = 90;

{$R *.fmx}

//**************************************************************
procedure TForm1.Form3DCreate(Sender: TObject);
begin
  // 최초 Position.X 위치를 A < B < C 순으로 배치.
  BLayer3D.Position.X := ALayer3D.Position.X + 10 ;
  CLayer3D.Position.X := BLayer3D.Position.X + 10;
end;

//**************************************************************
procedure TForm1.Form3DResize(Sender: TObject);
begin
  ALayer3D.Width  := ClientWidth;   ALayer3D.Height := ClientHeight;
  BLayer3D.Width  := ClientWidth;   BLayer3D.Height := ClientHeight;
  CLayer3D.Width  := ClientWidth;   CLayer3D.Height := ClientHeight;

  CenterPosX := ClientWidth * 0.5;
  LeftPosX   := CenterPosX - ClientWidth;
  RightPosX  := CenterPosX + ClientWidth;

  if ( ALayer3D.Position.X < BLayer3D.Position.X ) and ( BLayer3D.Position.X < CLayer3D.Position.X ) then  // A < B < C
  begin
    ALayer3D.Position.Vector := Vector3D( LeftPosX,   ALayer3D.Height*0.5, 0 );
    BLayer3D.Position.Vector := Vector3D( CenterPosX, BLayer3D.Height*0.5, 0 );
    CLayer3D.Position.Vector := Vector3D( RightPosX,  CLayer3D.Height*0.5, 0 );
    ALayer3D.RotationAngle.X := RotAngle;
    CLayer3D.RotationAngle.X := RotAngle;
  end
  else if ( BLayer3D.Position.X < CLayer3D.Position.X ) and ( CLayer3D.Position.X < ALayer3D.Position.X ) then  // B < C < A
  begin
    BLayer3D.Position.Vector := Vector3D( LeftPosX,   BLayer3D.Height*0.5, 0 );
    CLayer3D.Position.Vector := Vector3D( CenterPosX, CLayer3D.Height*0.5, 0 );
    ALayer3D.Position.Vector := Vector3D( RightPosX,  ALayer3D.Height*0.5, 0 );
    BLayer3D.RotationAngle.X := RotAngle;
    ALayer3D.RotationAngle.X := RotAngle;
  end
  else if ( CLayer3D.Position.X < ALayer3D.Position.X ) and ( ALayer3D.Position.X < BLayer3D.Position.X ) then  // C < A < B
  begin
    CLayer3D.Position.Vector := Vector3D( LeftPosX,   CLayer3D.Height*0.5, 0 );
    ALayer3D.Position.Vector := Vector3D( CenterPosX, BLayer3D.Height*0.5, 0 );
    BLayer3D.Position.Vector := Vector3D( RightPosX,  ALayer3D.Height*0.5, 0 );
    CLayer3D.RotationAngle.X := RotAngle;
    BLayer3D.RotationAngle.X := RotAngle;
  end;
end;


//-----------------------------------------------------------------------------------------------------------------------
procedure TForm1.ListBox1Gesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  case EventInfo.GestureID of
       sgiLeft : XPosMove_Left();
       sgiRight: XPosMove_Right();
  end;
end;


//-----------------------------------------------------------------------------------------------------------------------
procedure TForm1.XPosMove_Left;
begin
  if ( ALayer3D.Position.X < BLayer3D.Position.X ) and
     ( BLayer3D.Position.X < CLayer3D.Position.X ) then  // -> B < C < A
  begin
    BLayer3D.AnimateFloat( 'Position.X',  LeftPosX,   1.0 );
    BLayer3D.AnimateFloat( 'RotationAngle.X', RotAngle, 1.0 );
    CLayer3D.AnimateFloat( 'Position.X',  CenterPosX, 1.0 );
    CLayer3D.AnimateFloat( 'RotationAngle.X', 0,   1.0 );
    ALayer3D.AnimateFloat( 'Position.X',  RightPosX,  1.0 );
    ALayer3D.AnimateFloat( 'RotationAngle.X', RotAngle, 1.0 );
  end

  else if ( BLayer3D.Position.X < CLayer3D.Position.X ) and
          ( CLayer3D.Position.X < ALayer3D.Position.X ) then  // -> C < A < B
  begin
    CLayer3D.AnimateFloat( 'Position.X',  LeftPosX,   1.0 );
    CLayer3D.AnimateFloat( 'RotationAngle.X', RotAngle, 1.0 );
    ALayer3D.AnimateFloat( 'Position.X',  CenterPosX, 1.0 );
    ALayer3D.AnimateFloat( 'RotationAngle.X', 0,   1.0 );
    BLayer3D.AnimateFloat( 'Position.X',  RightPosX,  1.0 );
    BLayer3D.AnimateFloat( 'RotationAngle.X', RotAngle, 1.0 );
  end

  else if ( CLayer3D.Position.X < ALayer3D.Position.X ) and
          ( ALayer3D.Position.X < BLayer3D.Position.X ) then  // -> A < B < C
  begin
    ALayer3D.AnimateFloat( 'Position.X',  LeftPosX,   1.0 );
    ALayer3D.AnimateFloat( 'RotationAngle.X', RotAngle, 1.0 );
    BLayer3D.AnimateFloat( 'Position.X',  CenterPosX, 1.0 );
    BLayer3D.AnimateFloat( 'RotationAngle.X', 0,   1.0 );
    CLayer3D.AnimateFloat( 'Position.X',  RightPosX,  1.0 );
    CLayer3D.AnimateFloat( 'RotationAngle.X', RotAngle, 1.0 );
  end;
end;

//-----------------------------------------------------------------------------------------------------------------------
procedure TForm1.XPosMove_Right;
begin
  if ( ALayer3D.Position.X < BLayer3D.Position.X ) and
     ( BLayer3D.Position.X < CLayer3D.Position.X ) then  // -> C < A < B
  begin
    CLayer3D.AnimateFloat( 'Position.X',  LeftPosX,   1.0 );
    CLayer3D.AnimateFloat( 'RotationAngle.X', RotAngle, 1.0 );
    ALayer3D.AnimateFloat( 'Position.X',  CenterPosX, 1.0 );
    ALayer3D.AnimateFloat( 'RotationAngle.X', 0,   1.0 );
    BLayer3D.AnimateFloat( 'Position.X',  RightPosX,  1.0 );
    BLayer3D.AnimateFloat( 'RotationAngle.X', RotAngle, 1.0 );
  end
  else if ( BLayer3D.Position.X < CLayer3D.Position.X ) and
          ( CLayer3D.Position.X < ALayer3D.Position.X ) then  // -> A < B < C
  begin
    ALayer3D.AnimateFloat( 'Position.X',  LeftPosX,   1.0 );
    ALayer3D.AnimateFloat( 'RotationAngle.X', RotAngle, 1.0 );
    BLayer3D.AnimateFloat( 'Position.X',  CenterPosX, 1.0 );
    BLayer3D.AnimateFloat( 'RotationAngle.X', 0,   1.0 );
    CLayer3D.AnimateFloat( 'Position.X',  RightPosX,  1.0 );
    CLayer3D.AnimateFloat( 'RotationAngle.X', RotAngle, 1.0 );
  end
  else if ( CLayer3D.Position.X < ALayer3D.Position.X ) and
          ( ALayer3D.Position.X < BLayer3D.Position.X ) then  // -> B < C < A
  begin
    BLayer3D.AnimateFloat( 'Position.X',  LeftPosX,   1.0 );
    BLayer3D.AnimateFloat( 'RotationAngle.X', RotAngle, 1.0 );
    CLayer3D.AnimateFloat( 'Position.X',  CenterPosX, 1.0 );
    CLayer3D.AnimateFloat( 'RotationAngle.X', 0,   1.0 );
    ALayer3D.AnimateFloat( 'Position.X',  RightPosX,  1.0 );
    ALayer3D.AnimateFloat( 'RotationAngle.X', RotAngle, 1.0 );
  end;
end;


end.
