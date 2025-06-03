unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RadioGroup1: TRadioGroup;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;


implementation
uses Unit2;

{$R *.lfm}


{ TForm1 }
function f(x:double; i:byte):double;
begin
if unit1.form1.RadioGroup1.ItemIndex=0 then
begin
  if i=0 then begin
    if x<=-1 then begin x:=-1+1e-9; end;
    if x>=1 then begin x:=1-1e-9; end;
    result:=arcsin(x)-0.25; end;
  if i=1 then begin
    if x<=-1 then begin x:=-1+1e-9; end;
    if x>=1 then begin x:=1-1e-9; end;
  result:=power((1-x*x),-1/2); end;
  if i=2 then begin
  if x<=-1 then begin x:=-1+1e-9; end;
    if x>=1 then begin x:=1-1e-9; end;
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
  if x<=0 then begin x:=1e-9 end;
  result:=ln(x)-2; end;
  if i=1 then begin result:=1/x; end;
  if i=2 then begin result:=-1/(x*x); end;
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
  if i=1 then begin result:=(1/3)*power((x),-2/3); end;
  if i=2 then begin result:=(-2/9)*power((x),-5/3); end;
end;
end;

function solve(a,b,toch:double; i:byte):double;
var x1,x0,r,c,z:double;
  begin
  while r>toch do
  begin
  if f(a,0)*f(a,2)>0 then begin x0:=a;c:=b; end;
  if f(b,0)*f(b,2)>0 then begin x0:=b;c:=a; end;
  x1:=x0-f(x0,0)/f(x0,1);
  z:=c-(f(c,0)*(x0-c))/(f(x0,0)-f(c,0));
  r:=abs(x1-z);
  end;
  result:=x1;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  unit2.form2.Image1.Canvas.Pen.Width:=1;
  unit2.form2.Image1.Canvas.Pen.Color:=clblack;
  unit2.form2.image1.Canvas.Rectangle(-10,-10,700+10,500+10);
  Unit2.Form2.Edit1.text:=unit1.Form1.Edit1.text;
  Unit2.Form2.Edit2.text:=unit1.Form1.Edit2.text;
  Unit2.Form2.Edit5.text:=unit1.Form1.Edit3.text;
  Unit2.Form2.ShowModal;
end;

procedure TForm1.Button3Click(Sender: TObject);
var i,j,k:smallint;
  sh,dx,xn,xm,ymin,ymax:double;
  mdoub:array[1..3] of array[1..5000] of double;
  mint:array[1..3] of array[1..5000] of smallint;
  h,w,gor,lx,flag,ind:smallint;
begin
  xn:=strtofloat(unit1.form1.Edit1.text);
  xm:=strtofloat(unit1.form1.Edit2.text);
  k:=1000;
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
  if mdoub[3][i]>ymax then begin ymax:=mdoub[3][i] end;
  if mdoub[2][i]<ymin then begin ymin:=mdoub[2][i] end;
  if mdoub[3][i]<ymin then begin ymin:=mdoub[3][i] end;
  end;

  w:=1000;
  h:=600;
  gor:=strtoint(unit1.Form1.Edit4.text);
  unit1.form1.Image1.Canvas.Pen.Width:=1;
  unit1.form1.Image1.Canvas.Pen.Color:=clblack;
  unit1.form1.image1.Canvas.Rectangle(-10,-10,w+10,h+10);
  unit1.form1.image1.Canvas.Rectangle(0,20,w,h);
  lx:=round((w)/(gor));
  dx:=(xm-xn)/(gor);
  unit1.form1.Image1.Canvas.Pen.Width:=1;
  unit1.form1.Image1.Canvas.Pen.Color:=clsilver;
  for i:=0 to gor do
  begin
  unit1.form1.image1.canvas.textout(i*lx,5,floattostr((round((xn+i*dx)*1000)/1000)));
  unit1.form1.Image1.Canvas.MoveTo((i*lx),20);
  unit1.form1.Image1.Canvas.LineTo((i*lx),h);
  end;
  flag:=1;
  for i:=1 to w do
  begin
  mint[1][i]:=round((mdoub[1][i]-xn)*((w)/(xm-xn)));
  mint[2][i]:=round((ymax-mdoub[2][i])*((h-20)/(ymax-ymin)))+20;
  mint[3][i]:=round((ymax-mdoub[3][i])*((h-20)/(ymax-ymin)))+20;
  if abs(ind-i)>20 then begin flag:=1; end;
  if (abs(mint[2][i]-mint[3][i])<=1)and (flag=1)  then
  begin
  ind:=i;
  unit1.form1.Image1.Canvas.Pen.Width:=2;
  unit1.form1.Image1.Canvas.Pen.Color:=clblue;
  unit1.form1.Image1.Canvas.Ellipse(mint[1][i]-10,mint[3][i]-10,mint[1][i]+10,mint[3][i]+10);
  flag:=0;
  end;
  end;
  unit1.form1.Image1.Canvas.Pen.Color:=clblack;
  unit1.form1.Image1.Canvas.Pen.Width:=2;
  unit1.form1.Image1.Canvas.MoveTo(mint[1][1],mint[3][1]);
  for i:=2 to w do
  begin
  unit1.form1.Image1.Canvas.LineTo(mint[1][i],mint[3][i]);
  end;
  unit1.form1.Image1.Canvas.Pen.Color:=clred;
  unit1.form1.Image1.Canvas.Pen.Width:=2;
  unit1.form1.Image1.Canvas.MoveTo(mint[1][1],mint[2][1]);
  for i:=2 to w do
  begin
  unit1.form1.Image1.Canvas.LineTo(mint[1][i],mint[2][i]);
  end;
  unit1.form1.Image1.Canvas.Pen.Width:=2;
  unit1.form1.Image1.Canvas.Pen.Color:=clblack;
  unit1.form1.Image1.Canvas.MoveTo(0,20);
  unit1.form1.Image1.Canvas.LineTo(w,20);
  unit1.form1.Image1.Canvas.MoveTo(0,h);
  unit1.form1.Image1.Canvas.LineTo(w,h);

end;


end.

