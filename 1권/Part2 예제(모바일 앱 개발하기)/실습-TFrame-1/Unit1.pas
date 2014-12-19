unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Unit2, FMX.StdCtrls, FMX.Effects;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    MyFrame1: TMyFrame;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure MyFrame1SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  // 초기에 프레임을 안보이는 곳에 위치 시킴
  MyFrame1.Position.X  :=  - MyFrame1.Width;
end;

procedure TForm1.MyFrame1SpeedButton1Click(Sender: TObject);
begin
  MyFrame1.SpeedButton1Click(Sender);

end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  MyFrame1.AnimateFloat( 'Position.X', 0, 0.5);
end;

end.
