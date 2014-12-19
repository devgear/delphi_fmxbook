unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.ListBox, FMX.Layouts, FMX.Objects,
  FMX.Media;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    StatusBar1: TStatusBar;
    Text1: TText;
    ListBox1: TListBox;
    Button1: TButton;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    Label1: TLabel;
    MediaPlayer1: TMediaPlayer;
    procedure ListBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FilePath : string;
    procedure Phone_Call( pNumber : string );
  end;

var
  Form1: TForm1;

implementation

Uses
  FMX.Platform, FMX.PhoneDialer;  // 전화걸기


{$R *.fmx}

procedure TForm1.FormCreate(Sender: TObject);
begin
  {$IFDEF IOS}
  FilePath := System.IOUtils.TPath.GetDocumentsPath() + PathDelim;  //  StartUp\Documents
  {$ELSE}
  FilePath := GetHomePath() + PathDelim;                            // .\assets\internal
  {$ENDIF}

end;

procedure TForm1.ListBox1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  Text1.Text :=   ListBox1.ItemDown.ItemData.Detail;

  MediaPlayer1.Clear;
  MediaPlayer1.FileName := FilePath + 'button.mp3';
  MediaPlayer1.Play;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Phone_Call( Text1.Text );
end;


//-----------------------------------------------------------------------------
procedure TForm1.Phone_Call( pNumber : string );
var
  PhoneDialerService : IFMXPhoneDialerService;
begin
  if pNumber = '' then exit;

  if TPlatformServices.Current.SupportsPlatformService( IFMXPhoneDialerService, IInterface(PhoneDialerService)) then
     PhoneDialerService.Call( pNumber );
end;



end.
