unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Objects, FMX.Ani;

type
  TForm1 = class(TForm)
    BaseImage: TImage;
    ArrowImg: TImage;
    BreakButton: TButton;
    AccelButton: TButton;
    FloatAnimation1: TFloatAnimation;
    Label1: TLabel;
    procedure AccelButtonClick(Sender: TObject);
    procedure BreakButtonClick(Sender: TObject);
    procedure FloatAnimation1Process(Sender: TObject);
    procedure FloatAnimation1Finish(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}


procedure TForm1.FloatAnimation1Finish(Sender: TObject);
begin
  FloatAnimation1.Enabled := FALSE;
end;

procedure TForm1.FloatAnimation1Process(Sender: TObject);
begin
  Label1.Text := Format( '%.0f' ,[ 800*( ArrowImg.RotationAngle-180 )/( 470-180 ) ] );
end;

procedure TForm1.AccelButtonClick(Sender: TObject);
begin
  FloatAnimation1.Enabled := TRUE;

  FloatAnimation1.StartValue := 180;
  FloatAnimation1.StopValue  := 470;
  FloatAnimation1.Duration := 5;
end;


procedure TForm1.BreakButtonClick(Sender: TObject);
begin
  FloatAnimation1.Enabled := FALSE;
  ArrowImg.RotationAngle := 180;
  Label1.Text := '0';
end;


end.
