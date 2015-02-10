unit EmployeeDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.FMXUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDQuery1: TFDQuery;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure FDConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure NewData;
    procedure SaveData(AImage, AThumbnail: TStream);
    procedure CancelData;
    procedure DeleteData;
  end;

var
  DataModule1: TDataModule1;

implementation

uses
  System.IOUtils;

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TDataModule1.NewData;
begin
  FDQuery1.Append;
end;

procedure TDataModule1.SaveData(AImage, AThumbnail: TStream);
begin
  if FDQuery1.UpdateStatus = TUpdateStatus.usUnmodified then
    FDQuery1.Edit;


  // 입력 시  EMP_NO은 자동생성되지만 미 입력 시 오류
  if FDQuery1.UpdateStatus = TUpdateStatus.usInserted then
    FDQuery1.FieldByName('EMP_NO').AsInteger := 0;

  // 이미지 스트림 적용
  (FDQuery1.FieldByName('EMP_IMAGE') as TBlobField).LoadFromStream(AImage);
  (FDQuery1.FieldByName('EMP_THUMB') as TBlobField).LoadFromStream(AThumbnail);
  FDQuery1.Post;
  FDQuery1.ApplyUpdates(0);
  FDQuery1.CommitUpdates;
  FDQuery1.Refresh;
end;

procedure TDataModule1.DeleteData;
begin
  // 추가 중(입력되지 않음)인 경우 취소
  if FDQuery1.UpdateStatus = TUpdateStatus.usInserted then
  begin
    FDQuery1.Cancel;
  end
  else if FDQuery1.UpdateStatus = TUpdateStatus.usUnmodified then
  begin
    FDQuery1.Delete;
    FDQuery1.ApplyUpdates(0);
    FDQuery1.CommitUpdates;
    FDQuery1.Refresh;
  end;
end;

procedure TDataModule1.FDConnection1BeforeConnect(Sender: TObject);
begin
{$IFNDEF MSWINDOWS}
  FDConnection1.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'EMPLOYEE.GDB');
{$ENDIF}
end;

procedure TDataModule1.CancelData;
begin
  if FDQuery1.UpdateStatus = TUpdateStatus.usInserted then
    FDQuery1.Cancel;
end;

end.
