unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,math,windows;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;
  iter:int64;
  xn,xm,ymin,ymax,toch:double;
  h,w:longint;
  fl:byte;

implementation
uses unit1,Unit3;

{$R *.lfm}

{ TForm2 }
function f(x:double; i:byte):double;
begin
if unit1.form1.RadioGroup1.ItemIndex=0 then
begin
  if i=0 then begin
    if x<=-1 then begin x:=-1+1e-9; end;                 //ОДЗ для функции арксинуса
    if x>=1 then begin x:=1-1e-9; end;
    result:=arcsin(x)-0.25; end;
  if i=1 then begin
    if x<=-1 then begin x:=-1+1e-9; end;                 //ОДЗ для первой производной функции арксинуса
    if x>=1 then begin x:=1-1e-9; end;
  result:=power((1-x*x),-1/2); end;
  if i=2 then begin
  if x<=-1 then begin x:=-1+1e-9; end;                    //ОДЗ для второй производной функции арксинуса
    if x>=1 then begin x:=1-1e-9; end;                    //Все изменения значения аргумента учитывают стремление значения справа или слева
  result:=power((1-x*x),-3/2); end;
end;
if unit1.form1.RadioGroup1.ItemIndex=1 then
begin
  if i=0 then begin result:=cos(x)-0.9; end;
  if i=1 then begin result:=-sin(x); end;
  if i=2 then begin result:=-cos(x); end;
end;
if unit1.form1.RadioGroup1.ItemIndex=2 then
begin
  if i=0 then begin result:=-3*x*x*x*x+56*x*x-4*x-31; end;
  if i=1 then begin result:=-12*x*x*x+112*x-4; end;
  if i=2 then begin result:=-36*x*x+112; end;
end;
if unit1.form1.RadioGroup1.ItemIndex=3 then
begin

  if i=0 then begin
  if x<=0 then begin x:=1e-9 end;                                 //Трансцендентная функция на извлечение корня кубического
  result:=ln(x)-2; end;                                           //отдельно для 0, для отрицательных и положительных значений аргумента
  if i=1 then begin
  if x=0 then begin x:=1e-9 end;
  result:=1/x; end;
  if i=2 then begin
  if x=0 then begin x:=1e-9 end;
  result:=-1/(x*x); end;
end;
if unit1.form1.RadioGroup1.ItemIndex=4 then
begin
  if i=0 then begin
  if x>0 then begin
  result:=power(x,1/3)-1;
  end;
  if x<0 then begin
  result:=-power(abs(x),1/3)-1;
  end;
  if x=0 then begin
  result:=-1;
  end;
  end;
  if i=1 then begin
  if x>0 then begin
  result:=(1/3)*power((x),-2/3);
  end;
  if x<0 then begin
  result:=-(1/3)*power(abs(x),-2/3);
  end;
  if x=0 then begin
  result:=0;
  end;
   end;
  if i=2 then begin
  if x>0 then begin
  result:=(-2/9)*power((x),-5/3);
  end;
  if x<0 then begin
  result:=-(-2/9)*power(abs(x),-5/3);
  end;
  if x=0 then begin
  result:=0;
  end;
   end;
end;
end;

