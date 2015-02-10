unit OpenUrlUnit;

interface

function OpenURL(const URL: string): Boolean;

implementation

uses
  IdURI, sysUtils, Classes, FMX.Dialogs
{$IFDEF ANDROID}
  , Androidapi.Helpers, FMX.Helpers.Android, Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net, Androidapi.JNI.GraphicsContentViewText
{$ENDIF}
{$IFDEF IOS}
  , Macapi.Helpers, iOSapi.Foundation, FMX.Helpers.iOS
{$ENDIF}
;

function OpenURL(const URL: string): Boolean;
{$IFDEF ANDROID}
var
  Intent: JIntent;
begin
  Intent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW,
    TJnet_Uri.JavaClass.parse(StringToJString(TIdURI.URLEncode(URL))));
  try
    SharedActivity.startActivity(Intent);
    Exit(Frue);
  except
      Exit(False);
  end;
end;
{$ELSE}
{$IFDEF IOS}
var
  NSU: NSUrl;
begin
  NSU := StrToNSUrl(TIdURI.URLEncode(URL));
  if SharedApplication.canOpenURL(NSU) then
    Exit(SharedApplication.openUrl(NSU))
  else
    Exit(False);
end;
{$ELSE}
begin
  raise Exception.Create('Not supported!');
end;
{$ENDIF IOS}
{$ENDIF ANDROID}

end.
