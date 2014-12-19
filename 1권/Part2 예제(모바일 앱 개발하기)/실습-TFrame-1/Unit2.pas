unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, FMX.Edit, FMX.Objects;

type
  TMyFrame = class(TFrame)
    SpeedButton1: TSpeedButton;
    Edit1: TEdit;
    Rectangle1: TRectangle;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

procedure TMyFrame.SpeedButton1Click(Sender: TObject);
begin
  Edit1.Text := 'TMyFrame 메소드에서 호출됨';
end;

end.
