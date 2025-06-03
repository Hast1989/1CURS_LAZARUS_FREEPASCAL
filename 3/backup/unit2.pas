unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type m=array[1..10] of longint;
  adres=^list;
  list=record
    a:smallint;
    next:adres;
  end;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
private

  public

  end;

var
  Form2: TForm2;
  var mass:m;
    head:adres;

implementation

{$R *.lfm}

{ TForm2 }
procedure massviborup(var mass:m);
var i,j:smallint;
res:longint;
begin
  for i:=1 to 10 do begin
  for j:=1 to 10-i do begin
  if mass[j]>mass[j+1] then begin
    res:=mass[j];
    mass[j]:=mass[j+1];
    mass[j+1]:=res;
  end;
end;
end;
end;


procedure massobmenup(var mass:m);
var i,j,maxn:smallint;
res,max:longint;
begin

  for i:=1 to 10 do begin
  max:=-1000000;
  for j:=1 to 11-i do begin
  if mass[j]>max then begin maxn:=j;max:=mass[j]; end;
end;
res:=mass[j]; mass[j]:=max; mass[maxn]:=res;
end;
end;


procedure massvstavkaup(var mass:m);
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


procedure listviborup(head:adres);
var i,j:smallint;
res:longint;
rab:adres;
begin
  for i:=1 to 10 do begin
  rab:=head;
  for j:=1 to 10-i do begin
  if rab^.a>rab^.next^.a then begin
    res:=rab^.a;
    rab^.a:=rab^.next^.a;
    rab^.next^.a:=res;  end;
  rab:=rab^.next;
end;
end;
end;
procedure massvibordown(var mass:m);
var i,j:smallint;
res:longint;
begin
  for i:=1 to 10 do begin
  for j:=1 to 11-i do begin
  if mass[j]<mass[j+1] then begin res:=mass[j]; mass[j]:=mass[j+1]; mass[j+1]:=res;  end;
end;
end;
end;


procedure massobmendown(var mass:m);
var i,j,maxn:smallint;
res,min:longint;
begin

  for i:=1 to 10 do begin
  min:=1000000;
  for j:=1 to 11-i do begin
  if mass[j]<min then begin maxn:=j;min:=mass[j]; end;
end;
res:=mass[j]; mass[j]:=min; mass[maxn]:=res;
end;
end;


procedure massvstavkadown(var mass:m);
var i,j:smallint;
res:longint;
begin
  for i:=2 to 10 do begin
  res:=mass[i];
  j:=i;
  while mass[j-1]<res do begin mass[j]:=mass[j-1]; j:=j-1; end;
  mass[j]:=res;
  end;
end;


procedure listvibordown(head:adres);
var i,j:smallint;
res:longint;
rab:adres;
begin
  for i:=1 to 10 do begin
  rab:=head;
  for j:=1 to 10-i do begin
  if rab^.a<rab^.next^.a then begin
    res:=rab^.a;
    rab^.a:=rab^.next^.a;
    rab^.next^.a:=res;  end;
  rab:=rab^.next;
end;
end;
end;
procedure copymasstolist();
var lasts,rab:adres;
  i:smallint;
begin
  new(rab);
  head:=rab;
  rab^.a:=mass[1];
  rab^.next:=nil;
  lasts:=head;
  for i:=2 to 10 do begin
  new(rab);
  rab^.a:=mass[i];
  rab^.next:=nil;
  lasts^.next:=rab;
  lasts:=rab;
  end;
  end;

procedure TForm2.Button7Click(Sender: TObject);
var rab,del:adres;
begin
  memo1.clear;
  memo2.clear;
  memo3.clear;
  close;
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
  if radiogroup1.itemindex=0 then begin massobmenup(mass); end else
  begin massobmendown(mass); end;
  showmessage('Sort is complete');
end;

procedure TForm2.Button9Click(Sender: TObject);
begin
  if radiogroup1.itemindex=0 then begin massviborup(mass); end else
    begin massvibordown(mass); end;
    showmessage('Sort is complete');
end;

procedure TForm2.Button1Click(Sender: TObject);
var i:byte;
begin
  for i:=1 to 10 do begin
    mass[i]:=strtoint(memo1.lines[i-1]);
  end;
  showmessage('Enter is complete');
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  copymasstolist();
  showmessage('Copy is complete');
end;

procedure TForm2.Button3Click(Sender: TObject);
var i:byte;
begin
  memo2.clear;
  for i:=1 to 10 do begin
      memo2.lines[i-1]:=inttostr(mass[i]);
  end;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  if radiogroup1.itemindex=0 then begin massviborup(mass); end else
  begin massvibordown(mass); end;
  showmessage('Sort is complete');
end;

procedure TForm2.Button5Click(Sender: TObject);
var rab:adres;
  k,i:smallint;
begin
  memo3.clear;
  k:=10;
  rab:=head;
  for i:=0 to k-1 do begin
  memo3.lines[i]:=inttostr(rab^.a);
  rab:=rab^.next;
  end;
  end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  if radiogroup1.itemindex=0 then begin listviborup(head); end else
  begin listvibordown(head); end;
  showmessage('Sort is complete');
end;

end.

