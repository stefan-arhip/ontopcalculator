unit _Calculator_;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ColorGrd, Buttons, StdCtrls, ExtCtrls, Menus, ShellApi;

Const wm_IconNotification = wm_User + 1909;
      Transparence :Byte=10;

procedure SetTransparentForm(AHandle : THandle; AValue : byte);

type
  TCalcForm = class(TForm)
    ExitButton: TSpeedButton;
    Zero: TSpeedButton;
    One: TSpeedButton;
    Two: TSpeedButton;
    Three: TSpeedButton;
    Four: TSpeedButton;
    Five: TSpeedButton;
    Six: TSpeedButton;
    Seven: TSpeedButton;
    Eight: TSpeedButton;
    Nine: TSpeedButton;
    Decimal: TSpeedButton;
    Clear: TSpeedButton;
    Plus: TSpeedButton;
    Minus: TSpeedButton;
    Multiply: TSpeedButton;
    Divide: TSpeedButton;
    Equal: TSpeedButton;
    ColorGrid1: TColorGrid;
    ColorGrid2: TColorGrid;
    Shape1: TShape;
    Shape2: TShape;
    MainMenu1: TMainMenu;
    Menu1: TMenuItem;
    N01: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    N41: TMenuItem;
    N51: TMenuItem;
    N61: TMenuItem;
    N71: TMenuItem;
    N81: TMenuItem;
    N91: TMenuItem;
    Cifre1: TMenuItem;
    Operators1: TMenuItem;
    N1: TMenuItem;
    Plus1: TMenuItem;
    Minus1: TMenuItem;
    Multiply1: TMenuItem;
    Divide1: TMenuItem;
    N2: TMenuItem;
    Equal1: TMenuItem;
    Special1: TMenuItem;
    Close1: TMenuItem;
    N3: TMenuItem;
    Backspace1: TMenuItem;
    Clear1: TMenuItem;
    Tools1: TMenuItem;
    IncreaseColor11: TMenuItem;
    DecreaseColor11: TMenuItem;
    N4: TMenuItem;
    IncreaseColor21: TMenuItem;
    DecreaseColor21: TMenuItem;
    ColorGrid3: TColorGrid;
    N5: TMenuItem;
    IncreaseColor31: TMenuItem;
    DecreaseColor31: TMenuItem;
    Equal2: TMenuItem;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape20: TShape;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    About1: TMenuItem;
    History1: TMenuItem;
    MenuItem2: TMenuItem;
    OnTop1: TMenuItem;
    Refresh2: TMenuItem;
    MenuItem3: TMenuItem;
    Transparence1: TMenuItem;
    MenuItem4: TMenuItem;
    Exit1: TMenuItem;
    Increase1: TMenuItem;
    Decrease1: TMenuItem;
    N6: TMenuItem;
    Increasetransparence1: TMenuItem;
    Decreasetransparence1: TMenuItem;
    Color11: TMenuItem;
    Increase2: TMenuItem;
    Decrease2: TMenuItem;
    Color21: TMenuItem;
    Increase3: TMenuItem;
    Decrease3: TMenuItem;
    Colorfont1: TMenuItem;
    Increase4: TMenuItem;
    Decrease4: TMenuItem;
    Help1: TMenuItem;
    About2: TMenuItem;
    Shape21: TShape;
    Fraction: TSpeedButton;
    Sqrt1: TSpeedButton;
    Shape22: TShape;
    sqr1: TSpeedButton;
    Entry: TMemo;
    procedure FormPaint(Sender: TObject);
    procedure ZeroClick(Sender: TObject);
    procedure OneClick(Sender: TObject);
    procedure TwoClick(Sender: TObject);
    procedure ThreeClick(Sender: TObject);
    procedure FourClick(Sender: TObject);
    procedure FiveClick(Sender: TObject);
    procedure SixClick(Sender: TObject);
    procedure SevenClick(Sender: TObject);
    procedure EightClick(Sender: TObject);
    procedure NineClick(Sender: TObject);
    procedure PlusClick(Sender: TObject);
    procedure MinusClick(Sender: TObject);
    procedure MultiplyClick(Sender: TObject);
    procedure DivideClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure EntryChange(Sender: TObject);
    procedure EqualClick(Sender: TObject);
    procedure DecimalClick(Sender: TObject);
    procedure Display;
    procedure ExitButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ColorGrid1Change(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IncreaseColor11Click(Sender: TObject);
    procedure DecreaseColor11Click(Sender: TObject);
    procedure IncreaseColor21Click(Sender: TObject);
    procedure DecreaseColor21Click(Sender: TObject);
    procedure IncreaseColor31Click(Sender: TObject);
    procedure DecreaseColor31Click(Sender: TObject);
    procedure Increase1Click(Sender: TObject);
    procedure Decrease1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FractionClick(Sender: TObject);
    procedure Sqrt1Click(Sender: TObject);
    procedure sqr1Click(Sender: TObject);
    procedure Backspace1Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Moving:Boolean;
    Delta:TPoint;
    nid: TNOTIFYICONDATA;
    TrayIconId: UINT;
    procedure doMinimize(Sender:TObject);
    function AddTrayIconId(iconId: UINT; icon: THandle; tip: PChar): boolean;
    function DeleteTrayIconId(iconId: UINT): boolean;
  public
    { Public declarations }
    ICO:TIcon;
  protected
    procedure WMIconNotification(var Msg: TMessage); message wm_IconNotification;
  end;

var
  CalcForm: TCalcForm;
  Total   : Extended;
  Complete: Boolean;
  Operator: Char;

implementation

uses _About_;

{$R *.DFM}

Const WS_EX_LAYERED=$80000;
      LWA_ALPHA    =2;

type
 TSetLayeredWindowAttributes = function (
     hwnd : HWND;         // handle to the layered window
     crKey : TColor;      // specifies the color key
     bAlpha : byte;       // value for the blend function
     dwFlags : DWORD      // action
     ): BOOL; stdcall;

procedure TCalcForm.doMinimize(Sender:TObject);
begin
  ImageList1.GetIcon(0, ICO);
  AddTrayIconId(0, ICO.Handle,PChar('Ontop Calculator'));
  Hide;
end;

function TCalcForm.AddTrayIconId(iconId: UINT; icon: THandle; tip: PChar): boolean;
begin
  nid.uID := iconId;
  nid.hIcon := icon;
  if tip <> nil then
    StrLCopy(nid.szTip, tip, SizeOf(nid.szTip))
  else
    nid.szTip[0] := #0;
  Result := Shell_NotifyIcon(NIM_ADD, @nid);
end;

function TCalcForm.DeleteTrayIconId(iconId: UINT): boolean;
begin
  nid.uId := iconId;
  Result := Shell_NotifyIcon(NIM_DELETE, @nid);
  nid.hIcon:=0;
end;

procedure TCalcForm.WMIconNotification(var Msg: TMessage);
var
  MouseMsg: longint;
  Pt: TPoint;
begin
  MouseMsg := Msg.LParam;
  case MouseMsg of
    wm_RButtonUp:
      begin
        GetCursorPos(Pt);
        popupmenu1.PopUp(Pt.X,Pt.Y);
      end;
    wm_LButtonDblClk:  //popShowClick(Self);
      ;//Easter1Click(Self);
  end;
end;

procedure SetTransparentForm(AHandle : THandle; AValue : byte);
var
 Info: TOSVersionInfo;
 SetLayeredWindowAttributes: TSetLayeredWindowAttributes;
begin
 Info.dwOSVersionInfoSize := SizeOf(Info);                            //Check Windows version
 GetVersionEx(Info);
 if (Info.dwPlatformId = VER_PLATFORM_WIN32_NT) and (Info.dwMajorVersion >= 5) then
   begin
     SetLayeredWindowAttributes := GetProcAddress(GetModulehandle(user32), 'SetLayeredWindowAttributes');
      if Assigned(SetLayeredWindowAttributes) then
        begin
          SetWindowLong(AHandle, GWL_EXSTYLE, GetWindowLong(AHandle, GWL_EXSTYLE) or WS_EX_LAYERED);
          SetLayeredWindowAttributes(AHandle, 0, AValue, LWA_ALPHA);  //Make form transparent
        end;
   end;
end;

// the missing delay() procedure, delay in milliseconds
procedure Delay(msecs: integer);
var
  FirstTickCount: longint;
begin
  FirstTickCount := GetTickCount;
   repeat
     Application.ProcessMessages; { allowing access to other controls }
   until ((GetTickCount-FirstTickCount) >= Longint(msecs));
end;

procedure Calculate(Number: Extended; NextOp: Char);
begin
  if not Complete or (Total = 0.0) then
  case Operator of
     '+': Total := Total + Number;
     '-': Total := Total - Number;
     'x': Total := Total * Number;
     '/':
       begin
         if Number <> 0 then
           Total := Total / Number
         else
         begin
           CalcForm.Entry.Text := 'Error!';
           Delay(3000);
         end;
       end;
  end;
  Operator := NextOp;
  Complete := True;
end;

procedure TCalcForm.FormPaint(Sender: TObject);
Var Row,Ht:Word;
    r,g,b:Byte;
begin
  Font.Color:=ColorGrid3.ForeGroundColor;
  Entry.Color:=ColorGrid2.ForeGroundColor;
  Ht:=(ClientHeight+255) div 256;
  for Row:=0 to ClientHeight do
    with Canvas do
      begin
        r:=Row*(GetRValue(ColorGrid1.ForeGroundColor)-
                GetRValue(ColorGrid2.ForeGroundColor)) Div ClientHeight;
        g:=Row*(GetGValue(ColorGrid1.ForeGroundColor)-
                GetGValue(ColorGrid2.ForeGroundColor)) Div ClientHeight;
        b:=Row*(GetBValue(ColorGrid1.ForeGroundColor)-
                GetBValue(ColorGrid2.ForeGroundColor)) Div ClientHeight;
        Brush.Color:=RGB(r,g,b);
        FillRect(Rect(0,Row*Ht,ClientWidth,(Row+1)*Ht));
      end;
end;

procedure TCalcForm.ZeroClick(Sender: TObject);
begin
  if Complete then Entry.Text := '';
  Entry.Text := Entry.Text + '0';
end;

procedure TCalcForm.OneClick(Sender: TObject);
begin
  if Complete then Entry.Text := '';
  Entry.Text := Entry.Text + '1';
end;

procedure TCalcForm.TwoClick(Sender: TObject);
begin
  if Complete then Entry.Text := '';
  Entry.Text := Entry.Text + '2';
end;

procedure TCalcForm.ThreeClick(Sender: TObject);
begin
  if Complete then Entry.Text := '';
  Entry.Text := Entry.Text + '3';
end;

procedure TCalcForm.FourClick(Sender: TObject);
begin
  if Complete then Entry.Text := '';
  Entry.Text := Entry.Text + '4';
end;

procedure TCalcForm.FiveClick(Sender: TObject);
begin
  if Complete then Entry.Text := '';
  Entry.Text := Entry.Text + '5';
end;

procedure TCalcForm.SixClick(Sender: TObject);
begin
  if Complete then Entry.Text := '';
  Entry.Text := Entry.Text + '6';
end;

procedure TCalcForm.SevenClick(Sender: TObject);
begin
  if Complete then Entry.Text := '';
  Entry.Text := Entry.Text + '7';
end;

procedure TCalcForm.EightClick(Sender: TObject);
begin
  if Complete then Entry.Text := '';
  Entry.Text := Entry.Text + '8';
end;

procedure TCalcForm.NineClick(Sender: TObject);
begin
  if Complete then Entry.Text := '';
  Entry.Text := Entry.Text + '9';
end;

procedure TCalcForm.PlusClick(Sender: TObject);
begin
  Calculate(StrToFloat(Entry.Text), '+');  
  Display;
end;

procedure TCalcForm.MinusClick(Sender: TObject);
begin
  Calculate(StrToFloat(Entry.Text), '-');
  Display;
end;

procedure TCalcForm.MultiplyClick(Sender: TObject);
begin
  Calculate(StrToFloat(Entry.Text), 'x');
  Display;
end;

procedure TCalcForm.DivideClick(Sender: TObject);
begin
  Calculate(StrToFloat(Entry.Text), '/');
  Display;
end; 

procedure TCalcForm.ClearClick(Sender: TObject);
begin
  Entry.Text := '0';
  Complete := True;
  Total := 0.0;
  Operator := '+';
end;

procedure TCalcForm.EntryChange(Sender: TObject);
begin
  if Entry.Text = '' then Complete := False;
end;

procedure TCalcForm.EqualClick(Sender: TObject);
begin
  Calculate(StrToFloat(Entry.Text), '+');
  Display;
  Complete := True;
  Total := 0.0;
end;

procedure TCalcForm.DecimalClick(Sender: TObject);
begin
  if Complete then Entry.Text := '';
  if Pos('.', Entry.Text) = 0 then
    Entry.Text := Entry.Text + '.';
end;

// format the result display
procedure TCalcForm.Display;
{var Sf: String;}
begin
  {if Frac(Total) = 0 then   // no fraction, no decimals
    Str(Total:0:0, Sf)
  else
  if abs(Total) < 0.1 then
    Str(Total:0:12, Sf)
  else
  if abs(Total) < 1.0 then
    Str(Total:0:10, Sf)
  else
  if abs(Total) < 100.0 then
    Str(Total:0:8, Sf)
  else
  if abs(Total) < 10000.0 then
    Str(Total:0:4, Sf)
  else
    Str(Total:0:2, Sf);
  Entry.Text := Sf;}
  Entry.Text:=FloatToStr(Total);//FloatToStrF(Total,ffExponent,18,-2);
end;

procedure TCalcForm.ExitButtonClick(Sender: TObject);
begin
  DeleteTrayIconId(TrayIconID);
  Close;
end;

procedure TCalcForm.FormCreate(Sender: TObject);
begin
  //Plus1.ShortCut := ShortCut(VK_ADD, []);
  ///
  Width:=123; //135
  Height:=123;
  Left:=(Screen.Width-Width) Div 2;
  Top:=(Screen.Height-Height) Div 2;
  Complete := True;
  Entry.Text:='0';
  Total := 0.0;
  Operator := '+';
  ICO:=TIcon.Create;
  nid.cbSize := SizeOf(TNOTIFYICONDATA);
  nid.Wnd := Handle;
  nid.uFlags := NIF_MESSAGE or NIF_ICON or NIF_TIP;
  nid.uCallbackMessage := wm_IconNotification;
  SetWindowLong(Application.Handle,GWL_EXSTYLE,WS_EX_TOOLWINDOW);
  SetTransparentForm(Handle,255*(100-Transparence) Div 100);
  Transparence1.Caption:='&Transparence - '+IntToStr(Transparence)+'%';
  Color11.Caption:='Color &up - '+IntToStr(ColorGrid1.ForeGroundIndex)+'/15';
  Color21.Caption:='Color &down - '+IntToStr(ColorGrid2.ForeGroundIndex)+'/15';
  Colorfont1.Caption:='Color &font - '+IntToStr(ColorGrid3.ForeGroundIndex)+'/15';
  doMinimize(Self);
end;    

procedure TCalcForm.ColorGrid1Change(Sender: TObject);
begin
  Refresh;
end;

procedure TCalcForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If Button=mbLeft Then
    Begin
      Moving:=True;
      Delta:=Point(X,Y);
    End;
end;

procedure TCalcForm.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
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

procedure TCalcForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Moving:=False;
end;

procedure TCalcForm.IncreaseColor11Click(Sender: TObject);
begin
  If ColorGrid1.ForeGroundIndex>=14 Then
    ColorGrid1.ForeGroundIndex:=15
  Else
    ColorGrid1.ForeGroundIndex:=ColorGrid1.ForeGroundIndex+1;
  Color11.Caption:='Color &up '+IntToStr(ColorGrid1.ForeGroundIndex)+'/15';
  ColorGrid1Change(Sender);
end;

procedure TCalcForm.DecreaseColor11Click(Sender: TObject);
begin
  If ColorGrid1.ForeGroundIndex<=1 Then
    ColorGrid1.ForeGroundIndex:=0
  Else
    ColorGrid1.ForeGroundIndex:=ColorGrid1.ForeGroundIndex-1;
  Color11.Caption:='Color &up '+IntToStr(ColorGrid1.ForeGroundIndex)+'/15';
  ColorGrid1Change(Sender);
end;

procedure TCalcForm.IncreaseColor21Click(Sender: TObject);
begin
  If ColorGrid2.ForeGroundIndex>=14 Then
    ColorGrid2.ForeGroundIndex:=15
  Else
    ColorGrid2.ForeGroundIndex:=ColorGrid2.ForeGroundIndex+1;
  Color21.Caption:='Color &down '+IntToStr(ColorGrid2.ForeGroundIndex)+'/15';
  ColorGrid1Change(Sender);
end;

procedure TCalcForm.DecreaseColor21Click(Sender: TObject);
begin
  If ColorGrid2.ForeGroundIndex<=1 Then
    ColorGrid2.ForeGroundIndex:=0
  Else
    ColorGrid2.ForeGroundIndex:=ColorGrid2.ForeGroundIndex-1;
  Color21.Caption:='Color &down '+IntToStr(ColorGrid2.ForeGroundIndex)+'/15';
  ColorGrid1Change(Sender);
end;

procedure TCalcForm.IncreaseColor31Click(Sender: TObject);
begin
  If ColorGrid3.ForeGroundIndex>=14 Then
    ColorGrid3.ForeGroundIndex:=15
  Else
    ColorGrid3.ForeGroundIndex:=ColorGrid3.ForeGroundIndex+1;
  Colorfont1.Caption:='Color &font '+IntToStr(ColorGrid3.ForeGroundIndex)+'/15';
  ColorGrid1Change(Sender);
end;

procedure TCalcForm.DecreaseColor31Click(Sender: TObject);
begin
  If ColorGrid3.ForeGroundIndex<=1 Then
    ColorGrid3.ForeGroundIndex:=0
  Else
    ColorGrid3.ForeGroundIndex:=ColorGrid3.ForeGroundIndex-1;
  Colorfont1.Caption:='Color &font '+IntToStr(ColorGrid3.ForeGroundIndex)+'/15';
  ColorGrid1Change(Sender);
end;

procedure TCalcForm.Increase1Click(Sender: TObject);
begin
  If Transparence>=90 Then
    Transparence:=95
  Else
    Transparence:=Transparence+5;
  SetTransparentForm(Handle,255*(100-Transparence) Div 100);
  Transparence1.Caption:='&Transparence '+IntToStr(Transparence)+'%';
end;

procedure TCalcForm.Decrease1Click(Sender: TObject);
begin
  If Transparence<=5 Then
    Transparence:=0
  Else
    Transparence:=Transparence-5;
  SetTransparentForm(Handle,255*(100-Transparence) Div 100);
  Transparence1.Caption:='&Transparence '+IntToStr(Transparence)+'%';
end;

procedure TCalcForm.About1Click(Sender: TObject);
begin
  About_.Left:=CalcForm.Left;
  About_.Top:=CalcForm.Top;
  CalcForm.Enabled:=False;
  CalcForm.Hide;
  About_.ShowModal;
end;

procedure TCalcForm.FractionClick(Sender: TObject);
begin
  If StrToFloat(Entry.Text)<>0 Then
    Total:=1/(StrToFloat(Entry.Text))
  Else
    Begin
      CalcForm.Entry.Text:='Error!';
      Delay(3000);
      CalcForm.Entry.Text:='0';
    End;
  Complete:=True;
  Display;
end;

procedure TCalcForm.Sqrt1Click(Sender: TObject);
begin
  If StrToFloat(Entry.Text)>=0 Then
    Total:=Sqrt(StrToFloat(Entry.Text))
  Else
    Begin
      CalcForm.Entry.Text := 'Error!';
      Delay(3000);
      CalcForm.Entry.Text :='0';
    End;
  Complete:=True;
  Display;
end;            

procedure TCalcForm.sqr1Click(Sender: TObject);
begin
  Total:=sqr(StrToFloat(Entry.Text));
  Complete:=True;
  Display;
end;

procedure TCalcForm.Backspace1Click(Sender: TObject);
Var s:String;
begin
  s:=Entry.Text;
  Delete(s,Length(s),1);
  If Length(s)=0 Then
    s:='0';
  Entry.Text:=s;
end;

procedure TCalcForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  Case Key Of
    '+':PlusClick(Sender);
    '-':MinusClick(Sender);
    '*':MultiplyClick(Sender);
    '/':DivideClick(Sender);
  End;
end;

end.
