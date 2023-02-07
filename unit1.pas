unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList, StdCtrls,
  LCLIntf, LMessages;

const
  WM_KILLBTN_MSG = LM_USER + $101;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    ActCreateBtn: TAction;
    ActKillBtn: TAction;
    ActionList1: TActionList;
    procedure ActCreateBtnExecute(Sender: TObject);
    procedure ActKillBtnExecute(Sender: TObject);
    procedure FormClick(Sender: TObject);
  private

  public
    procedure WmKillBtn(var Msg: TLMessage) message WM_KILLBTN_MSG;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.ActCreateBtnExecute(Sender: TObject);
var
  btn: TButton;
begin
  btn:= TButton.Create(Self);
  with btn do
  begin
    Parent:= Self;
    Caption:= 'Click Me To Kill';
    Visible:= True;
    AutoSize:= True;
    OnClick:= @ActKillBtnExecute;
    Left:= ScreenToControl(Mouse.CursorPos).X;
    Top:= ScreenToControl(Mouse.CursorPos).Y;
  end;
end;

procedure TfrmMain.ActKillBtnExecute(Sender: TObject);
begin
  PostMessage(Self.Handle,WM_KILLBTN_MSG,PtrInt(TButton(Sender)),0);
end;

procedure TfrmMain.FormClick(Sender: TObject);
begin
  ActCreateBtnExecute(Sender);
end;

procedure TfrmMain.WmKillBtn(var Msg: TLMessage);
var
  btn: TButton;
begin
  btn:= TButton(Msg.wParam);
  if Assigned(btn) then FreeAndNil(btn);
end;

end.

