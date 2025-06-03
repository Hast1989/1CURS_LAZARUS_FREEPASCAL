unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,dos,windows;

type
  nam = (TUPOLEVR,ILUSHINRU,ANTONOV,PETLYAKRU,MIGOYAN,EMBRAERU,BOMBARD,AIRBUSFRA,BOINGUSA);
  wings=(LOWPLAN,UPPLANER);
  zap=record
    name:nam;
    index:smallint;
    date:1900..2022;
    wing:wings;
    cost:single;
end;
  adres=^list;
  list=record
    rec:zap;
    next:adres;
  end;
  mas=array[1..5000] of zap;

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    ListBox3: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Label2Click(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;

implementation
uses Unit4;
var mass1,mass2,mass3,massres:mas;
  n:smallint;
  getmsec,nowmsec:int64;
  querysec:extended;
  head:adres;
  pris,sravn:int64;


{$R *.lfm}

{ TForm3 }
Function GetTime: int64;
Var h, m, s, ms: Word;
begin
  Dos.GetTime(h, m, s, ms);
  result := ms + 1000 * (s + 60 * (m + 60 * h));
end;
procedure massviborup(var mass:mas);

var i,j,maxn:smallint;
res,max:zap;
begin
  pris:=0;
  sravn:=0;
  for i:=1 to n do begin
  max.date:=1900;
  for j:=1 to n+1-i do begin
  if mass[j].date>max.date then begin maxn:=j;max:=mass[j]; pris:=pris+1; end;
  sravn:=sravn+1;
end;
res:=mass[j]; mass[j]:=max; mass[maxn]:=res;
end;

end;
procedure massobmenup(var mass:mas);
var i,j:smallint;
res:zap;
begin
 pris:=0;
  sravn:=0;
  for i:=1 to n do begin
  for j:=1 to n-i do begin
  sravn:=sravn+1;
  if mass[j].date>mass[j+1].date then begin
    res:=mass[j];
    mass[j]:=mass[j+1];
    mass[j+1]:=res;
    pris:=pris+1;
  end;
 end;
end;
end;
procedure massvstavkaup(var mass:mas);
var i,j:smallint;
res:zap;
begin
  pris:=0;
  sravn:=0;
  for i:=2 to n do begin
  res:=mass[i];
  j:=i;
  pris:=pris+1;
  sravn:=sravn+1;
  while mass[j-1].date>res.date do begin mass[j]:=mass[j-1]; j:=j-1; sravn:=sravn+1; pris:=pris+1;   end;
  mass[j]:=res;
  end;
end;
procedure massobmendown(var mass:mas);
var i,j:smallint;
res:zap;
begin
 pris:=0;
  sravn:=0;
  for i:=1 to n do begin
  for j:=1 to n-i do begin

  if mass[j].date<mass[j+1].date then begin
    res:=mass[j];
    mass[j]:=mass[j+1];
    mass[j+1]:=res;

  end;
 end;
end;
end;

procedure copymasstolist();
var lasts,rab:adres;
  i:smallint;
begin
  new(rab);
  head:=rab;
  rab^.rec:=mass1[1];
  rab^.next:=nil;
  lasts:=head;
  for i:=2 to n do begin
  new(rab);
  rab^.rec:=mass1[i];
  rab^.next:=nil;
  lasts^.next:=rab;
  lasts:=rab;
  end;
  end;
procedure listobmenup(head:adres);
var i,j:smallint;
res:zap;
rab:adres;
begin
  pris:=0;
  sravn:=0;
  for i:=1 to n do begin
  rab:=head;
  for j:=1 to n-i do begin
  sravn:=sravn+1;
  if rab^.rec.date>rab^.next^.rec.date then begin
    res:=rab^.rec;
    rab^.rec:=rab^.next^.rec;
    rab^.next^.rec:=res; pris:=pris+1;  end;
  rab:=rab^.next;
end;
end;
end;
procedure TForm3.Button1Click(Sender: TObject);
begin
  close;
end;
procedure TForm3.Button2Click(Sender: TObject);
var i:smallint;
  mem,s:string;
begin
  randomize;
   n:=random(1001);
  n:=n+4000;
  //n:=5;
  s:='';
  edit1.text:=inttostr(n);
  for i:=1 to n do begin
    mem:='';
    mass1[i].name:=nam(random(9));
    str(mass1[i].name,s);
    mem:=mem+s;
    s:='';
    mem:=mem+'-';
    mass1[i].index:=random(90)+10;
    mem:=mem+inttostr(mass1[i].index);
    mem:=mem+'   ';
    mass1[i].date:=1900+random(123);
    mem:=mem+inttostr(mass1[i].date);
    mem:=mem+'   ';
    mass1[i].wing:=wings(random(2));
    str(mass1[i].wing,s);
    mem:=mem+s;
    s:='';
    mem:=mem+'   ';
    mass1[i].cost:=(random(200000)+20000)/(random(200)+200);
    mem:=mem+FloatToStrF(mass1[i].cost, ffCurrency, 8, 2);
    listbox1.items[i-1]:=mem;
  end;
  end;

procedure TForm3.Button3Click(Sender: TObject);
var i:smallint;
  mem,s:string;
begin
  for i:=1 to n do begin
    mass2[i]:=mass1[i];
    mass3[i]:=mass1[i];
  end;
  massvstavkaup(mass2);
  massobmendown(mass3);
  for i:=1 to n do begin
    mem:='';
    str(mass2[i].name,s);
    mem:=mem+s;
    s:='';
    mem:=mem+'-';
    mem:=mem+inttostr(mass2[i].index);
    mem:=mem+'   ';
    mem:=mem+inttostr(mass2[i].date);
    mem:=mem+'   ';
    str(mass2[i].wing,s);
    mem:=mem+s;
    s:='';
    mem:=mem+'   ';
    mem:=mem+FloatToStrF(mass2[i].cost, ffCurrency, 8, 2);
    listbox2.items[i-1]:=mem;
  end;
  for i:=1 to n do begin
    mem:='';
    str(mass3[i].name,s);
    mem:=mem+s;
    s:='';
    mem:=mem+'-';
    mem:=mem+inttostr(mass3[i].index);
    mem:=mem+'   ';
    mem:=mem+inttostr(mass3[i].date);
    mem:=mem+'   ';
    str(mass3[i].wing,s);
    mem:=mem+s;
    s:='';
    mem:=mem+'   ';
    mem:=mem+FloatToStrF(mass3[i].cost, ffCurrency, 8, 2);
    listbox3.items[i-1]:=mem;
  end;
end;

procedure TForm3.Button4Click(Sender: TObject);
var i,j:smallint;
  start,finish,res:int64;
  sta,sto:TdateTime;
begin
  QueryPerformanceFrequency(res);
  getmsec:=0;
  nowmsec:=0;
  querysec:=0;
  copymasstolist();
  for i:=1 to n do begin
    massres[i]:=mass1[i];
  end;
  getmsec:=gettime;
  QueryPerformanceCounter(start);
  massviborup(mass1);
  QueryPerformanceCounter(finish);
  getmsec:=trunc(((gettime-getmsec)*999900)/100000);
  nowmsec:=trunc((((finish - start) / res))*1105);
  querysec:=(finish - start) / res;
  form4.Edit1.text:=floattostr(getmsec);
  form4.Edit2.text:=floattostr(nowmsec);
  form4.Edit3.text:=floattostr(querysec);
  form4.Edit4.text:=inttostr(pris);
  form4.Edit5.text:=inttostr(sravn);

  getmsec:=gettime;
  QueryPerformanceCounter(start);
  for i:=1 to n do begin
    mass1[i]:=massres[i];
  end;
  massobmenup(mass1);
  QueryPerformanceCounter(finish);
  getmsec:=trunc(((gettime-getmsec)*999900)/100000);
  nowmsec:=trunc((((finish - start) / res))*1105);
  querysec:=(finish - start) / res;
  form4.Edit6.text:=floattostr(getmsec);
  form4.Edit7.text:=floattostr(nowmsec);
  form4.Edit8.text:=floattostr(querysec);
  form4.Edit9.text:=inttostr(pris);
  form4.Edit10.text:=inttostr(sravn);

  getmsec:=gettime;
  QueryPerformanceCounter(start);
  for i:=1 to n do begin
    mass1[i]:=massres[i];
  end;
  massvstavkaup(mass1);
  QueryPerformanceCounter(finish);
  getmsec:=trunc(((gettime-getmsec)*999900)/100000);
  querysec:=(finish - start) / res;
  nowmsec:=trunc((((finish - start) / res))*1105);
  form4.Edit11.text:=floattostr(getmsec);
  form4.Edit12.text:=floattostr(nowmsec);
  form4.Edit13.text:=floattostr(querysec);
  form4.Edit14.text:=inttostr(pris);
  form4.Edit15.text:=inttostr(sravn);

  for i:=1 to n do begin
    massres[i]:=mass2[i];
  end;
  getmsec:=gettime;
  QueryPerformanceCounter(start);
  massviborup(mass2);
  QueryPerformanceCounter(finish);
  getmsec:=trunc(((gettime-getmsec)*999900)/100000);
  querysec:=(finish - start) / res;
  nowmsec:=trunc((((finish - start) / res))*1105);
  form4.Edit16.text:=floattostr(getmsec);
  form4.Edit17.text:=floattostr(nowmsec);
  form4.Edit18.text:=floattostr(querysec);
  form4.Edit19.text:=inttostr(pris);
  form4.Edit20.text:=inttostr(sravn);
  getmsec:=gettime;
  QueryPerformanceCounter(start);
  for i:=1 to n do begin
    mass2[i]:=massres[i];
  end;
  massobmenup(mass2);
  QueryPerformanceCounter(finish);
  getmsec:=trunc(((gettime-getmsec)*999900)/100000);
  querysec:=(finish - start) / res;
  nowmsec:=trunc((((finish - start) / res))*1105);
  form4.Edit21.text:=floattostr(getmsec);
  form4.Edit22.text:=floattostr(nowmsec);
  form4.Edit23.text:=floattostr(querysec);
  form4.Edit24.text:=inttostr(pris);
  form4.Edit25.text:=inttostr(sravn);
  getmsec:=gettime;
  QueryPerformanceCounter(start);
  for i:=1 to n do begin
    mass2[i]:=massres[i];
  end;
  massvstavkaup(mass2);
  QueryPerformanceCounter(finish);
  getmsec:=trunc(((gettime-getmsec)*999900)/100000);
  querysec:=(finish - start) / res;
  nowmsec:=trunc((((finish - start) / res))*1105);
  form4.Edit26.text:=floattostr(getmsec);
  form4.Edit27.text:=floattostr(nowmsec);
  form4.Edit28.text:=floattostr(querysec);
  form4.Edit29.text:=inttostr(pris);
  form4.Edit30.text:=inttostr(sravn);
  for i:=1 to n do begin
    massres[i]:=mass3[i];
  end;
  getmsec:=gettime;
  QueryPerformanceCounter(start);
  massviborup(mass3);
  QueryPerformanceCounter(finish);
  getmsec:=trunc(((gettime-getmsec)*999900)/100000);
  querysec:=(finish - start) / res;
  nowmsec:=trunc((((finish - start) / res))*1105);
  form4.Edit31.text:=floattostr(getmsec);
  form4.Edit32.text:=floattostr(nowmsec);
  form4.Edit33.text:=floattostr(querysec);
  form4.Edit34.text:=inttostr(pris);
  form4.Edit35.text:=inttostr(sravn);
  for i:=1 to n do begin
    mass3[i]:=massres[i];
  end;
  getmsec:=gettime;
  QueryPerformanceCounter(start);
  massobmenup(mass3);
  QueryPerformanceCounter(finish);
  getmsec:=trunc(((gettime-getmsec)*999900)/100000);
  querysec:=(finish - start) / res;
  nowmsec:=trunc((((finish - start) / res))*1105);
  form4.Edit36.text:=floattostr(getmsec);
  form4.Edit37.text:=floattostr(nowmsec);
  form4.Edit38.text:=floattostr(querysec);
  form4.Edit39.text:=inttostr(pris);
  form4.Edit40.text:=inttostr(sravn);
  for i:=1 to n do begin
    mass3[i]:=massres[i];
  end;
  getmsec:=gettime;
  QueryPerformanceCounter(start);
  massvstavkaup(mass3);
  QueryPerformanceCounter(finish);
  getmsec:=trunc(((gettime-getmsec)*999900)/100000);
  nowmsec:=trunc((((finish - start) / res))*1105);
  querysec:=(finish - start) / res;
  form4.Edit41.text:=floattostr(getmsec);
  form4.Edit42.text:=floattostr(nowmsec);
  form4.Edit43.text:=floattostr(querysec);
  form4.Edit44.text:=inttostr(pris);
  form4.Edit45.text:=inttostr(sravn);
  getmsec:=gettime;
  QueryPerformanceCounter(start);
  listobmenup(head);
  QueryPerformanceCounter(finish);
  getmsec:=trunc(((gettime-getmsec)*999900)/100000);
  querysec:=(finish - start) / res;
  nowmsec:=trunc((((finish - start) / res))*1105);
  form4.Edit46.text:=floattostr(getmsec);
  form4.Edit47.text:=floattostr(nowmsec);
  form4.Edit48.text:=floattostr(querysec);
  form4.Edit49.text:=inttostr(pris);
  form4.Edit50.text:=inttostr(sravn);
  unit4.Form4.showmodal;
end;

procedure TForm3.Button5Click(Sender: TObject);
begin
  Unit4.form4.showmodal;
end;

procedure TForm3.Label2Click(Sender: TObject);
begin

end;



end.

