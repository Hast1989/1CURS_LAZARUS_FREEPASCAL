unit Unit1;
{$mode objfpc}{$H+}
interface
uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Types;
type
  { TForm1 }
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Image1: TImage;
    Label1: TLabel;
    ScrollBar1: TScrollBar;
    Timer1: TTimer;
    Timer2: TTimer;
    Timer3: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);

    procedure Image1Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);


  private

  public

  end;
var
  Form1: TForm1;
  var
    xn,xm,ymin,ymax:double;
    h1,i1,change,k,h,ik:longint;
    mint:array[1..3]of array[1..2000] of longint;
    mpointnach,mpoint:array[1..2] of array[1..17]of longint;
    mdoub:array[1..3]of array[1..2000] of double;
    mpoinsin:array[1..2] of array [1..17] of longint;
    flag:byte;
implementation
{$R *.lfm}
{ TForm1 }
procedure sinus();
var xz:double;
  i:longint;
begin
  h1:=150;
  xn:=-7;
  xm:=7;
  ymin:=-3;
  ymax:=3;
  xz:=xn;
  for i:=1 to 1000+round(h1*1.5) do
  begin
      mdoub[1][i]:=xz;
      mdoub[3][i]:=sin(mdoub[1][i]);
      mdoub[2][i]:=mdoub[1][i]/2;
      mint[1][i]:=round((mdoub[1][i]-xn)*(1000/(xm-xn))-(h1*1.5));
      mint[2][i]:=round((ymax-mdoub[2][i])*(600/(ymax-ymin)));
      mint[3][i]:=round((ymax-mdoub[3][i])*(600/(ymax-ymin)));
      xz:=xz+(xm-xn)/1000;
  end;
end;
procedure painting(x,y,h:longint);
begin
   form1.Image1.Canvas.brush.Color:=clwhite;
   form1.image1.canvas.Rectangle(-10,-10,1010,610);
   form1.image1.canvas.Pen.Width:=1;
   if form1.checkbox2.Checked=true then begin
  form1.image1.canvas.Pen.Color:=clblack;
  form1.Image1.Canvas.brush.Color:=cllime;
  end else begin
  form1.image1.canvas.Pen.Color:=clgray;
  form1.Image1.Canvas.brush.Color:=clgray;
  end;
   form1.image1.Canvas.RoundRect(x,y,x+h,y+round(h/5),round(h/10),round(h/10));
   if form1.checkbox2.Checked=true then begin
  form1.image1.canvas.Pen.Color:=clblack;
  form1.Image1.Canvas.brush.Color:=claqua;
  end else begin
  form1.image1.canvas.Pen.Color:=clsilver;
  form1.Image1.Canvas.brush.Color:=clsilver;
  end;
   form1.image1.Canvas.RoundRect(x+round(h/40),y+round(h/40),x+h-round(h/40),y+round(h/5)-round(h/40),round(h/10),round(h/10));
   if form1.checkbox2.Checked=true then begin
  form1.image1.canvas.Pen.Color:=clblue;
  form1.Image1.Canvas.brush.Color:=clfuchsia;
  end else begin
  form1.image1.canvas.Pen.Color:=clgray;
  form1.Image1.Canvas.brush.Color:=clgray;
  end;
   form1.Image1.canvas.Ellipse(x+round(h/20)-round(h/60),y+round(h/20)-round(h/60),x+round(3*h/20)+round(h/60),y+round(3*h/20)+round(h/60));
   if form1.checkbox2.Checked=true then begin
   form1.image1.canvas.Pen.Color:=clgray;
   form1.Image1.Canvas.brush.Color:=clwhite;
   end else begin
   form1.image1.canvas.Pen.Color:=clgray;
   form1.Image1.Canvas.brush.Color:=clwhite;
   end;
   form1.Image1.canvas.Ellipse(x+round(h/20),y+round(h/20),x+round(3*h/20),y+round(3*h/20));

   if form1.checkbox2.Checked=true then begin
  form1.image1.canvas.Pen.Color:=clnavy;
  form1.Image1.Canvas.brush.Color:=clgreen;
  end else begin
  form1.image1.canvas.Pen.Color:=clgray;
  form1.Image1.Canvas.brush.Color:=clgray;
  end;
   form1.image1.canvas.pie(x+h-round(h/5),y-round(h/5),x+h+2*round(h/5),y+2*round(h/5),x+2*round(h/5)+h,y,x+2*round(h/5)+h,y+round(h/5));
   if form1.checkbox2.Checked=true then begin
  form1.image1.canvas.Pen.Color:=clteal;
  form1.Image1.Canvas.brush.Color:=clred;
  end else begin
  form1.image1.canvas.Pen.Color:=clsilver;
  form1.Image1.Canvas.brush.Color:=clsilver;
  end;
   form1.Image1.canvas.Ellipse(x+h-round(h/5)+round(h/40),y-round(h/5)+round(h/40),x+h+2*round(h/5)-round(h/40),y+2*round(h/5)-round(h/40));
   if form1.checkbox2.Checked=true then begin
  form1.image1.canvas.Pen.Color:=clnavy;
  form1.Image1.Canvas.brush.Color:=clnavy;
  end else begin
  form1.image1.canvas.Pen.Color:=clgray;
  form1.Image1.Canvas.brush.Color:=clgray;
  end;
   form1.image1.Canvas.RoundRect(x+h-round(h/40),y-round(h/20)-round(h/40),x+h+4*round(h/5)+round(h/40),y+round(5*h/20)+round(h/40),round(h/10),round(h/10));
   form1.image1.canvas.Pen.Color:=clwhite;
   form1.Image1.Canvas.brush.Color:=clwhite;
   form1.image1.Canvas.RoundRect(x+h,y-round(h/20),x+h+4*round(h/5),y+round(5*h/20),round(h/10),round(h/10));
   form1.image1.Canvas.Rectangle(x+round(h/3)+h,y-round(h/18)-round(h/40),x+h+4*round(h/5)+round(h/40),y+round(h/4)+round(h/30));
   if form1.checkbox2.Checked=true then begin
  form1.image1.canvas.Pen.Color:=clyellow;
  form1.Image1.Canvas.brush.Color:=clred;
  end else begin
  form1.image1.canvas.brush.Color:=clgray;
  form1.Image1.Canvas.font.Color:=clwhite;
  end;
   form1.Image1.Canvas.Font.Size:=round(h/19);
   form1.image1.canvas.textout(x+round(h/3),y+round(h/20),'PAHOTIN');
