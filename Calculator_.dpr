program Calculator_;

uses
  Forms,
  _Calculator_ in '_Calculator_.pas' {CalcForm},
  _About_ in '_About_.pas' {About_};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TCalcForm, CalcForm);
  Application.CreateForm(TAbout_, About_);
  Application.Run;
end.
