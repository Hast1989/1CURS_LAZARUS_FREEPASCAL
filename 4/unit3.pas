unit Unit3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm3 }

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Image1: TImage;
    ScrollBar1: TScrollBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
  private

  public

  end;

var
  Form3: TForm3;
  mdoub:array[1..3] of array[1..5000] of double;
  mint:array[1..3] of array[1..5000] of smallint;
  xn,xm,ymax,ymin,dx,dy,rast,xnres:double;
  gor,vert,lx,ly:smallint;


implementation
uses unit1,unit2;

{$R *.lfm}
function func(x:double;j:smallint):double;
begin
  if j=0 then begin result:=x-5; end;
  if j=1 then begin  result:=x*x+5*x; end;
  if j=2 then begin result:=exp(x); end;
  if j=3 then begin result:=sin(x); end;
  if j=4 then begin result:=cos(x); end;
end;
procedure func();
var i,j1,j2,j,k:smallint;
  h:double;
  f:textfile;
  s:string;
begin
  assignfile(f,'text1.txt');
  rewrite(f);
  xn:=strtofloat(unit2.form2.Edit1.text);
  xm:=strtofloat(unit2.form2.Edit2.text);
  k:=strtoint(unit2.form2.Edit7.text);
  j1:=0;
  while unit2.Form2.checkgroup1.checked[j1]<>true do
  begin
  j1:=j1+1;
  end;
  j2:=j1+1;
  while unit2.Form2.checkgroup1.checked[j2]<>true do
  begin
  j2:=j2+1;
  end;
  h:=(xm-xn)/(k-1);
  mdoub[1][1]:=xn;
  mdoub[2][1]:=func(mdoub[1][1],j1);
  mdoub[3][1]:=func(mdoub[1][1],j2);
  s:=floattostr(mdoub[1][1])+'  '+floattostr(mdoub[2][1])+'  '+floattostr(mdoub[3][1]);
  writeln(f,s);
  for i:=1 to k do
  begin
    mdoub[1][i+1]:=mdoub[1][i]+h;
    mdoub[2][i]:=func(mdoub[1][i],j1);
    mdoub[3][i]:=func(mdoub[1][i],j2);
    s:=floattostr(mdoub[1][i])+'  '+floattostr(mdoub[2][i])+'  '+floattostr(mdoub[3][i]);
    writeln(f,s);
  end;
  closefile(f);
  ymax:=-10e-7;
  ymin:=10e+7;
  for i:=1 to k do
  begin
  if mdoub[2][i]>ymax then begin ymax:=mdoub[2][i] end;
  if mdoub[3][i]>ymax then begin ymax:=mdoub[3][i] end;
  if mdoub[2][i]<ymin then begin ymin:=mdoub[2][i] end;
  if mdoub[3][i]<ymin then begin ymin:=mdoub[3][i] end;
  end;
end;
procedure funcpostr1();
var i,w,h:smallint;
begin
  w:=strtoint(unit2.form2.Edit7.Text);
  h:=strtoint(unit2.form2.Edit8.Text);
  unit3.form3.Image1.Width:=w;
  unit3.form3.Image1.Height:=h;
  gor:=strtoint(unit2.form2.edit3.text);
  vert:=strtoint(unit2.Form2.Edit4.text);
  unit3.form3.Width:=w;
  unit3.form3.Height:=h+70;
  unit3.form3.image1.Canvas.Rectangle(0,0,w,h);
  unit3.form3.image1.Canvas.Rectangle(40,20,w,h);
  func();
  for i:=1 to w do
  begin
  mint[1][i]:=round((mdoub[1][i]-xn)*((w-40)/(xm-xn)))+40;
  mint[2][i]:=round((ymax-mdoub[2][i])*((h-20)/(ymax-ymin)))+20;
  mint[3][i]:=round((ymax-mdoub[3][i])*((h-20)/(ymax-ymin)))+20;
  end;
  unit3.form3.Image1.Canvas.Pen.Color:=clred;
  unit3.form3.Image1.Canvas.MoveTo(mint[1][1],mint[2][1]);
  for i:=2 to w do
  begin
  unit3.form3.Image1.Canvas.LineTo(mint[1][i],mint[2][i]);
  end;
  unit3.form3.Image1.Canvas.Pen.Color:=clgreen;
  unit3.form3.Image1.Canvas.MoveTo(mint[1][1],mint[3][1]);
  for i:=2 to w do
  begin
  unit3.form3.Image1.Canvas.LineTo(mint[1][i],mint[3][i]);
  end;
  lx:=round((w-40)/(gor));
  dx:=(xm-xn)/(gor);
  unit3.form3.Image1.Canvas.Pen.Color:=clsilver;
  for i:=0 to gor do
  begin
  unit3.form3.image1.canvas.textout(i*lx+40,5,floattostr((round((xn+i*dx)*1000)/1000)));
  unit3.form3.Image1.Canvas.MoveTo((i*lx+40),20);
  unit3.form3.Image1.Canvas.LineTo((i*lx+40),h);
  end;
  ly:=round((h-20)/(vert));
  dy:=(ymax-ymin)/(vert);
  for i:=0 to vert do
  begin
  unit3.form3.image1.canvas.textout(5,i*ly+20,floattostr(round((ymax-i*dy)*1000)/1000));
  unit3.form3.Image1.Canvas.MoveTo(40,(i*ly+20));
  unit3.form3.Image1.Canvas.LineTo(w,(i*ly+20));
  end;
end;

{ TForm3 }

procedure TForm3.Button1Click(Sender: TObject);
begin
   funcpostr1();
  rast:=xm-xn;
  xnres:=xn;

end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  image1.Canvas.Clear;
  close;
end;

procedure TForm3.ScrollBar1Change(Sender: TObject);
var proc:double;
begin
  proc:=((scrollbar1.Position+50)/100);
  unit2.form2.Edit1.text:=floattostr(xnres*proc);
  unit2.form2.Edit2.text:=floattostr(xn+rast);
  image1.Canvas.Clear;
  funcpostr1();
end;



end.