end;
procedure graf(change:longint);
var i:longint;
begin
   if change=2 then begin
   form1.image1.canvas.Pen.Width:=2;
   form1.image1.canvas.Pen.Color:=clblue;
   end else begin
     form1.image1.canvas.Pen.Width:=2;
   form1.image1.canvas.Pen.Color:=clred;
   end;
   form1.image1.canvas.MoveTo(mint[1][1],mint[change][1]);
   for i:=2 to 1000+round(h1*1.5) do
   begin
   form1.image1.canvas.LineTo(mint[1][i],mint[change][i]);
   end;
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
   checkbox1.Checked:=false;
   checkbox3.Checked:=false;
   flag:=0;
   scrollbar1.Position:=50;
   timer1.Enabled:=false;
   timer2.Enabled:=false;
   timer3.Enabled:=false;
   //form1.Image1.Canvas.brush.Color:=form1.Color;
   form1.image1.canvas.Rectangle(-1,-1,710,610);
  painting(50,250,360);
end;
procedure TForm1.Button2Click(Sender: TObject);
 begin
    close;
 end;
procedure TForm1.Button3Click(Sender: TObject);
var i:longint;
  xz:double;
begin
   flag:=1;
   timer1.Enabled:=false;
   timer2.Enabled:=false;
   timer3.Enabled:=false;
   form1.Image1.Canvas.brush.Color:=form1.Color;
   form1.image1.canvas.Rectangle(-1,-1,1010,610);
  h1:=150;
  xn:=-500;
  xm:=500;
  ymin:=-300;
  ymax:=300;
  xz:=xn;
  for i:=1 to 1000+round(h1*1.5) do
  begin
      mdoub[1][i]:=xz;
      mdoub[2][i]:=mdoub[1][i]/2;
      mint[1][i]:=round((mdoub[1][i]-xn)*(1000/(xm-xn))-(h1*1.5));
      mint[2][i]:=round((ymax-mdoub[2][i])*(600/(ymax-ymin)));
      xz:=xz+(xm-xn)/1000;
  end;
  i1:=150;
  change:=2;
  timer1.Interval:=10;
  timer1.Enabled:=true;

end;
procedure TForm1.Button4Click(Sender: TObject);
var i:longint;
  xz:double;
