unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.Objects, FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.Layouts;

type
  TForm2 = class(TForm)
    LayoutUser: TLayout;
    Panel1: TPanel;
    btnShowLayoutLogin: TButton;
    btnShowLayoutWelcom: TButton;
    btnShowBoth: TButton;
    Layout1: TLayout;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    btnLogin: TButton;
    LayoutWelcome: TLayout;
    Image1: TImage;
    FloatAnimation1: TFloatAnimation;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

end.
