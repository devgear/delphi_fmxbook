unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, System.Actions, FMX.ActnList, FMX.TabControl,
  FMX.StdCtrls, FMX.ListView, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  FMX.WebBrowser, Xml.omnixmldom;

type
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    ListView1: TListView;
    ToolBar2: TToolBar;
    Label2: TLabel;
    Button2: TButton;
    ActionList1: TActionList;
    ChangeTabAction1: TChangeTabAction;
    ToolBar1: TToolBar;
    Label1: TLabel;
    Button1: TButton;
    WebBrowser1: TWebBrowser;
    XMLDocument1: TXMLDocument;
    IdHTTP1: TIdHTTP;
    procedure Button2Click(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
  XmlData, title, link: string;
  I: Integer;
  Node, ItemNode: IXMLNode;
  ListViewItem: TListViewItem;
begin
  // IdHTTP 컴포넌트를 통해 기술자료를 문자열(string)로 받아옵니다.
  XmlData := IdHTTP1.Get('http://tech.devgear.co.kr/delphi_news/rss');
  // XML분석 컴포넌트에서 XML 데이터를 불러옵니다.
  XMLDocument1.LoadFromXML(XmlData);
  XMLDocument1.Active := True;

  // channel 노드를 찾습니다.
  Node := XMLDocument1.DocumentElement.ChildNodes.FindNode('channel');
  for I := 0 to Node.ChildNodes.Count - 1 do
  begin
    ItemNode := Node.ChildNodes.Get(I);
    // 자식 노드가 item인 항목의 title, link 값 사용
    if ItemNode.NodeName = 'item' then
    begin
      title := ItemNode.ChildValues['title'];
      link := ItemNode.ChildValues['link'];
      ListViewItem := ListView1.Items.Add;
      ListViewItem.Text := title;
      ListViewItem.Detail := link;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // 폼 생성(앱 시작) 시 탭선택을 감추고 첫번 탭 표시
  TabControl1.TabPosition := TTabPosition.None;
  TabControl1.TabIndex := 0;
end;

procedure TForm1.ListView1ItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  // 목록 아이템 선택(클릭) 시 제목을 변경, 웹브라우저 URL 지정 후 실행
  Label2.Text := AItem.Text;
  WebBrowser1.URL := AItem.Detail;
  WebBrowser1.Navigate;
  WebBrowser1.Visible := True;

  // 2번째 탭(상세보기)로 이동
  ChangeTabAction1.Tab := TabItem2;
  ChangeTabAction1.ExecuteTarget(nil);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  // < 버튼 클릭 시 1번째 탭(목록)으로 이동
  WebBrowser1.Visible := False;
  ChangeTabAction1.Tab := TabItem1;
  ChangeTabAction1.ExecuteTarget(nil);
end;

end.