function solve(a,b:double):double;
var x1,x0,r,c,z,l:double;
  k:tcolor;
  flag,maxiter,start,finish,res:int64;
  begin
  unit3.Form3.ListBox1.Clear;                                                                                 //отчищаем заполняемые поля
  unit3.Form3.ListBox2.Clear;
  unit3.Form3.ListBox3.Clear;
  unit3.Form3.ListBox4.Clear;
  unit2.form2.Edit3.Text:='';
  unit2.form2.Edit4.Text:='';
  unit2.form2.Edit7.Text:='';
  r:=1000;
  iter:=0;
  fl:=0;                                                                                                       //инициализируем переменные
  k:=clblue;
  maxiter:=strtoint(unit2.form2.Edit6.Text);
  flag:=0;
  if f(a,0)*f(a,2)>0 then begin x0:=a;c:=b; end;                                                               //проверяем сходимость
  if f(b,0)*f(b,2)>0 then begin x0:=b;c:=a; end;
  QueryPerformanceFrequency(res);
  QueryPerformanceCounter(start);
  while r>toch do
  begin
  unit3.Form3.ListBox1.Items.Add((floattostr(trunc(x0/toch)*toch)));                                            //заполняем таблицу
  unit3.Form3.ListBox2.items.Add((floattostr(trunc(c/toch)*toch)));
  unit3.Form3.ListBox3.Items.Add((floattostr(trunc(f(x0,0)/toch)*toch)));
  unit3.Form3.ListBox4.items.Add((floattostr(trunc(f(c,0)/toch)*toch)));
  if flag=0 then begin k:=clblue; end;
  if flag=1 then begin k:=claqua; end;                                                                          //меняем цвет хорды и касательной
  if flag=2 then begin k:=cllime; end;
  if flag=3 then begin k:=clblack; end;
  if flag=4 then begin k:=clgreen; end;
  l:=f(x0,1);
  if ((l<1e-9) and (l>0))  then begin l:=l+1e-9; end;                                                           //обрабатывыем исключения вертикальной хорды или касательной
  if ((l>-1e-9) and (l<0))  then begin l:=l-1e-9; end;
  if (l=0) then begin showmessage('Change another interval'); fl:=1; break; end;
  x1:=x0-f(x0,0)/l;
  l:= f(x0,0)-f(c,0);
  if ((l<1e-9) and (l>0))  then begin l:=l+1e-9; end;
  if ((l>-1e-9) and (l<0))  then begin l:=l-1e-9; end;
  if (l=0) then begin showmessage('Change another interval'); fl:=1; break; end;
  z:=c-(f(c,0)*(x0-c))/l;                                                                                       //вычисляем новый интервал
  iter:=iter+1;
  if iter>maxiter then begin showmessage('Exceed maxiteration, change another interval'); fl:=1; break; end;    //проверка на превышение максимального количества итераторов
  unit2.form2.Image1.Canvas.Pen.Color:=k;
  unit2.form2.Image1.Canvas.Pen.Width:=2;
  unit2.form2.Image1.Canvas.MoveTo(round((x0-xn)*((w)/(xm-xn))),round((ymax-f(x0,0))*((h)/(ymax-ymin))));       //чертим хорду и касательную
  unit2.form2.Image1.Canvas.LineTo(round((x1-xn)*((w)/(xm-xn))),round((ymax)*((h)/(ymax-ymin))));
  unit2.form2.Image1.Canvas.MoveTo(round((x0-xn)*((w)/(xm-xn))),round((ymax-f(x0,0))*((h)/(ymax-ymin))));
  unit2.form2.Image1.Canvas.LineTo(round((z-xn)*((w)/(xm-xn))),round((ymax)*((h)/(ymax-ymin))));
  r:=abs(x1-z);
  x0:=x1;                                                                                                        //присваиваем новые значения интервала
  c:=z;
  flag:=flag+1;
  if flag=5 then begin flag:=0; end;
  if unit2.form2.CheckBox1.Checked=true then
  begin
  showmessage((floattostr(trunc(x0/toch)*toch))+'   '+(floattostr(trunc(c/toch)*toch)));
  end;
  end;
  QueryPerformanceCounter(finish);
  if (fl<>1) and (unit2.form2.CheckBox1.Checked=false) then begin
  unit2.form2.Edit7.Text:=floattostr((finish - start) / res); end;
  result:=x1;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TForm2.Button2Click(Sender: TObject);
var a,b:double;
  i,j,k:smallint;
  sh,dx,res:double;
  mdoub:array[1..3] of array[1..5000] of double;
  mint:array[1..3] of array[1..5000] of smallint;
  gor,lx,flag,ind:smallint;
begin
  xn:=strtofloat(unit2.form2.Edit1.text);
  xm:=strtofloat(unit2.form2.Edit2.text);
  k:=700;
  sh:=(xm-xn)/(k-1);
  mdoub[1][1]:=xn;
  mdoub[2][1]:=f(mdoub[1][1],0);
  mdoub[3][1]:=0;
  for i:=1 to k+1 do
  begin
    mdoub[1][i+1]:=mdoub[1][i]+sh;
    mdoub[2][i]:=f(mdoub[1][i],0);
    mdoub[3][i]:=0;
  end;
  ymax:=-10e-7;
  ymin:=10e+7;
  for i:=1 to k do
  begin
  if mdoub[2][i]>ymax then begin ymax:=mdoub[2][i] end;
  if mdoub[2][i]<ymin then begin ymin:=mdoub[2][i] end;
  end;
  w:=700;
  h:=500;
  unit2.form2.Image1.Canvas.Pen.Width:=1;
  unit2.form2.Image1.Canvas.Pen.Color:=clblack;
  unit2.form2.image1.Canvas.Rectangle(-10,-10,w+10,h+10);
  for i:=1 to w do
  begin
  mint[1][i]:=round((mdoub[1][i]-xn)*((w)/(xm-xn)));
  mint[2][i]:=round((ymax-mdoub[2][i])*((h)/(ymax-ymin)));
  mint[3][i]:=round((ymax-mdoub[3][i])*((h)/(ymax-ymin)));
  end;
  unit2.form2.Image1.Canvas.Pen.Color:=clblack;
  unit2.form2.Image1.Canvas.Pen.Width:=2;
  unit2.form2.Image1.Canvas.MoveTo(mint[1][1],mint[3][1]);
  for i:=2 to w do
  begin
  unit2.form2.Image1.Canvas.LineTo(mint[1][i],mint[3][i]);
  end;
  unit2.form2.Image1.Canvas.Pen.Color:=clred;
  unit2.form2.Image1.Canvas.Pen.Width:=2;
  unit2.form2.Image1.Canvas.MoveTo(mint[1][1],mint[2][1]);
  for i:=2 to w do
  begin
  unit2.form2.Image1.Canvas.LineTo(mint[1][i],mint[2][i]);
  end;
  toch:=strtofloat(unit2.Form2.Edit5.Text);
  res:=solve(strtofloat(unit2.Form2.Edit1.Text),strtofloat(unit2.Form2.Edit2.Text));
  if fl<>1 then begin
  unit2.Form2.Edit3.Text:=floattostr(res);
  unit2.Form2.Edit4.Text:=inttostr(iter);
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  unit3.form3.ShowModal;
end;

end.

