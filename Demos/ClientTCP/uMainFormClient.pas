unit uMainFormClient;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Layouts, FMX.ListBox, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, IdComponent, IdBaseComponent,
  IdTCPConnection, IdTCPClient, System.JSON,
  GenericSocket,
  GenericSocket.Server,
  GenericSocket.Client,
  GenericSocket.Message,
  GenericSocket.Interfaces;

type
  TForm5 = class(TForm)
    Layout1: TLayout;
    Button4: TButton;
    Layout2: TLayout;
    Memo1: TMemo;
    Button1: TButton;
    edSocketName2: TEdit;
    edClientName: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ClientSocket : iGenericSocket;

    procedure SendPrivateMessage(aClinetName:string;aMassage:string);
  public
    { Public declarations }
    function route(aMessage : String) : String;
  end;

var
  Form5: TForm5;
implementation

{$R *.fmx}

procedure TForm5.Button1Click(Sender: TObject);
begin
 //should use rest api to send message and the server can write into client socket
 //ClientSocket.Send(edSocketName.Text,'hi babe');
end;

procedure TForm5.Button4Click(Sender: TObject);
begin
  ClientSocket
    .SocketClient
      .RegisterCallback('/route', route)
      .RegisterCallback('/', route) //any message
      .Connect('192.168.0.133', 8080,edClientName.Text);
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  ClientSocket := TGenericSocket.New;
end;

function TForm5.route(aMessage: String): String;
begin
  Result := 'Callback '+aMessage+' from '+edClientName.Text;
end;

procedure TForm5.SendPrivateMessage(aClinetName, aMassage: string);
var
  JSONMessage : TJSONObject;
begin
  JSONMessage :=
    TJSONObject
      .Create
      .AddPair('title', 'SOCKET_MESSAGE')
      .AddPair('body', TJSONObject.Create.AddPair('message', AMessage));

  try
    ClientSocket.SocketClient.IOHandler.WriteLn(JSONMessage.ToJSON);
  finally
    JSONMessage.Free;
  end;
end;

end.
