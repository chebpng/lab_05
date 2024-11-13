unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  CheckLst, ShellAPI, Windows;

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
    procedure Button2Click(Sender: TObject);
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
  trail, trailO:string;
  res:QWord;

implementation

{$R *.lfm}

{ TForm1 }

{Да, массив можно считать линейным списком, так как он представляет собой упорядоченную структуру
данных, в которой элементы располагаются последовательно и могут быть доступны по индексу.

Основные характеристики линейного списка и массива:

Последовательное расположение: элементы расположены в памяти последовательно.
Доступ по индексу: элементы массива можно быстро найти по их индексу.
Фиксированный размер (для статических массивов): массивы имеют фиксированный размер после инициализации,
в отличие от некоторых типов списков, которые могут динамически изменяться.}

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




procedure TForm1.Button4Click(Sender: TObject);
type
  pel = ^elem;
  elem = record
    s: integer;
    p: pel;
  end;

var
  p1, p2, p3: pel;
  s, v, o, n: integer;

begin
  n := StrToInt(Edit1.Text);  // Получаем значение n из Edit1
  p1 := nil;  // Инициализируем начало списка
  p2 := nil;
  Randomize();  // Инициализация генератора случайных чисел
  v := 1;

  while v <= n do
  begin
    New(p3);  // Создаем новый элемент списка
    p3^.s := (1000 - Random(2000));  // Заполняем случайным значением

    if p1 = nil then
      p1 := p3  // Устанавливаем первый элемент списка
    else
      p2^.p := p3;  // Присваиваем следующий элемент для предыдущего

    p2 := p3;  // Обновляем текущий элемент
    p2^.p := nil;  // Последний элемент указывает на nil
    v := v + 1;
  end;

  // Очистка и добавление элементов в ListBox1
  ListBox1.Items.Clear;

  if n <= 40 then
  begin
    p2 := p1;  // Начинаем с начала списка
    for o := 1 to n do
    begin
      if p2 <> nil then
      begin
        ListBox1.Items.Add(IntToStr(p2^.s));  // Добавляем значение в ListBox1
        p2 := p2^.p;  // Переходим к следующему элементу
      end;
    end;

end;

end;

procedure TForm1.Button5Click(Sender: TObject);
//упорядоченный с включением от меньшего к большему
type
  pel = ^elem;
  elem = record
    s: integer;
    p: pel;
  end;

var
  p1, p2, p3, p4: pel;
  s, v, o, n: integer;

begin
  n := StrToInt(Edit1.Text);  // Получаем значение n из Edit1
  p1 := nil;  // Инициализируем начало списка
  Randomize();  // Инициализация генератора случайных чисел

  for v := 1 to n do
  begin
    new(p4);  // Создаём новый элемент списка
    p4^.s := (1000 - Random(2000));  // Присваиваем случайное значение в поле s
    p4^.p := nil; // Инициализируем указатель на следующий элемент как nil

    // Если список пуст, вставляем новый элемент как первый
    if p1 = nil then
    begin
      p1 := p4;
    end
    else
    begin
      p2 := p1;
      p3 := nil;

      // Поиск позиции для вставки нового элемента
      while (p2 <> nil) and (p2^.s < p4^.s) do
      begin
        p3 := p2;    // Запоминаем текущий элемент как предыдущий
        p2 := p2^.p; // Переходим к следующему элементу
      end;

      // Вставка нового элемента в найденную позицию
      if p3 = nil then
      begin
        // Вставляем в начало списка
        p4^.p := p1;
        p1 := p4;
      end
      else
      begin
        // Вставляем между элементами p3 и p2
        p3^.p := p4;
        p4^.p := p2;
      end;
    end;
  end;
  if n <= 40 then
  begin
    p2 := p1;  // Начинаем с начала списка
    for o := 1 to n do
    begin
      if p2 <> nil then
      begin
        ListBox1.Items.Add(IntToStr(p2^.s));  // Добавляем значение в ListBox1
        p2 := p2^.p;  // Переходим к следующему элементу
      end;
      end;
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

procedure TForm1.Button2Click(Sender: TObject);
begin
  OpenDialog1.Execute ;
  trailO := OpenDialog1.Filename; // путь к выбранному файлу
    ListBox4.Items.Add('Открытие файла ' + trailO); // сообщение в ListBox
    ShellExecute(0, 'open', PChar(trailO), nil, nil, SW_SHOWNORMAL);

  end;
end.

