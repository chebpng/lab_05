unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  CheckLst;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    ListBox4: TListBox;
    OpenDialog1: TOpenDialog;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private

  public

  end;



var
  Form1: TForm1;
  n, z, o, v, sorted, temp, elem: integer;
  mass,masss:array of integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure Randomis(var n:integer; var mass:array of integer);
var elem, z:integer;
begin

    Randomize();
    for z:=0 to n-1 do
    begin
    if Random(2) = 0 then
      mass[z] := Random(1000)
    else
      mass[z] := -1 * (Random(1000));
  end;
end;


procedure TForm1.Button4Click(Sender: TObject);
begin
        ListBox1.Items.Clear;
        n:=strtoint(Edit1.text);
        SetLength(mass, n);
        Randomis(n, mass);
        for z := 0 to n-1 do
        begin
             ListBox1.Items.Add(inttostr(mass[z]));
        end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  ListBox2.Items.Clear;
  //упорядоченный
  n:=strtoint(Edit1.text);
  randomize();
  setlength(mass, n);
  Randomis(n, mass);
  for z := 1 to n - 1 do
  begin
      temp := mass[z];
      o := z - 1;
      while (o >= 0) and (mass[o] > temp) do
      begin
          mass[o + 1] := mass[o];
          o := o - 1;
      end;
      mass[o + 1] := temp;
  end;
  for z := 0 to n-1 do
      begin
           ListBox2.Items.Add(inttostr(mass[z]));
      end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  close
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     //сохранение в файл
     SelectDirectoryDialog1.Execute
     := SelectDirectoryDialog1.FileName;
end;

end.