begin
  flag:=1;
  timer1.Enabled:=false;
  timer2.Enabled:=false;
  timer3.Enabled:=false;
   form1.Image1.Canvas.brush.Color:=form1.Color;
   form1.image1.canvas.Rectangle(-1,-1,1010,610);
  h1:=150;
  xn:=-7;
  xm:=7;
  ymin:=-3;
  ymax:=3;
  xz:=xn;
  for i:=1 to 1000+round(h1*2) do
  begin
      mdoub[1][i]:=xz;
      mdoub[3][i]:=sin(mdoub[1][i]);
      mint[1][i]:=round((mdoub[1][i]-xn)*(1000/(xm-xn))-(h1*1.5));
      mint[3][i]:=round((ymax-mdoub[3][i])*(600/(ymax-ymin)));
      xz:=xz+(xm-xn)/1000;
  end;
  i1:=150;
  change:=3;
  timer1.Interval:=10;
  timer1.Enabled:=true;
end;
procedure TForm1.Button5Click(Sender: TObject);
var x,y,h:longint;
begin
  checkbox1.Checked:=false;
  flag:=2;
  timer1.Enabled:=false;
  timer2.Enabled:=false;
  timer3.Enabled:=false;
  x:=500;
  y:=280;
  h:=200;
  mpointnach[1][1]:=x;
  mpointnach[2][1]:=y;
  mpointnach[1][2]:=x+h;
  mpointnach[2][2]:=y;
  mpointnach[1][3]:=x+h;
  mpointnach[2][3]:=round(y+h/5);
  mpointnach[1][4]:=x;
  mpointnach[2][4]:=round(y+h/5);
  mpointnach[1][5]:=round(x+h);
  mpointnach[2][5]:=round(y);
  mpointnach[1][6]:=round(x+11*h/10);
  mpointnach[2][6]:=round(y-h/7);
  mpointnach[1][7]:=round(x+14*h/10);
  mpointnach[2][7]:=round(y-h/7);
  mpointnach[1][8]:=round(x+3*h/2);
  mpointnach[2][8]:=round(y);
  mpointnach[1][9]:=round(x+5*h/4);
  mpointnach[2][9]:=round(y);
  mpointnach[1][10]:=round(x+5*h/4);
  mpointnach[2][10]:=round(y+h/5);
  mpointnach[1][11]:=round(x+3*h/2);
  mpointnach[2][11]:=round(y+h/5);
  mpointnach[1][12]:=round(x+14*h/10);
  mpointnach[2][12]:=round(y+h/5+h/7);
  mpointnach[1][13]:=round(x+11*h/10);
  mpointnach[2][13]:=round(y+h/5+h/7);
  mpointnach[1][14]:=round(x+h);
  mpointnach[2][14]:=round(y+h/5);
  mpointnach[1][15]:=round(x+h/10);
  mpointnach[2][15]:=round(y+h/10);
  mpointnach[1][16]:=round(x+3*h/20);
  mpointnach[2][16]:=round(y+3*h/20);
  mpointnach[1][17]:=round(x+h/20);
  mpointnach[2][17]:=round(y+h/20);
  timer2.Interval:=10;
  timer2.Enabled:=true;

end;
procedure TForm1.Button6Click(Sender: TObject);
begin
   flag:=3;
   timer1.Enabled:=false;
   timer2.Enabled:=false;
   timer3.Enabled:=false;
   sinus();
   ik:=150;
   change:=3;
   timer3.Interval:=10;
  timer3.Enabled:=true;
end;
procedure TForm1.Button7Click(Sender: TObject);
begin
  flag:=3;
   timer1.Enabled:=false;
   timer2.Enabled:=false;
   timer3.Enabled:=false;
   sinus();
   ik:=150;
   k:=0;
   change:=2;
   timer3.Interval:=10;
  timer3.Enabled:=true;
end;
procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  if not((flag=1) or (flag=3)) then begin checkbox1.Checked:=false;end;
end;
procedure TForm1.CheckBox2Change(Sender: TObject);
begin
  if flag=0 then begin
   painting(50,250,(scrollbar1.Position+10)*6);
  end;
end;

procedure TForm1.CheckBox3Change(Sender: TObject);
begin
   if not(flag=3)  then begin checkbox3.Checked:=false;end;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
   flag:=1;
   timer1.Enabled:=false;
   timer2.Enabled:=false;
   timer3.Enabled:=false;
   form1.Image1.Canvas.brush.Color:=form1.Color;
   form1.image1.canvas.Rectangle(-1,-1,1010,610);
end;
procedure TForm1.ScrollBar1Change(Sender: TObject);
begin
  if flag=0 then begin
  timer2.Enabled:=false;
  timer1.Enabled:=false;
  timer3.Enabled:=false;
   form1.Image1.Canvas.brush.Color:=form1.Color;
   form1.image1.canvas.Rectangle(-1,-1,1010,610);
   painting(50,250,(scrollbar1.Position+10)*6);
 end;
