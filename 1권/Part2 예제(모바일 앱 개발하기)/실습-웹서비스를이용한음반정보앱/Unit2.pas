unit Unit2;

interface

uses
  System.SysUtils, System.Classes, IPPeerClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope;

type
  TDataModule2 = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Search(AKeyword: string);
    function GetResponseStatus: string;
  end;

var
  DataModule2: TDataModule2;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

{ TDataModule2 }

procedure TDataModule2.DataModuleCreate(Sender: TObject);
begin
  RESTRequest1.Execute;
end;

function TDataModule2.GetResponseStatus: string;
begin
  Result := Format('%s - %d bytes ¼ö½Å', [
    RESTResponse1.StatusText,
    RESTResponse1.ContentLength]);
end;

procedure TDataModule2.Search(AKeyword: string);
begin
  RESTRequest1.Params.ParameterByName('query').Value := AKeyword;
  RESTRequest1.Execute;
end;

end.
