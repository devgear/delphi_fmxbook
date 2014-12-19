unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Sensors, FMX.StdCtrls,
  FMX.WebBrowser, FMX.Layouts, FMX.Memo, System.Sensors.Components;

type
  TForm1 = class(TForm)
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    WebBrowser1: TWebBrowser;
    LocationSensor1: TLocationSensor;
    StatusBar1: TStatusBar;
    procedure LocationSensor1LocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.LocationSensor1LocationChanged(Sender: TObject; const OldLocation, NewLocation: TLocationCoord2D);
var
  x, y, mapURL : string;
begin
  x := Format('%2.6f', [NewLocation.Latitude]);
  y := Format('%2.6f', [NewLocation.Longitude]);
  mapURL := Format( 'https://maps.google.com/maps?f=q&q=(%2.6f,%2.6f)',
                    [ NewLocation.Latitude, NewLocation.Longitude]);

  WebBrowser1.Navigate( mapURL );
  LocationSensor1.Active := FALSE;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  LocationSensor1.Active := TRUE;
end;

end.
