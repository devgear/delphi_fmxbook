unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.StdCtrls, FMX.Layouts;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    ToolBar1: TToolBar;
    Label1: TLabel;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
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
  OpenUrlUnit;

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  URL: string;
begin
  if not Assigned(ListBox1.Selected) then
    Exit;

  URL := ListBox1.Selected.ItemData.Detail;
  OpenURL(URL);
end;

end.
