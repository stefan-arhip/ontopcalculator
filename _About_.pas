unit _About_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, StdCtrls, ShellApi;

type
  TAbout_ = class(TForm)
    Shape2: TShape;
    MainMenu1: TMainMenu;
    Menu1: TMenuItem;
    Exit1: TMenuItem;
    ProgramIcon: TImage;
    Version: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    Moving:Boolean;
    Delta:TPoint;
  public
    { Public declarations }
  end;

var
  About_: TAbout_;

implementation

{$R *.DFM}

Uses _Calculator_;

procedure TAbout_.FormCreate(Sender: TObject);
begin
  Width:=123;
  Height:=123;
  Left:=(Screen.Width-Width) Div 2;
  Top:=(Screen.Height-Height) Div 2;
  SetTransparentForm(Handle,255*(100-Transparence) Div 100);
end;

procedure TAbout_.Exit1Click(Sender: TObject);
begin
  CalcForm.Enabled:=True;
  CalcForm.Left:=About_.Left;
  CalcForm.Top:=About_.Top;
  CalcForm.Show;
  Close;
end;

procedure TAbout_.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If Button=mbLeft Then
    Begin
      Moving:=True;
      Delta:=Point(X,Y);
    End;
end;

procedure TAbout_.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Const SnapSize:Integer=25;
Var l,t:Integer;
    WorkRect:TRect;
begin
  If Moving Then // You should add support for DualHead/Matrox Configurations
    Begin
      If Not SystemParametersInfo(SPI_GETWORKAREA,0,@WorkRect,0) Then
        WorkRect:=Bounds(0,0,Screen.Width,Screen.Height);
      Dec(WorkRect.Right,Width);
      Dec(WorkRect.Bottom,Height);
      l:=Left+X-Delta.X;
      t:=Top+Y-Delta.Y;
      If (l<WorkRect.Left+SnapSize) And (l>WorkRect.Left-SnapSize) Then
        l:=WorkRect.Left;
      If (l>WorkRect.Right-SnapSize) And (l<WorkRect.Right+SnapSize) Then
          l:=WorkRect.Right;
      If (t<WorkRect.Top+SnapSize) And (t>WorkRect.Top-SnapSize) Then
        t:=WorkRect.Top;
      If (t>WorkRect.Bottom-SnapSize) And (t<WorkRect.Bottom+SnapSize) Then
        t:=WorkRect.Bottom;
      Left:=l;  // NOTE: This will always "Show window
      Top:=t;   // contents while dragging"
    End;
end;

procedure TAbout_.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Moving:=False;
end;     

procedure TAbout_.Label2Click(Sender: TObject);
begin
  ShellExecute(0, Nil, PChar('http:\\'+Label2.Caption), Nil, Nil, SW_NORMAL);
end;

procedure TAbout_.FormPaint(Sender: TObject);
Var Row,Ht:Word;
    r,g,b:Byte;
begin
  Font.Color:=CalcForm.ColorGrid3.ForeGroundColor;
  Label1.Font.Color:=CalcForm.ColorGrid3.ForeGroundColor;
  //Entry.Color:=ColorGrid2.ForeGroundColor;
  Ht:=(ClientHeight+255) div 256;
  for Row:=0 to ClientHeight do
    with Canvas do
      begin
        r:=Row*(GetRValue(CalcForm.ColorGrid1.ForeGroundColor)-
                GetRValue(CalcForm.ColorGrid2.ForeGroundColor)) Div ClientHeight;
        g:=Row*(GetGValue(CalcForm.ColorGrid1.ForeGroundColor)-
                GetGValue(CalcForm.ColorGrid2.ForeGroundColor)) Div ClientHeight;
        b:=Row*(GetBValue(CalcForm.ColorGrid1.ForeGroundColor)-
                GetBValue(CalcForm.ColorGrid2.ForeGroundColor)) Div ClientHeight;
        Brush.Color:=RGB(r,g,b);
        FillRect(Rect(0,Row*Ht,ClientWidth,(Row+1)*Ht));
      end;
end;

end.
