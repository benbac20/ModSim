program Television;

uses
  Forms,
  UMain in 'UMain.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'TÚlÚvision';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
