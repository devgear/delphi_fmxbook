unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Edit, System.IniFiles, FMX.ListBox, FMX.Layouts, FMX.Memo,
  FMX.StdCtrls, FMX.Controls.Presentation;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    Button1: TButton;
    Label1: TLabel;
    ListBox1: TListBox;
    ListBoxGroupHeader1: TListBoxGroupHeader;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxGroupHeader2: TListBoxGroupHeader;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    ListBoxItem6: TListBoxItem;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit3: TEdit;
    Switch1: TSwitch;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  System.IOUtils; // TPath 사용을 위해 추가

procedure TForm1.FormShow(Sender: TObject);
var
  Path: string;
  IniFile: TIniFile;
begin
  Path := TPath.Combine(TPath.GetDocumentsPath, 'Env.ini');
  IniFile := TIniFile.Create(Path);
  try
    Edit1.Text := IniFile.ReadString('UserInfo', 'Name', '');
    Edit2.Text := IniFile.ReadInteger('UserInfo', 'Age', 0).ToString;
    Edit3.Text := IniFile.ReadString('UserInfo', 'Email', '');

    Edit4.Text := IniFile.ReadString('ServerInfo', 'IP', '');
    Edit5.Text := IniFile.ReadInteger('ServerInfo', 'Port', 0).ToString;
    Switch1.IsChecked := IniFile.ReadBool('ServerInfo', 'AutoConnect', False);
  finally
    IniFile.Free;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  Path: string;
  IniFile: TIniFile;
begin
  Path := TPath.Combine(TPath.GetDocumentsPath, 'Env.ini');
  IniFile := TIniFile.Create(Path);
  try
    IniFile.WriteString('UserInfo', 'Name', Edit1.Text);
    IniFile.WriteInteger('UserInfo', 'Age', StrToIntDef(Edit2.Text, 0));
    IniFile.WriteString('UserInfo', 'Email', Edit3.Text);
    IniFile.WriteString('ServerInfo', 'IP', Edit4.Text);
    IniFile.WriteInteger('ServerInfo', 'Port', StrToIntDef(Edit5.Text, 0));
    IniFile.WriteBool('ServerInfo', 'AutoConnect', Switch1.IsChecked);
  finally
    IniFile.Free;
  end;
end;

end.
