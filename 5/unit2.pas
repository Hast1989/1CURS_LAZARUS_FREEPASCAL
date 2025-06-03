unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation
uses Unit1,Unit3;

{$R *.lfm}


{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);
begin
  close;
end;

procedure TForm2.Button2Click(Sender: TObject);
var a1,a2,a3,b1,b2,b3,c1,c2,c3,d1,d2,d3,a4,b4,c4,d4:double;
  x0,y0:word;
  mx,my,mz:double;
  yx,yy:word;
  xs1,ys1:word;
  x,y,z:double;
  n,i,k:int64;
  mem:string;
  col:tcolor;
  f:textfile;
begin
  assignfile(f,'text1.txt');
  rewrite(f);
    randomize;
    n:=strtoint(Unit1.form1.Edit1.text);
    x0:=410;
    y0:=290;
    a1:=strtofloat(Unit1.form1.StringGrid1.Cells[1,1]);
    a2:=strtofloat(Unit1.form1.StringGrid1.Cells[1,2]);
    a3:=strtofloat(Unit1.form1.StringGrid1.Cells[1,3]);
    b1:=strtofloat(Unit1.form1.StringGrid1.Cells[2,1]);
    b2:=strtofloat(Unit1.form1.StringGrid1.Cells[2,2]);
    b3:=strtofloat(Unit1.form1.StringGrid1.Cells[2,3]);
    c1:=strtofloat(Unit1.form1.StringGrid1.Cells[3,1]);
    c2:=strtofloat(Unit1.form1.StringGrid1.Cells[3,2]);
    c3:=strtofloat(Unit1.form1.StringGrid1.Cells[3,3]);
    d1:=strtofloat(Unit1.form1.StringGrid1.Cells[4,1]);
    d2:=strtofloat(Unit1.form1.StringGrid1.Cells[4,2]);
    d3:=strtofloat(Unit1.form1.StringGrid1.Cells[4,3]);
    a4:=strtofloat(Unit1.form1.StringGrid1.Cells[1,4]);
    b4:=strtofloat(Unit1.form1.StringGrid1.Cells[2,4]);
    c4:=strtofloat(Unit1.form1.StringGrid1.Cells[3,4]);
    d4:=strtofloat(Unit1.form1.StringGrid1.Cells[4,4]);
    image1.Canvas.Rectangle(0,0,700,700);
    Image1.Canvas.Pen.Color:=clblack;
    Image1.Canvas.Pen.Width:=2;
    image1.Canvas.moveto(290,410);
    image1.Canvas.LineTo(290,40);
    image1.Canvas.TextOut(295,45,'Z');
    image1.Canvas.moveto(290,410);
    image1.Canvas.LineTo(660,410);
    image1.Canvas.TextOut(655,415,'X');
    image1.Canvas.moveto(290,410);
    image1.Canvas.LineTo(20,680);
    image1.Canvas.TextOut(30,675,'Y');
    mx:=round((abs(d1)+abs(d1))/2)*2;
    mz:=mx;
    my:=mx/2;
    i:=0;
    k:=0;
    col:=unit1.form1.ColorBox1.Selected;
    while i<(n) do
    begin
    x:=random(round(abs(d1))*100)/(abs(d1)*7);
    z:=random(round(abs(d1))*100)/(abs(d1)*7);
    y:=(-d1-a1*x-c1*z)/b1;
    if (a2*x+b2*y+c2*z+d2<0) and (a3*x+b3*y+c3*z+d3<0) then
    begin
    yx:=290-round((my*y)/sqrt(2));
    yy:=410+round((my*y)/sqrt(2));
    xs1:=yx+round(x*mx);
    ys1:=yy-round(z*mz);
    if a4*x+b4*y+c4*z+d4<0 then begin
    image1.Canvas.Pixels[xs1,ys1]:=col;
    image1.Canvas.Pixels[xs1+1,ys1]:=col;
    image1.Canvas.Pixels[xs1,ys1+1]:=col;
    image1.Canvas.Pixels[xs1+1,ys1+1]:=col;
    end else begin
    image1.Canvas.Pixels[xs1,ys1]:=col;
    image1.Canvas.Pixels[xs1+1,ys1]:=clsilver;
    image1.Canvas.Pixels[xs1,ys1+1]:=clsilver;
    image1.Canvas.Pixels[xs1+1,ys1+1]:=clsilver;
    end;
    i:=i+1;
    mem:='';
    mem:=mem+inttostr(k+1);
    while length(mem)<10 do begin mem:=mem+' ' end;
    mem:=mem+floattostr(round(x*1000)/1000);
    while length(mem)<30 do begin mem:=mem+' ' end;
    mem:=mem+floattostr(round(y*1000)/1000);
    while length(mem)<60 do begin mem:=mem+' ' end;
    mem:=mem+floattostr(round(z*1000)/1000);
    unit3.Form3.ListBox1.Items.Add(mem);
    writeln(f,mem);
    k:=k+1;
    end;
    end;
    col:=unit1.form1.ColorBox2.Selected;
    i:=0;
    while i<(n ) do
    begin
     y:=random(round(abs(d2))*100)/(abs(d2)*7);
    z:=random(round(abs(d2))*100)/(abs(d2)*7);
    x:=(-d2-b2*y-c2*z)/a2;
    if (a1*x+b1*y+c1*z+d1<0) and (a3*x+b3*y+c3*z+d3<0)   then
    begin
    yx:=290-round((my*y)/sqrt(2));
    yy:=410+round((my*y)/sqrt(2));
    xs1:=yx+round(x*mx);
    ys1:=yy-round(z*mz);
    if a4*x+b4*y+c4*z+d4<0 then begin
    image1.Canvas.Pixels[xs1,ys1]:=col;
    image1.Canvas.Pixels[xs1+1,ys1]:=col;
    image1.Canvas.Pixels[xs1,ys1+1]:=col;
    image1.Canvas.Pixels[xs1+1,ys1+1]:=col;
    end else begin
    image1.Canvas.Pixels[xs1,ys1]:=col;
    image1.Canvas.Pixels[xs1+1,ys1]:=clsilver;
    image1.Canvas.Pixels[xs1,ys1+1]:=clsilver;
    image1.Canvas.Pixels[xs1+1,ys1+1]:=clsilver;
    end;
    i:=i+1;
    mem:='';
    mem:=mem+inttostr(k+1);
    while length(mem)<10 do begin mem:=mem+' ' end;
    mem:=mem+floattostr(round(x*1000)/1000);
    while length(mem)<30 do begin mem:=mem+' ' end;
    mem:=mem+floattostr(round(y*1000)/1000);
    while length(mem)<60 do begin mem:=mem+' ' end;
    mem:=mem+floattostr(round(z*1000)/1000);
    unit3.Form3.ListBox1.Items.Add(mem);
    writeln(f,mem);
    k:=k+1;
    end;
    end;
    col:=unit1.form1.ColorBox3.Selected;
    i:=0;
    while i<(n) do
    begin
    x:=random(round(abs(d3))*100)/(abs(d3)*7);
    y:=random(round(abs(d3))*100)/(abs(d3)*7);
    z:=(-d3-a3*x-b3*y)/c3;
    if (a2*x+b2*y+c2*z+d2<0) and (a1*x+b1*y+c1*z+d1<0) then
    begin
    yx:=290-round((my*y)/sqrt(2));
    yy:=410+round((my*y)/sqrt(2));
    xs1:=yx+round(x*mx);
    ys1:=yy-round(z*mz);
    if a4*x+b4*y+c4*z+d4<0 then begin
    image1.Canvas.Pixels[xs1,ys1]:=col;
    image1.Canvas.Pixels[xs1+1,ys1]:=col;
    image1.Canvas.Pixels[xs1,ys1+1]:=col;
    image1.Canvas.Pixels[xs1+1,ys1+1]:=col;
    end else begin
    image1.Canvas.Pixels[xs1,ys1]:=col;
    image1.Canvas.Pixels[xs1+1,ys1]:=clsilver;
    image1.Canvas.Pixels[xs1,ys1+1]:=clsilver;
    image1.Canvas.Pixels[xs1+1,ys1+1]:=clsilver;
    end;
    i:=i+1;
    mem:='';
    mem:=mem+inttostr(k+1);
    while length(mem)<10 do begin mem:=mem+' ' end;
    mem:=mem+floattostr(round(x*1000)/1000);
    while length(mem)<30 do begin mem:=mem+' ' end;
    mem:=mem+floattostr(round(y*1000)/1000);
    while length(mem)<60 do begin mem:=mem+' ' end;
    mem:=mem+floattostr(round(z*1000)/1000);
    unit3.Form3.ListBox1.Items.Add(mem);
    writeln(f,mem);
    k:=k+1;
    end;
    end;
    z:=0;
    x:=0;
    y:=(-d4-a4*x-c4*z)/b4;
    yx:=290-round((my*y)/sqrt(2));
    yy:=410+round((my*y)/sqrt(2));
    xs1:=yx+round(x*mx);
    ys1:=yy-round(z*mz);
    image1.Canvas.moveto(290+round((-d4/a4)*mx),410);
    image1.Canvas.LineTo(xs1,ys1);
    y:=0;
    x:=0;
    z:=(-d4-a4*x-b4*y)/c4;
    yx:=290-round((my*y)/sqrt(2));
    yy:=410+round((my*y)/sqrt(2));
    xs1:=yx+round(x*mx);
    ys1:=yy-round(z*mz);
    image1.Canvas.LineTo(xs1,ys1);
    z:=0;
    y:=0;
    x:=(-d4-c4*z-b4*y)/a4;
    yx:=290-round((my*y)/sqrt(2));
    yy:=410+round((my*y)/sqrt(2));
    xs1:=yx+round(x*mx);
    ys1:=yy-round(z*mz);
    image1.Canvas.LineTo(xs1,ys1);
    closefile(f);

end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  unit3.form3.showmodal;
end;

end.

