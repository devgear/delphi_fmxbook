unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.StdCtrls, FMX.ListView, FMX.Controls.Presentation,
  FMX.Edit, FMX.Layouts;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    Button1: TButton;
    Layout1: TLayout;
    Edit1: TEdit;
    Button2: TButton;
    ListView1: TListView;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    procedure Edit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses Unit2;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  DataModule2.Search(Edit1.Text);
  Label2.Text := DataModule2.GetResponseStatus;
end;

end.
