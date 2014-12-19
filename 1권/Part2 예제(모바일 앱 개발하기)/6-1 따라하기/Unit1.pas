unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions,
  FMX.ActnList, FMX.TabControl, FMX.Objects, FMX.StdCtrls, FMX.Gestures;

type
  TForm1 = class(TForm)
    ActionList1: TActionList;
    GestureManager1: TGestureManager;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    Button1: TButton;
    TabControl2: TTabControl;
    TabItem3: TTabItem;
    TabItem4: TTabItem;
    TabItem5: TTabItem;
    TabItem6: TTabItem;
    Text1: TText;
    Text2: TText;
    Text3: TText;
    Text4: TText;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    ChangeTabAction3: TChangeTabAction;
    ChangeTabAction4: TChangeTabAction;
    ChangeTabAction5: TChangeTabAction;
    ChangeTabAction6: TChangeTabAction;
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
begin
//  TabControl1.ActiveTab := TabItem2;
//  TabControl1.Index := TabControl1.Index + 1;
//  TabControl1.Next();
  ChangeTabAction2.ExecuteTarget(Sender);
end;

end.
