unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI, FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet,
  FMX.ListView, FMX.StdCtrls, FireDAC.Phys.IB, FireDAC.Phys.IBDef,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.DBScope;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    Button1: TButton;
    ListView1: TListView;
    FDConnection1: TFDConnection;
    FDTable1: TFDTable;
    FDQueryInsert: TFDQuery;
    FDQueryDelete: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField: TLinkFillControlToField;
    FDQueryUpdate: TFDQuery;
    procedure Button1Click(Sender: TObject);
    procedure ListView1DeletingItem(Sender: TObject; AIndex: Integer;
      var ACanDelete: Boolean);
    procedure FDConnection1BeforeConnect(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.IOUtils;

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  TaskName: String;
begin
  try
    InputQuery('새로운 작업 입력', ['작업관리'], [''],
      procedure(const AResult: TModalResult; const AValues: array of string)
      begin
        if AResult = mrOk then
          TaskName := AValues[0]
        else
          TaskName := '';
        if not (TaskName.Trim = '') then
        begin
          FDQueryInsert.ParamByName('TaskName').AsString := TaskName;
          FDQueryInsert.ExecSQL;
          FDTable1.Refresh;
          LinkFillControlToField.BindList.FillList;
        end;
      end);

  except
    on e: Exception do
    begin
      ShowMessage(e.Message);
    end;
  end;
end;

procedure TForm1.FDConnection1BeforeConnect(Sender: TObject);
begin
{$IFNDEF MSWINDOWS}
  FDConnection1.Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'TASKS.GDB');
{$ENDIF}
end;

procedure TForm1.ListView1DeletingItem(Sender: TObject; AIndex: Integer;
  var ACanDelete: Boolean);
var
  TaskName: string;
begin
  TaskName := ListView1.Items[AIndex].Text;
  try
    FDQueryDelete.ParamByName('TaskName').AsString := TaskName;
    FDQueryDelete.ExecSQL;
    ACanDelete := True;
    if ListView1.ItemIndex = AIndex then
      ListView1.ItemIndex := 0;
  except
    on e: Exception do
    begin
      ShowMessage(e.Message);
    end;
  end;
end;

procedure TForm1.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
var
  TaskName, NewTaskName: String;
begin
  try
    TaskName := AItem.Text;
    InputQuery('작업 수정', ['작업관리'], [TaskName],
      procedure(const AResult: TModalResult; const AValues: array of string)
      begin
        if AResult = mrOk then
          NewTaskName := AValues[0]
        else
          TaskName := '';
        if not (NewTaskName.Trim = '') then
        begin
          FDQueryUpdate.ParamByName('TaskName').AsString := TaskName;
          FDQueryUpdate.ParamByName('NewTaskName').AsString := NewTaskName;
          FDQueryUpdate.ExecSQL;
          FDTable1.Refresh;
          LinkFillControlToField.BindList.FillList;
        end;
      end);

  except
    on e: Exception do
    begin
      ShowMessage(e.Message);
    end;
  end;
end;

end.
