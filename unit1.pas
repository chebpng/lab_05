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
    procedure Button5Click(Sender: TObject);
  private

  public

  end;



var
  Form1: TForm1;
  n,z,sorted,temp: integer;
  mass,masssort:array of integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure Randomis(var mass: array of integer; n: integer);
var
  z: integer;  // Объявляем переменную z
begin
  Randomize();
  for z := 0 to n - 1 do
  begin
    if Random(2) = 0 then
      mass[z] := Random(1000)
    else
      mass[z] := -1 * (Random(1000));
  end;
end;

  procedure SpSort(var mass, masssort:array of integer; n,z:integer);
begin
    n := n - 1;
    while Sorted <> 1 do
    begin
      Sorted := 1;
      for z := 0 to n - 1 do
      begin
        if mass[z] > mass[z+1] then
        begin
          Sorted := 0;
          temp := mass[z];
          mass[z] := mass[z+1];
          mass[z+1] := temp;
        end;
      end;
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

procedure TForm1.Button5Click(Sender: TObject);
begin
  //упорядоченный
  SetLength(massSort, n);
  SpSort(mass, masssort, n, z);
  for z := 0 to n-1 do
  begin
  Memo3.Lines.AddStrings(inttostr(mass[z]));
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  close
end;

end.

