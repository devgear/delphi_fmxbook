unit MainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.Backend.PushTypes, System.JSON, REST.Backend.KinveyPushDevice,
  System.PushNotification, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, REST.OpenSSL,
  REST.Backend.KinveyProvider, Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Backend.BindSource, REST.Backend.PushDevice, FMX.Layouts, FMX.Memo,
  FMX.StdCtrls, FMX.Notification, REST.Backend.KinveyServices,
  REST.Backend.MetaTypes, REST.Backend.ServiceComponents,
  REST.Backend.ServiceTypes, REST.Backend.Providers;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    PushEvents1: TPushEvents;
    KinveyProvider1: TKinveyProvider;
    procedure PushEvents1DeviceRegistered(Sender: TObject);
    procedure PushEvents1DeviceTokenReceived(Sender: TObject);
    procedure PushEvents1DeviceTokenRequestFailed(Sender: TObject;
      const AErrorMessage: string);
    procedure PushEvents1PushReceived(Sender: TObject; const AData: TPushData);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.PushEvents1DeviceRegistered(Sender: TObject);
begin
  Memo1.Lines.Add('디바이스가 등록되었습니다.');
  Memo1.Lines.Add('');
end;

procedure TForm1.PushEvents1DeviceTokenReceived(Sender: TObject);
begin
  Memo1.Lines.Add('디바이스 토큰을 받았습니다.');
  Memo1.Lines.Add('');
end;

procedure TForm1.PushEvents1DeviceTokenRequestFailed(Sender: TObject;
  const AErrorMessage: string);
begin
  Memo1.Lines.Add('디바이스 토큰 요청을 실패했습니다.');
  Memo1.Lines.Add(AErrorMessage);
  Memo1.Lines.Add('');
end;

procedure TForm1.PushEvents1PushReceived(Sender: TObject;
  const AData: TPushData);
var
  Noti: TNotification;
begin
  Memo1.Lines.Add('디바이스 푸시데이터를 받았습니다.');
  Memo1.Lines.Add(AData.Message);
  Memo1.Lines.Add('');
end;

end.
