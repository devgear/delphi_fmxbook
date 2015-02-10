unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Layouts, FMX.StdCtrls, FMX.Platform;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    Button1: TButton;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    procedure Button1Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
{$IFDEF ANDROID}
// 안드로이드로 컴파일(Target Platforms > Android)하는 경우만 아래 코드를 사용
uses
  Androidapi.Jni.Os, Androidapi.Helpers;
{$ENDIF}
{$IFDEF IOS}
// iOS로 컴파일(Target Platforms > iOS Device/Simulator)하는 경우만 아래 코드를 사용
uses
  iOSapi.UIKit, Macapi.Helpers;
{$ENDIF}

{$R *.fmx}

{$IFDEF ANDROID}
function GetAndroidCodename(VerString: string): string;
var
  iVer: Single;
begin
  if TryStrToFloat(VerString, iVer) then
  begin
    if iVer >= 5.0 then       Result := '롤리팝'
    else if iVer >= 4.4 then  Result := '킷캣'
    else if iVer >= 4.1 then  Result := '젤리빈'
    else if iVer >= 4.0 then  Result := '아이스크림샌드위치'
    else if iVer >= 3.0 then  Result := '허니콤'
    else if iVer >= 2.3 then  Result := '진저브래드'
    else if iVer >= 2.2 then  Result := '프로요'
    else                      Result := 'Unkown';
  end
  else
    Result := 'Unkown';
end;
{$ENDIF}

procedure TForm1.Button1Click(Sender: TObject);
begin
// 기기모델, OS종류, OS버전 표시
{$IFDEF ANDROID}
  ListBoxItem1.ItemData.Detail := JStringToString(TJBuild.JavaClass.MODEL);
  ListBoxItem2.ItemData.Detail := GetAndroidCodename(JStringToString(TJBuild_VERSION.JavaClass.RELEASE));
  ListBoxItem3.ItemData.Detail := JStringToString(TJBuild_VERSION.JavaClass.RELEASE);
{$ENDIF}
{$IFDEF IOS}
  ListBoxItem1.ItemData.Detail := NSStrToStr(Device.systemName);
  ListBoxItem2.ItemData.Detail := NSStrToStr(Device.systemVersion);
  ListBoxItem3.ItemData.Detail := NSStrToStr(Device.model);
{$ENDIF}
end;

// 폼의 OnKeyUp 이벤트에서 하드웨어 백버튼을 제어할 수 있다.
procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
{$IFDEF ANDROID}
  if Key = vkHardwareBack then
  begin
    ShowMessage('안드로이드 백버튼을 눌렀습니다.');
    Key := 0;
  end;
{$ENDIF}
end;

end.
