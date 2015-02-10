unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.OpenSSL, REST.Backend.PushTypes, REST.Backend.MetaTypes, System.JSON,
  REST.Backend.KinveyServices, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Backend.BindSource, REST.Backend.ServiceComponents,
  REST.Backend.KinveyProvider, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    KinveyProvider1: TKinveyProvider;
    BackendPush1: TBackendPush;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
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
var
  Data: TPushData;
begin
  Data := TPushData.Create;
  try
    Data.Message      := Edit2.Text;
    Data.GCM.Title    := Edit1.Text;
    Data.GCM.Message  := Edit2.Text;

    BackEndPush1.PushData(Data);
  finally
    Data.Free;
  end;
end;

end.
