unit Unit4;

// EMS Resource Unit

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  EMS.Services, EMS.ResourceAPI,
  EMS.ResourceTypes;

type
  [ResourceName('test')]
  {$METHODINFO ON}
  TTestResource = class
  published
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;
  {$METHODINFO OFF}

procedure Register;

implementation

procedure TTestResource.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
begin
  AResponse.Body.SetValue(TJSONString.Create('한번에 개발하는 안드로이드/iOS with 델파이'), true);
end;

procedure Register;
begin
  RegisterResource(TypeInfo(TTestResource));
end;

end.