end;
procedure TForm1.Timer1Timer(Sender: TObject);
begin
    painting(mint[1][i1],mint[change][i1],h1);
    if checkbox1.Checked=true then begin
    graf(change);
    end;
    i1:=i1+1;
    if i1>1000+round(h1*1.5) then i1:=1;
end;
procedure TForm1.Timer2Timer(Sender: TObject);
var angle,x0,y0,tmpx:double;
  i,h:smallint;
begin
  h:=200;
  x0:=mpointnach[1][1];
  y0:=(mpointnach[2][1]+mpointnach[2][4])/2;
  angle:=k*pi/180;
  for i:=1 to 17 do
  begin
       tmpx :=mpointnach[1][i];
       mpoint[1][i]:=round(x0)+Round((mpointnach[1][i]-x0)*cos(angle))-Round((mpointnach[2][i]-y0)*sin(angle));
       mpoint[2][i]:=round(y0)+Round((tmpx-x0)*sin(angle))+Round((mpointnach[2][i]-y0)*cos(angle));
  end;
  form1.Image1.Canvas.Brush.Color:=clwhite;
  form1.image1.Canvas.Rectangle(-10,-10,1010,610);
  form1.Image1.canvas.pen.Width:=round(h/50);
  if checkbox2.Checked=true then begin
  form1.image1.canvas.Pen.Color:=clyellow;
  form1.Image1.Canvas.brush.Color:=clmaroon;
  end else begin
  form1.image1.canvas.Pen.Color:=clgray;
  form1.Image1.Canvas.brush.Color:=clblack;
  end;
  form1.Image1.canvas.Polygon([point(mpoint[1][1],mpoint[2][1]),point(mpoint[1][2],mpoint[2][2]),point(mpoint[1][3],mpoint[2][3]),point(mpoint[1][4],mpoint[2][4])]);
  if checkbox2.Checked=true then begin
  form1.image1.canvas.Pen.Color:=clred;
  form1.Image1.Canvas.brush.Color:=cllime;
  end else begin
  form1.image1.canvas.Pen.Color:=clgray;
  form1.Image1.Canvas.brush.Color:=clsilver;
  end;
  form1.Image1.canvas.Polygon([point(mpoint[1][5],mpoint[2][5]),point(mpoint[1][6],mpoint[2][6]),point(mpoint[1][7],mpoint[2][7]),
  point(mpoint[1][8],mpoint[2][8]),point(mpoint[1][9],mpoint[2][9]),point(mpoint[1][10],mpoint[2][10]),point(mpoint[1][11],mpoint[2][11]),
  point(mpoint[1][12],mpoint[2][12]),point(mpoint[1][13],mpoint[2][13]),point(mpoint[1][14],mpoint[2][14])]);
  if checkbox2.Checked=true then begin
  form1.image1.canvas.Pen.Color:=clyellow;
  form1.Image1.Canvas.brush.Color:=clolive;
  form1.Image1.canvas.Ellipse(mpoint[1][17],mpoint[2][17],mpoint[1][16],mpoint[2][16]);
  end else begin
  form1.image1.canvas.Pen.Color:=clgray;
  form1.Image1.Canvas.brush.Color:=clwhite;
  form1.Image1.canvas.Ellipse(round(mpoint[1][15]-h/20),round(mpoint[2][15]-h/20),round(mpoint[1][15]+h/20),round(mpoint[2][15]+h/20));
  end;
  if checkbox3.Checked=true then begin k:=k-1; end else begin k:=k+1;   end;
  if abs(k)=360 then begin k:=0; end;
end;
procedure TForm1.Timer3Timer(Sender: TObject);
var angle,x0,y0,tmpx:double;
  i,h,x,y:smallint;
