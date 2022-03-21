unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  FMX.Effects, FMX.Objects, FMX.Layouts, FMX.Platform,
  Androidapi.JNI.GraphicsContentViewText, System.Messaging, System.Actions,
  FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions;

type
  TMainForm = class(TForm)
    ToolBar1: TToolBar;
    Label1: TLabel;
    ToolBar2: TToolBar;
    Button1: TButton;
    ShadowEffect1: TShadowEffect;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Memo1: TMemo;
    ActionList1: TActionList;
    ShowShareSheetAction1: TShowShareSheetAction;
    procedure FormCreate(Sender: TObject);
    procedure  handleMessage(const Sender: TObject; const M: TMessage);
    function  handleLink(const linkIntent: JIntent): Boolean;
    procedure ShowShareSheetAction1BeforeExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses FMX.Platform.Android, Androidapi.Jni.Net, Androidapi.Helpers;

procedure TMainForm.FormCreate(Sender: TObject);
var androidLinkManager: IFMXApplicationEventService;
begin
  MainActivity.registerIntentAction(TJIntent.JavaClass.ACTION_VIEW);                              //Registers action VIEW, which corresponds to the URL opening the app
  TMessageManager.DefaultManager.SubscribeToMessage(TMessageReceivedNotification, handleMessage); //Subscribes the message notification to receive the intents once the app is already opened

  handleLink(MainActivity.getIntent);   //Gets the intent that opened the app in the first place
end;

procedure TMainForm.handleMessage(const Sender: TObject; const M: TMessage);
begin
  if M is TMessageReceivedNotification then
    handleLink(TMessageReceivedNotification(M).Value);  //Sends the intent received to the method handlelink
end;

procedure TMainForm.ShowShareSheetAction1BeforeExecute(Sender: TObject);
var URL: String;
begin
  URL:= 'myappurl.com/applinks';            //This is the URL that we're gonna share
  ShowShareSheetAction1.TextMessage:= URL;  //Starts the sharing action
end;

function  TMainForm.handleLink(const linkIntent: JIntent): Boolean;
var URL: JNet_URI;
begin
  result:= false;
  URL:= linkIntent.getData;                             //Gets the URL
  if URL <> Nil then
    Memo1.Lines.Add(JStringToString(URL.toString));     //Prints the URL to the memo
end;

end.
