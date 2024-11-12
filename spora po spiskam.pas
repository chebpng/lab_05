type
  PNode = ^Node;
  Node = record
    data: Integer;
    next: PNode;
  end;

var
  head, current, newNode: PNode;
  i: Integer;
begin
  head := nil; // Начинаем с пустого списка

  // Цикл для создания 10 узлов
  for i := 1 to 10 do
  begin
    New(newNode);         // Создаем новый узел
    newNode^.data := i;    // Присваиваем данные (например, от 1 до 10)
    newNode^.next := nil;  // Новый узел пока последний, поэтому next указывает на nil

    if head = nil then
    begin
      head := newNode;     // Если это первый узел, то устанавливаем его как голову списка
      current := head;     // И устанавливаем текущий узел как голову
    end
    else
    begin
      current^.next := newNode; // Связываем предыдущий узел с новым
      current := newNode;       // Перемещаем указатель current на новый узел
    end;
  end;
  readln();
end.