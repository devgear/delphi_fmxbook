unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Ani, FMX.Objects, FMX.Controls.Presentation, FMX.Edit;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    LayoutUser: TLayout;
    Panel1: TPanel;
    LayoutLogin: TLayout;
    LayoutWelcome: TLayout;
    btnHideLayoutUser: TButton;
    btnShowLayoutUser: TButton;
    btnShowLayoutLogin: TButton;
    btnShowLayoutWelcom: TButton;
    btnShowBoth: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    btnLogin: TButton;
    Image1: TImage;
    FloatAnimation1: TFloatAnimation;
    procedure btnHideLayoutUserClick(Sender: TObject);
    procedure btnShowLayoutUserClick(Sender: TObject);
    procedure btnShowLayoutLoginClick(Sender: TObject);
    procedure btnShowLayoutWelcomClick(Sender: TObject);
    procedure btnShowBothClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.btnShowLayoutLoginClick(Sender: TObject);
begin
  LayoutLogin.Visible := True;
  LayoutWelcome.Visible := False;
end;

procedure TForm1.btnHideLayoutUserClick(Sender: TObject);
begin
  LayoutUser.Visible := False;
end;

procedure TForm1.btnShowLayoutUserClick(Sender: TObject);
begin
  LayoutUser.Visible := True;
end;

procedure TForm1.btnShowLayoutWelcomClick(Sender: TObject);
begin
  LayoutWelcome.Visible := True;
  LayoutLogin.Visible := False;
  FloatAnimation1.Start;
end;

procedure TForm1.btnShowBothClick(Sender: TObject);
begin
  LayoutWelcome.Visible := True;
  LayoutLogin.Visible := True;
end;

end.
