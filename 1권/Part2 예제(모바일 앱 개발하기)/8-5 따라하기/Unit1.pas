unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Objects, FMX.Layouts, FMX.Edit,
  FMX.Ani, FMX.Controls.Presentation, FMX.EditBox, FMX.SpinBox;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    Layout1: TLayout;
    Line1: TLine;
    Line2: TLine;
    SpeedButton1: TSpeedButton;
    SpinBox1: TSpinBox;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Create_Bar( noBar : integer );
    procedure Create_Animation( bParent : TRectangle );
    procedure BAni_OnProcess( Sender : TObject );
    procedure BAni_OnFinish( Sender : TObject );

  end;

var
  Form1: TForm1;
  RecBar : array[0..9] of TRectangle;
  isAniRunning : boolean = FALSE;

implementation

{$R *.fmx}

//*****************************************************
procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if not isAniRunning then
     Create_Bar( Round( spinBox1.Value ) );
end;

//----------------------------------------------------
procedure TForm1.Create_Bar( noBar : integer );
var
  i: integer;
begin
  for i := 0 to 9 do
     if Assigned( recBar[i] ) then
        RecBar[i].Release();

  for i := 0 to noBar-1 do
  begin
    RecBar[i] := TRectangle.Create(nil);
    RecBar[i].Parent := Layout1;
    RecBar[i].Stroke.Kind := TBrushKind.None;
    RecBar[i].Fill.Color := $FFF0FF00 * Random(200) + Random(200);
    RecBar[i].Width := 20;
    RecBar[i].Height := 10 + Random( 290 );
    RecBar[i].Position.Y := Layout1.Height - RecBar[i].Height -1; // 0;
    RecBar[i].Position.X := 20 + i*20 + i*5;

    Create_Animation( RecBar[i] );
  end;
end;

//----------------------------------------------------
procedure TForm1.Create_Animation( bParent : TRectangle );
var
  bAni : TFloatAnimation;   // FMX.Ani
begin
  bAni := TFloatAnimation.Create(nil);
  bAni.Parent := bParent;
  bAni.PropertyName := 'Position.Y';
  bAni.AnimationType := TAnimationType.Out;
  bAni.Interpolation := TInterpolationType.Bounce;
  bAni.Delay         := 0.0;
  bAni.Duration      := 3.0;
  bAni.StartValue    := -100;
  bAni.StopValue     := Layout1.Height - bParent.Height -1; // Layout 상단이 Y=0 이므로

  bANi.OnProcess := Form1.BAni_OnProcess;
  bANi.OnFinish  := Form1.BAni_OnFinish;

  bAni.Start;
end;

//---------------------------------------------------------
procedure TForm1.BAni_OnProcess( Sender : TObject );
begin
  isAniRunning := TRUE;
end;

procedure TForm1.BAni_OnFinish( Sender : TObject );
begin
  isAniRunning := FALSE;
end;




end.
