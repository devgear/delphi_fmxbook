unit MasterDetail_Phone;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, Data.Bind.GenData,
  Fmx.Bind.GenData, Data.Bind.Components, Data.Bind.ObjectScope, FMX.Layouts,
  FMX.ListBox, FMX.StdCtrls, FMX.Graphics, FMX.TabControl, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, FMX.Objects, FMX.Edit, System.Actions, FMX.ActnList,
  FMX.ListView.Types, FMX.ListView, FMX.Controls.Presentation, Data.Bind.DBScope,
  FMX.MediaLibrary.Actions, FMX.StdActns;

type
  TPhoneMasterDetail = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    MasterToolbar: TToolBar;
    MasterLabel: TLabel;
    DetailToolbar: TToolBar;
    DetailLabel: TLabel;
    imgContact: TImage;
    BackButton: TSpeedButton;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ChangeTabAction2: TChangeTabAction;
    ListView1: TListView;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    edtName: TEdit;
    edtDept: TEdit;
    edtAge: TEdit;
    edtEmail: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    btnDelete: TButton;
    btnSave: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkPropertyToFieldBitmap: TLinkPropertyToField;
    TakePhotoFromLibraryAction1: TTakePhotoFromLibraryAction;
    TakePhotoFromCameraAction1: TTakePhotoFromCameraAction;
    btnAdd: TButton;
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure TakePhotoFromLibraryAction1DidFinishTaking(Image: TBitmap);
    procedure TakePhotoFromCameraAction1DidFinishTaking(Image: TBitmap);
    procedure btnAddClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure BackButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PhoneMasterDetail: TPhoneMasterDetail;

implementation


{$R *.fmx}

uses EmployeeDM;

procedure TPhoneMasterDetail.BackButtonClick(Sender: TObject);
begin
  DataModule1.CancelData;

  ChangeTabAction1.Tab := TabItem1;
  ChangeTabAction1.ExecuteTarget(Self);
end;

procedure TPhoneMasterDetail.btnAddClick(Sender: TObject);
begin
  DataModule1.NewData;

  ChangeTabAction1.Tab := TabItem2;
  ChangeTabAction1.ExecuteTarget(Self);
end;

procedure TPhoneMasterDetail.btnDeleteClick(Sender: TObject);
begin
  DataModule1.DeleteData;

  ChangeTabAction1.Tab := TabItem1;
  ChangeTabAction1.ExecuteTarget(Self);
end;

procedure TPhoneMasterDetail.btnSaveClick(Sender: TObject);
var
  Thumbnail: TBitmap;
  ImgStream, ThumbStream: TMemoryStream;
begin
  ImgStream := TMemoryStream.Create;
  ThumbStream := TMemoryStream.Create;
  try
    imgContact.Bitmap.SaveToStream(ImgStream);
    Thumbnail := imgContact.Bitmap.CreateThumbnail(100, 100);
    Thumbnail.SaveToStream(ThumbStream);
    DataModule1.SaveData(ImgStream, ThumbStream);

    ChangeTabAction1.Tab := TabItem1;
    ChangeTabAction1.ExecuteTarget(Self);
  finally
    ImgStream.Free;
    ThumbStream.Free;
  end;
end;

procedure TPhoneMasterDetail.Button3Click(Sender: TObject);
begin
  imgContact.Bitmap.Clear(TAlphaColorRec.Null);
end;

procedure TPhoneMasterDetail.FormCreate(Sender: TObject);
begin
  { This defines the default active tab at runtime }
  TabControl1.ActiveTab := TabItem1;
{$IFDEF ANDROID}
  { This hides the toolbar back button on Android }
  BackButton.Visible := False;
{$ENDIF}
end;

procedure TPhoneMasterDetail.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
    if TabControl1.ActiveTab = TabItem2 then
    begin
      ChangeTabAction1.Tab := TabItem1;
      ChangeTabAction1.ExecuteTarget(Self);
      Key := 0;
    end;
  end;
end;

procedure TPhoneMasterDetail.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
{ This triggers the slide animation }
  ChangeTabAction1.Tab := TabItem2;
  ChangeTabAction1.ExecuteTarget(Self);
  ChangeTabAction1.Tab := TabItem1;
end;

procedure TPhoneMasterDetail.TakePhotoFromCameraAction1DidFinishTaking(
  Image: TBitmap);
begin
  imgContact.Bitmap.Assign(Image);
end;

procedure TPhoneMasterDetail.TakePhotoFromLibraryAction1DidFinishTaking(
  Image: TBitmap);
begin
  imgContact.Bitmap.Assign(Image);
end;

end.
