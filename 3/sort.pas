program sort;
uses windows;
type m=array[1..10] of longint;
  adres=^list;
  list=record
    a:smallint;
    next:adres;
    last:adres;
  end;

procedure massvibor(var mass:m);
var i,j:smallint;
res:longint;
begin
  for i:=1 to 10 do begin
  for j:=1 to 11-i do begin
  if mass[j]>mass[j+1] then begin res:=mass[j]; mass[j]:=mass[j+1]; mass[j+1]:=res;  end;
end;
end;
end;
procedure massobmen(var mass:m);
var i,j,maxn:smallint;
res,max:longint;
begin

  for i:=1 to 10 do begin
  max:=-1000000;
  for j:=1 to 10-i do begin
  if mass[j]>max then begin maxn:=j;max:=mass[j]; end;
end;
res:=mass[j]; mass[j]:=max; mass[maxn]:=res;
end;
end;
procedure massvstavka(var mass:m);
var i,j:smallint;
res:longint;
begin
  for i:=2 to 10 do begin
  res:=mass[i];
  j:=i;
  while mass[j-1]>res do begin mass[j]:=mass[j-1]; j:=j-1; end;
  mass[j]:=res;
  end;
end;
procedure listvibor(k:smallint; var head:adres);
var i,j:smallint;
res:longint;
rab:adres;
begin
  for i:=1 to k do begin
  rab:=head;
  for j:=1 to k-i do begin
  if rab^.a>rab^.next^.a then begin
    res:=rab^.a;
    rab^.a:=rab^.next^.a;
    rab^.next^.a:=res;  end;
  rab:=rab^.next;
end;
end;
end;
procedure listobmen(k:smallint; var head:adres);
var i,j,l:smallint;
res,max:longint;
maxn,rab,rab1,fix:adres;
begin
  for i:=1 to k do begin
  max:=-1000;
  rab:=head;
  for j:=1 to k-i+1 do begin
  if rab^.a>max then begin
  maxn:=rab;
  max:=rab^.a;
  end;
  if rab^.next<>nil then begin fix:=rab;
  rab:=rab^.next; end;
end;
writeln(max,' ',rab^.a,' ',maxn^.a);
res:=rab^.a;
rab^.a:=max;
maxn^.a:=res;
writeln;
writeln(max,' ',rab^.a,' ',maxn^.a);
rab1:=head;
  writeln;
  for l:=1 to k do begin
  writeln(l,'  ',rab1^.a) ;
  rab1:=rab1^.next;
  end;
end;
end;
procedure listvstavka(k:smallint; var head:adres);
var i,j:smallint;
res:longint;
rab,fix:adres;
begin
  rab:=head;
  rab:=rab^.next;
  for i:=2 to k do begin
  res:=rab^.a;
  fix:=rab;
  while rab^.last^.a>res do begin
  rab^.a:=rab^.last^.a;
  rab:=rab^.last;
  end;
  rab^.a:=res;
  rab:=fix^.next;
  end;
end;
var rab,head,lasts:adres;
uz:list;
i,k:smallint;
start,finish,res:int64;
begin
  k:=50;
  new(rab);
  head:=rab;
  rab^.a:=random(100);
  rab^.next:=nil;
  rab^.last:=nil;
  lasts:=head;
  for i:=1 to k-1 do begin
  new(rab);
  rab^.a:=random(100);
  rab^.next:=nil;
  lasts^.next:=rab;
  rab^.last:=lasts;
  lasts:=rab;
  end;
  rab:=head;
  for i:=1 to k do begin
  writeln(i,'  ',rab^.a);
  rab:=rab^.next;
  end;
  QueryPerformanceFrequency(res);
  QueryPerformanceCounter(start);
  listvibor(k,head);
  QueryPerformanceCounter(finish);
  rab:=head;
  writeln;
  for i:=1 to k do begin
  writeln(i,'  ',rab^.a) ;
  rab:=rab^.next;
  end;

  writeln(((finish-start)/res):10:5);
  readln;

end.

