unit uMainFormServer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls,
  IdBaseComponent, IdComponent, IdCustomTCPServer, IdSocksServer, System.JSON,
  IdCustomTransparentProxy, IdSocks, IdTCPConnection, IdTCPClient, IdTCPServer,
  IdContext, FMX.Edit, FMX.Layouts, FMX.ListBox, GenericSocket, GenericSocket.Interfaces;

type
  TMainForm = class(TForm)
    Layout1: TLayout;
    Button2: TButton;
    Layout2: TLayout;
    Layout4: TLayout;
    Button1: TButton;
    Memo1: TMemo;
    Layout3: TLayout;
    ListBox1: TListBox;
    Button3: TButton;
    procedure Send(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    Socket : iGenericSocket;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.Send(Sender: TObject);
var
  SocketResponse : iSocketMessage;
begin
  SocketResponse := Socket.SocketServer.Send(ListBox1.Items[ListBox1.ItemIndex] , '/route');

  Memo1.Lines.Add(SocketResponse.JSONValue.ToJSON);
end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
  Socket.SocketServer.Start;
end;

procedure TMainForm.Button3Click(Sender: TObject);
var
  i : Integer;
  Clientes : TArray<String>;
begin
  Clientes := Socket.SocketServer.Clients;

  ListBox1.Clear;

  for I := 0 to Pred(Length(Clientes)) do
    ListBox1.Items.Add( Clientes[I] );
end;

procedure TMainForm.Button5Click(Sender: TObject);
begin
  Socket.SocketServer.Start;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  Socket := TGenericSocket.New;
end;

end.
