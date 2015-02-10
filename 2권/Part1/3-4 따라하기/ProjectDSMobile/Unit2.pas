unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  Data.DBXDataSnap, IPPeerClient, Data.DBXCommon, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Data.SqlExpr, FMX.StdCtrls, FMX.ListView.Types,
  System.Rtti, System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Data.Bind.Components, Data.Bind.DBScope,
  FMX.Controls.Presentation, FMX.Edit, FMX.ListView, FMX.Layouts;

type
  TForm2 = class(TForm)
    ToolBar1: TToolBar;
    Layout1: TLayout;
    ListView1: TListView;
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    edtEmpName: TEdit;
    edtEmpDept: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Button2: TButton;
    Button3: TButton;
    SQLConnection1: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    ClientDataSet1: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

uses Unit3;

procedure TForm2.Button1Click(Sender: TObject);
begin
  SQLConnection1.Params.Values['HostName'] := Edit1.Text;
  SQLConnection1.Params.Values['Port'] := Edit2.Text;
  SQLConnection1.Connected := False;
  ClientDataSet1.Active := True;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  ClientDataSet1.Edit;
  ClientDataSet1.FieldByName('EMP_NAME').AsString := edtEmpName.Text;
  ClientDataSet1.FieldByName('EMP_DEPT').AsString := edtEmpDept.Text;
  ClientDataSet1.Post;
  ClientDataSet1.ApplyUpdates(-1);
//  ClientDataSet1.Refresh;
end;

procedure TForm2.Button3Click(Sender: TObject);
var
  Method: TServerMethods1Client;
  EmpNo: Integer;
  EmpInfo: string;
begin
  Method := TServerMethods1Client.Create(SQLConnection1.DBXConnection);
  EmpNo := ClientDataSet1.FieldByName('EMP_NO').AsInteger;
  EmpInfo := Method.GetEmpInfo(EmpNo);
  ShowMessage(EmpInfo);
end;

end.