begin
  h:=150;
  x:=mint[1][ik];
  y:=mint[change][ik];
  mpointnach[1][1]:=x;
  mpointnach[2][1]:=y;
  mpointnach[1][2]:=x+h;
  mpointnach[2][2]:=y;
  mpointnach[1][3]:=x+h;
  mpointnach[2][3]:=round(y+h/5);
  mpointnach[1][4]:=x;
  mpointnach[2][4]:=round(y+h/5);
  mpointnach[1][5]:=round(x+h);
  mpointnach[2][5]:=round(y);
  mpointnach[1][6]:=round(x+11*h/10);
  mpointnach[2][6]:=round(y-h/7);
  mpointnach[1][7]:=round(x+14*h/10);
  mpointnach[2][7]:=round(y-h/7);
  mpointnach[1][8]:=round(x+3*h/2);
  mpointnach[2][8]:=round(y);
  mpointnach[1][9]:=round(x+5*h/4);
  mpointnach[2][9]:=round(y);
  mpointnach[1][10]:=round(x+5*h/4);
  mpointnach[2][10]:=round(y+h/5);
  mpointnach[1][11]:=round(x+3*h/2);
  mpointnach[2][11]:=round(y+h/5);
  mpointnach[1][12]:=round(x+14*h/10);
  mpointnach[2][12]:=round(y+h/5+h/7);
  mpointnach[1][13]:=round(x+11*h/10);
  mpointnach[2][13]:=round(y+h/5+h/7);
  mpointnach[1][14]:=round(x+h);
  mpointnach[2][14]:=round(y+h/5);
  mpointnach[1][15]:=round(x+h/10);
  mpointnach[2][15]:=round(y+h/10);
  mpointnach[1][16]:=round(x+3*h/20);
  mpointnach[2][16]:=round(y+3*h/20);
  mpointnach[1][17]:=round(x+h/20);
  mpointnach[2][17]:=round(y+h/20);
  x0:=mpointnach[1][1];
  y0:=(mpointnach[2][1]+mpointnach[2][4])/2;
  angle:=k*pi/180;
  for i:=1 to 17 do
  begin
       tmpx :=mpointnach[1][i];
       mpoint[1][i]:=round(x0)+Round((mpointnach[1][i]-x0)*cos(angle))-Round((mpointnach[2][i]-y0)*sin(angle));
       mpoint[2][i]:=round(y0)+Round((tmpx-x0)*sin(angle))+Round((mpointnach[2][i]-y0)*cos(angle));
  end;

  form1.Image1.Canvas.Brush.Color:=clwhite;
  form1.image1.Canvas.Rectangle(-10,-10,1010,610);
  form1.Image1.canvas.pen.Width:=round(h/50);
  if checkbox2.Checked=true then begin
  form1.image1.canvas.Pen.Color:=clyellow;
  form1.Image1.Canvas.brush.Color:=clmaroon;
  end else begin
  form1.image1.canvas.Pen.Color:=clgray;
  form1.Image1.Canvas.brush.Color:=clblack;
  end;
  form1.Image1.canvas.Polygon([point(mpoint[1][1],mpoint[2][1]),point(mpoint[1][2],mpoint[2][2]),point(mpoint[1][3],mpoint[2][3]),point(mpoint[1][4],mpoint[2][4])]);
  if checkbox2.Checked=true then begin
  form1.image1.canvas.Pen.Color:=clred;
  form1.Image1.Canvas.brush.Color:=cllime;
  end else begin
  form1.image1.canvas.Pen.Color:=clgray;
  form1.Image1.Canvas.brush.Color:=clsilver;
  end;
  form1.Image1.canvas.Polygon([point(mpoint[1][5],mpoint[2][5]),point(mpoint[1][6],mpoint[2][6]),point(mpoint[1][7],mpoint[2][7]),
  point(mpoint[1][8],mpoint[2][8]),point(mpoint[1][9],mpoint[2][9]),point(mpoint[1][10],mpoint[2][10]),point(mpoint[1][11],mpoint[2][11]),
  point(mpoint[1][12],mpoint[2][12]),point(mpoint[1][13],mpoint[2][13]),point(mpoint[1][14],mpoint[2][14])]);
  if checkbox2.Checked=true then begin
  form1.image1.canvas.Pen.Color:=clyellow;
  form1.Image1.Canvas.brush.Color:=clolive;
  form1.Image1.canvas.Ellipse(mpoint[1][17],mpoint[2][17],mpoint[1][16],mpoint[2][16]);
  end else begin
  form1.image1.canvas.Pen.Color:=clgray;
  form1.Image1.Canvas.brush.Color:=clwhite;
  form1.Image1.canvas.Ellipse(round(mpoint[1][15]-h/20),round(mpoint[2][15]-h/20),round(mpoint[1][15]+h/20),round(mpoint[2][15]+h/20));
  end;
  if checkbox1.Checked=true then begin
  graf(change); end;
  ik:=ik+1;
  if checkbox3.Checked=true then begin k:=k-1; end else begin k:=k+1;   end;
  if abs(k)=360 then begin k:=0; end;
  if ik>=1000+round(h1*1.5) then begin ik:=1; end;
end;
end.

