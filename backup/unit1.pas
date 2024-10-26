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
    procedure Button6Click(Sender: TObject);
  private

  public

  end;



var
  Form1: TForm1;
  n, ns, sn, z, o, v, sorted, temp, elem: integer;
  mass,masss,smass,result:array of integer;
  trail:string;

implementation

{$R *.lfm}

{ TForm1 }

procedure Merge(var arr, arr1: array of Integer; sn, n1: Integer; var res: array of Integer);
var
  l, r, k: Integer;
begin
  l := 0;
  r := 0;
  k := 0;

  while (l < sn) and (r < n1) do
    begin
      if arr[l] <= arr1[r] then
      begin
        res[k] := arr[l];
        l := l + 1;
      end
      else
      begin
        res[k] := arr1[r];
        r := r + 1;
      end;
      k := k + 1;
    end;

  while l < sn do
    begin
      res[k] := arr[l];
      l := l + 1;
      k := k + 1;
    end;

    while r < n1 do
    begin
      res[k] := arr1[r];
      r := r + 1;
      k := k + 1;
    end;
end;

procedure MergeSort(var smass: array of Integer; sn: Integer);
var
  mid, i: Integer;
  leftArr, rightArr, result: array of Integer;
begin
  if sn < 2 then
    Exit;

  mid := sn div 2;

  SetLength(leftArr, mid);
  SetLength(rightArr, sn - mid);

  for i := 0 to mid - 1 do
    leftArr[i] := smass[i];

  for i := mid to sn - 1 do
    rightArr[i - mid] := smass[i];

  MergeSort(leftArr, mid);
  MergeSort(rightArr, sn - mid);

  SetLength(result, sn);
  Merge(leftArr, rightArr, mid, sn - mid, result);

  for i := 0 to sn - 1 do
    smass[i] := result[i];
end;

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
  if ns <= 40 then
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

procedure TForm1.Button6Click(Sender: TObject);
begin
  //cлияние
  ListBox3.Items.Clear;
  sn:=strtoint(Edit1.text);
  randomize();
  setlength(smass, sn);
  setlength(result, sn);
  Randomis(sn, smass);
  MergeSort(smass, sn);
  if sn <= 40 then
    begin
      for z := 0 to sn-1 do
          begin
               ListBox3.Items.Add(inttostr(smass[z]));
          end;
      end
      else
          for z := 0 to 39 do
          begin
            ListBox3.Items.Add(inttostr(smass[z]));
          end;
    end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  close
end;

procedure TForm1.Button1Click(Sender: TObject);//сохранение в файл
var
  MyFile:TextFile;
  i:integer;
begin
     ListBox4.Items.Add('Выберите место для сохранения файла');
     SelectDirectoryDialog1.Execute;
     trail := SelectDirectoryDialog1.FileName;
     AssignFile(MyFile, trail+'\'+ComboBox1.text+'.txt');
     Rewrite(MyFile);
     try
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
          for i := 0 to ns-1 do
          begin
            WriteLn(MyFile, masss[i]);
          end;
        end;

        if ListBox3.Items.Count >0 then
        begin
          WriteLn(MyFile, '----------Слияние----------');
          for i := 0 to sn - 1 do
          begin
            WriteLn(MyFile, smass[i]);
          end;
        end;
       finally
         // Закрываем файл
         CloseFile(MyFile);
     ListBox4.Items.Add('Файл сохранен по пути - '+trail+'\'+ComboBox1.text+'.txt');
        end;
     end;
end.

