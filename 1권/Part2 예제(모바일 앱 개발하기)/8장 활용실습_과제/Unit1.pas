unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox, FMX.Layouts, FMX.StdCtrls, FMX.Effects,
  FMX.Objects;

type
  TForm1 = class(TForm)
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    MenuTimer: TTimer;
    ShadowEffect1: TShadowEffect;
    Layout1: TLayout;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure ListBoxItem4Click(Sender: TObject);
    procedure MenuTimerTimer(Sender: TObject);
    procedure Layout1Click(Sender: TObject);
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
  FMX.Ani;

// 최초에 안보이게 하기.
procedure TForm1.FormCreate(Sender: TObject);
begin
  ListBox1.Position.Point := PointF( Form1.ClientWidth , 0 );  // 숨겨진 상태
end;

// 가로/세로모드 변환시 팝업메뉴 재위치
procedure TForm1.FormResize(Sender: TObject);
begin
  ListBox1.Tag := 0;
  ListBox1.Position.Point := PointF( Form1.ClientWidth , 0 );  // 숨겨진 상태
end;

// 메뉴 나타남.
procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  // ShadowEffect 효과 재반영.
   ListBox1.ApplyStyleLookup();
   ListBox1.RealignContent();

   if ListBox1.Tag = 0 then
   begin
     ListBox1.Tag := 1;
     TAnimator.AnimateFloat(ListBox1, 'Position.X', Form1.ClientWidth - ListBox1.Width, 1  );  // 나타남
   end
   else
   begin
     ListBox1.Tag := 0;
     TAnimator.AnimateFloat(ListBox1, 'Position.X', Form1.ClientWidth, 1  );                   // 숨겨짐
   end;
end;

// 다른 화면 터치시 팝업메뉴 숨김
procedure TForm1.Layout1Click(Sender: TObject);
begin
   if ListBox1.Tag = 1 then
   begin
     ListBox1.Tag := 0;
     TAnimator.AnimateFloat(ListBox1, 'Position.X', Form1.ClientWidth, 1  );
   end;
end;


// 각메뉴별 선택 방법 차이
procedure TForm1.ListBoxItem1Click(Sender: TObject);
begin
  Label1.Text := '111';
  ShowMessage( ListBoxItem1.Text );
end;

procedure TForm1.ListBoxItem2Click(Sender: TObject);
begin
  Label1.Text := '222';
end;

procedure TForm1.ListBoxItem3Click(Sender: TObject);
begin
  Label1.Text := '333';
end;

procedure TForm1.ListBoxItem4Click(Sender: TObject);
begin
  Label1.Text := '444';
  MenuTimer.Enabled := TRUE;
end;

// 안드로이드의 경우 ListBox 선택상태가 바로 화면에 나타나지 않아 시차를 두고 선택처리함.
procedure TForm1.MenuTimerTimer(Sender: TObject);
begin
  MenuTimer.Enabled := FALSE;
  ShowMessage( ListBox1.Selected.Text );
end;




end.
