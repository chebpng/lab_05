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
  n, ns, z, o, v, sorted, temp, elem: integer;
  mass,masss:array of integer;
  trail:string;

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
        if n <= 40 then
        begin
           for z := 0 to n-1 do
           begin
                  ListBox1.Items.Add(inttostr(mass[z]));
           end;
        end
        else
            for z := 0 to 39 do
            begin
                 ListBox1.Items.Add(inttostr(mass[z]));
            end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  ListBox2.Items.Clear;
  //упорядоченный
  ns:=strtoint(Edit1.text);
  randomize();
  setlength(masss, ns);
  Randomis(n, masss);
  for z := 1 to ns - 1 do
  begin
      temp := masss[z];
      o := z - 1;
      while (o >= 0) and (masss[o] > temp) do
      begin
          masss[o + 1] := masss[o];
          o := o - 1;
      end;
      masss[o + 1] := temp;
  end;
  if n <= 40 then
    begin
      for z := 0 to ns-1 do
          begin
               ListBox2.Items.Add(inttostr(masss[z]));
          end;
      end
      else
          for z := 0 to 39 do
          begin
            ListBox2.Items.Add(inttostr(masss[z]));
          end;
    end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  close
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  MyFile:TextFile;
  i:integer;
begin
     //сохранение в файл
     ListBox4.Items.Add('Выберите место для сохранения файла');
     SelectDirectoryDialog1.Execute;
     trail := SelectDirectoryDialog1.FileName;
     AssignFile(MyFile, trail+'\'+ComboBox1.text+'.txt');
     Rewrite(MyFile);
     try
         // Используем цикл для записи всех элементов ComboBox

         if ListBox1.Items.Count >0 then
         begin
           WriteLn(MyFile, '----------Линейный----------');
           for i := 0 to n-1 do
           begin
             WriteLn(MyFile, mass[i]);
           end;
         end;

        if ListBox2.Items.Count >0 then
        begin
          WriteLn(MyFile, '----------Упорядоченный----------');
          for i := 0 to ListBox2.Items.Count - 1 do
          begin
            WriteLn(MyFile, ListBox2.Items[i]);
          end;
        end;



        if ListBox3.Items.Count >0 then
        begin
          WriteLn(MyFile, '----------Слияние----------');
          for i := 0 to ListBox3.Items.Count - 1 do
          begin
            WriteLn(MyFile, ListBox3.Items[i]);
          end;
        end;

       finally
         // Закрываем файл
         CloseFile(MyFile);
     ListBox4.Items.Add('Файл сохранен по пути - '+trail+'\'+ComboBox1.text+'.txt');

        end;
     end;
end.

