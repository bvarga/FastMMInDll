unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    LDLLHandle: HModule;
    LShowProc: TProcedure;
  end;

var
  Form1: TForm1;

{$ifdef static}
procedure MyInit; stdcall; external 'dll.dll';
{$endif}

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  TStringList.Create;
  {$ifdef static}
  MyInit;
  {$else}
  LDLLHandle := LoadLibrary('dll.dll');
  if LDLLHandle <> 0 then
  begin
    try
      LShowProc := GetProcAddress(LDLLHandle, 'MyInit');
      if Assigned(LShowProc) then
        LShowProc;
    finally
      FreeLibrary(LDLLHandle);
    end;
  end;
  {$endif}
end;

end.
