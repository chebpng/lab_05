unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Edit1: TEdit;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    OpenDialog1: TOpenDialog;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private

  public

  end;



var
  Form1: TForm1;
  n,z: integer;
  mass:array of integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure Randomis(var mass: array of integer; n: integer);
var
  z: integer;  // Объявляем переменную z
begin
  Randomize();
  //SetLength(mass, n);  // Устанавливаем длину массива
  for z := 0 to n - 1 do
  begin
    if Random(2) = 0 then
      mass[z] := Random(1000)
    else
      mass[z] := -1 * (Random(1000));
  end;


end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  n:=strtoint(Edit1.text);
  SetLength(mass, n);  // Устанавливаем длину массива
  Randomis(mass, n);
  for z := 0 to n-1 do
  begin
  Memo1.Lines.AddStrings(inttostr(mass[z]));
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  close
end;

end.

