unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.IOUtils;

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  PathStr: string;
begin
  PathStr := TPath.Combine(TPath.GetDocumentsPath, 'sample.jpg');
  if TFile.Exists(PathStr) then
  begin
    Label1.Text := PathStr;
    Image1.Bitmap.LoadFromFile(PathStr);
  end
  else
  begin
    ShowMessage('파일을 찾을 수 없습니다. '#13#10 + PathStr);
  end;
end;

end.
