unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Actions, FMX.ActnList, FMX.StdActns,
  FMX.MediaLibrary.Actions, FMX.Objects, FMX.StdCtrls, FMX.Layouts;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Image1: TImage;
    ActionList1: TActionList;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    ShowShareSheetAction1: TShowShareSheetAction;
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
    procedure ShowShareSheetAction1BeforeExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
begin
  Image1.Bitmap.Assign( Image );
end;

procedure TForm1.TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
begin
  Image1.Bitmap.Assign( Image );
end;

procedure TForm1.ShowShareSheetAction1BeforeExecute(Sender: TObject);
begin
  ShowShareSheetAction1.Bitmap.Assign( Image1.Bitmap );
end;


end.
