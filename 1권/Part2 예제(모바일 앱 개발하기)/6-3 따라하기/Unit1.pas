unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.WebBrowser, FMX.Layouts;

type
  TForm1 = class(TForm)
    Layout1: TLayout;
    ToolBar1: TToolBar;
    WebBrowser1: TWebBrowser;
    btnGoBack: TButton;
    btnGoForward: TButton;
    edtURL: TEdit;
    btnNavigate: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnGoBackClick(Sender: TObject);
    procedure btnGoForwardClick(Sender: TObject);
    procedure btnNavigateClick(Sender: TObject);
    procedure WebBrowser1DidStartLoad(ASender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.btnGoBackClick(Sender: TObject);
begin
  WebBrowser1.GoBack;
end;

procedure TForm1.btnGoForwardClick(Sender: TObject);
begin
  WebBrowser1.GoForward;
end;

procedure TForm1.btnNavigateClick(Sender: TObject);
begin
  WebBrowser1.Navigate(edtURL.Text);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  WebBrowser1.Navigate('www.devgear.co.kr');
end;

procedure TForm1.WebBrowser1DidStartLoad(ASender: TObject);
begin
  edtURL.Text := WebBrowser1.URL;
end;

end.
