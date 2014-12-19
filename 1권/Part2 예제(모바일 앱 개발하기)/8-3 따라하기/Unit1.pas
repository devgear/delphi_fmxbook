unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    FloatAnimation1: TFloatAnimation;
    Button3: TButton;
    FloatAnimation2: TFloatAnimation;
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation




{$R *.fmx}

procedure TForm1.Button3Click(Sender: TObject);
begin
  Button3.AnimateFloat( 'Position.Y', Button3.Position.Y + 20, 0.5 );
end;

end.
