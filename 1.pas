procedure Randomis(var mass:array of integer; n,z:integer);
begin
  randomize();
  setlength(mass, n);
  for z :=0 to n-1 do
  begin
    if random(2) = 0 then
      mass[z]:=random(1000)
    else
      mass[z]:=-1*(random(1000))
  end;
end;
var
  n,z: integer;
  mass:array of integer;
begin
  readln(n);
  Randomis(mass, n, z);
  for z := 0 to n-1 do
  begin
    write(mass[z], ' ');
  end;
end.