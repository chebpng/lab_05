unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus,
  Windows;

type
  pel = ^elem;  // Тип pel - указатель на элемент типа elem
  elem = record
    s: integer;
    p: pel;  // Указатель на следующий элемент списка
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    ListBox1: TListBox;
    ListBox2: TListBox;
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
  n, ns, sn, z, o, v, sorted, temp: integer;
  mass, masss, smass, result: array of integer;
  trail, trailO: string;
  res: QWord;
  Linear, SortLinear: pel;
  DLinear, DSortLinear: integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button4Click(Sender: TObject);
var
  p1, p2, p3: pel;
  v, o, n: integer;

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
    Linear := p1^.p;
    DLinear := p1^.s;
  end
  else
  begin
      ListBox1.Items.Add('Кол-во элементов');
      ListBox1.Items.Add('>40');
          Linear := p1^.p;
    DLinear := p1^.s;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  p1, p2, p3, p4: pel;
  v, o, n: integer;

begin
  n := StrToInt(Edit1.Text);  // Получаем значение n из Edit1
  p1 := nil;  // Инициализируем начало списка
  Randomize();  // Инициализация генератора случайных чисел

  for v := 1 to n do
  begin
    New(p4);  // Создаём новый элемент списка
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

  // Очистка и добавление элементов в ListBox2
  ListBox2.Items.Clear;

  if n <= 40 then
  begin
    p2 := p1;  // Начинаем с начала списка
    for o := 1 to n do
    begin
      if p2 <> nil then
      begin
        ListBox2.Items.Add(IntToStr(p2^.s));  // Добавляем значение в ListBox2
        p2 := p2^.p;  // Переходим к следующему элементу
      end;
    end;
    SortLinear := p1^.p;
    DSortLinear := p1^.s;
   end
  else
  begin
      ListBox2.Items.Add('Кол-во элементов');
      ListBox2.Items.Add('>40');
          SortLinear := p1^.p;
    DSortLinear := p1^.s;
  end;

end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  // Слияние (еще не реализовано)
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  MyFile: TextFile;
  i: integer;
  p1: pel;

begin
  ListBox4.Items.Add('Выберите место для сохранения файла');
  SelectDirectoryDialog1.Execute;
  trail := SelectDirectoryDialog1.FileName;
  AssignFile(MyFile, trail + '\' + ComboBox1.Text + '.txt');
  Rewrite(MyFile);
  n := StrToInt(Edit1.Text);
  try
    if ListBox1.Items.Count >0 then
    begin
      WriteLn(MyFile, '----------Линейный----------');
      WriteLn(MyFile, DLinear);
      p1 := Linear;
      for i := 1 to n - 1 do
      begin
         WriteLn(MyFile, inttostr(p1^.s));
         p1 := p1^.p
      end;
      WriteLn(MyFile, ' ');
    end;


    if ListBox2.Items.Count >0 then
    begin
      WriteLn(MyFile, '----------Линейный сортировка вставками----------');
      WriteLn(MyFile, DSortLinear);
      p1 := SortLinear;
      for i := 1 to n - 1 do
      begin
         WriteLn(MyFile, inttostr(p1^.s));
         p1 := p1^.p
      end;
      WriteLn(MyFile, ' ');
    end;

  finally
    // Закрываем файл
    CloseFile(MyFile);
    ListBox4.Items.Add('Файл сохранен по пути - ' + trail + '\' + ComboBox1.Text + '.txt');
  end;
end;


procedure TForm1.Button2Click(Sender: TObject);
begin
  OpenDialog1.Execute;
  trailO := OpenDialog1.FileName; // путь к выбранному файлу
  ListBox4.Items.Add('Открытие файла ' + trailO); // сообщение в ListBox
  ShellExecute(0, 'open', PChar(trailO), nil, nil, SW_SHOWNORMAL);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Close;
end;
end.
