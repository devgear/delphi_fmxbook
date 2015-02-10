unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Edit, FMX.Layouts, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    Edit1: TEdit;
    Button1: TButton;
    Image1: TImage;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    IdHTTP1: TIdHTTP;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  Stream: TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  try
    IdHttp1.Get(Edit1.Text, Stream);
    Image1.Bitmap.LoadFromStream(Stream);
    Label1.Text := Stream.Size.ToString + ' bytes';
  finally
    Stream.Free;
  end;
end;

end.
