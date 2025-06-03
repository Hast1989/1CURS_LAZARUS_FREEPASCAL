unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Menus, ActnList,dos;
Const
            ReadOnly = $01; {только для чтения}
            Hidden = $02; {скрытый}
            SysFile = $04; {системный}
            Directory = $10; {директория}
            Archive = $20; {архивированный}
           faAnyFile = $3F; {все файлы}

Type
           tSex = (woman, man);
           tSlug = record
                       nam: string[15];
                       fam: string[15];
                       date: 1920..2000;
                       sex: tSex;
                       dolgn: record
                              prof: record
                                    name: string[15];
                                    stag: byte;
                                    doxod: record
                                           osn: word;
                                           premiya: word;
                                           nalog: double   {13%}
                                           end; {doxod}
                                    end; {prof}
                              telef : longint
                              end; {dolgn}
                      end; {tSlug}
           tf=file of tslug;
var passtextg,imiatextg:string;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    createfile: TMenuItem;
    del: TMenuItem;
    deletfamily: TMenuItem;
    deleteage: TMenuItem;
    renamefail: TMenuItem;
    deletfail: TMenuItem;
    textfile: TMenuItem;
    textfile1: TMenuItem;
    textfile2: TMenuItem;
    search: TMenuItem;
    searchname: TMenuItem;
    checkfail: TMenuItem;
    searchrassh: TMenuItem;
    information: TMenuItem;
    eexit: TMenuItem;
    vievingfail: TMenuItem;
    work: TMenuItem;
    findinf: TMenuItem;
    age: TMenuItem;
    sex: TMenuItem;
    proffes: TMenuItem;
    add: TMenuItem;
    procedure ageClick(Sender: TObject);
    procedure checkfailClick(Sender: TObject);
    procedure createfileClick(Sender: TObject);
    procedure deleteageClick(Sender: TObject);
    procedure deletfailClick(Sender: TObject);
    procedure deletfamilyClick(Sender: TObject);
    procedure eexitClick(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure informationClick(Sender: TObject);
    procedure addClick(Sender: TObject);
    procedure renamefailClick(Sender: TObject);
    procedure searchnameClick(Sender: TObject);
    procedure searchrasshClick(Sender: TObject);
    procedure sexClick(Sender: TObject);
    procedure proffesClick(Sender: TObject);
    procedure textfile1Click(Sender: TObject);
    procedure textfile2Click(Sender: TObject);
    procedure vievingfailClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation
uses Unit2,Unit3,Unit4,Unit5;
{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem11Click(Sender: TObject);
begin

end;

procedure TForm1.eexitClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.FormClick(Sender: TObject);
begin

end;

procedure TForm1.createfileClick(Sender: TObject); {создание и заполнение типизированного файла запрашивает путь,имя файла и количество запсей. Вызывает форму для заполнения записи.}
var vr: tslug;
  f: tf;
  pass:string;
  imia:string[20];
  n,i:byte;
begin
  n:=0;
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter name fail','');
  imia:=imia+'.dat';
  pass:=pass+imia;
  assignfile(f,pass);
  rewrite(f);
  n:=strtoint(inputbox('colvo','Enter colvo sotrud',''));
  for i:=1 to n do
  begin
  Unit2.Form2.showmodal;
  vr.nam:=form2.edit1.text;
  vr.fam:=form2.edit2.text;
  vr.date:=strtoint(form2.year.text);
  if form2.radiogroup1.itemindex=0 then
  begin
  vr.sex:=man;
  end else begin vr.sex:=woman; end;
  vr.dolgn.prof.name:=form2.edit5.text;
  vr.dolgn.prof.stag:=strtoint(form2.edit6.text);
  vr.dolgn.prof.doxod.osn:=strtoint(form2.edit7.text);
  vr.dolgn.prof.doxod.premiya:=strtoint(form2.edit8.text);
  vr.dolgn.prof.doxod.nalog:=(vr.dolgn.prof.doxod.osn+vr.dolgn.prof.doxod.premiya)*0.13;
  vr.dolgn.telef:=strtoint(form2.edit9.text);
  write(f,vr);
  form2.edit1.clear;
  form2.edit2.clear;
  form2.edit5.clear;
  form2.edit6.clear;
  form2.edit7.clear;
  form2.edit8.clear;
  form2.edit9.clear;
  form2.year.itemindex:=-1;
  form2.radiogroup1.itemindex:=-1;
  end;
  closefile(f);
end;

procedure TForm1.deleteageClick(Sender: TObject); {Удаление записей по возрасту. Запрашивает путь к фаилу, имя фаила и возраст удаляемых записей}
var vr: tslug;
  f,fr: tf;
  pass:string;
  imia:string[20];
  god:smallint;
begin
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter name fail','');
  god:=strtoint(inputbox('age','Enter god born',''));
  imia:=imia+'.dat';
  pass:=pass+imia;
  assignfile(f,pass);
  assignfile(fr,'reserv.dat');
  reset(f);
  rewrite(fr);
  while not(eof(f)) do
  begin
  read(f,vr);
  if vr.date>=god then
  begin
  write(fr,vr);
  end;
  end;
  closefile(f);
  closefile(fr);
  reset(fr);
  rewrite(f);
  while not(eof(fr)) do
  begin
  read(fr,vr);
  write(f,vr);
  end;
  closefile(f);
  closefile(fr);
  erase(fr);
  showmessage('Danye is delete');

end;

procedure TForm1.deletfailClick(Sender: TObject);  {Удаление фаила. Запрашивает путь к фаилу, имя фаила}
var pass:string;
  imia:string[20];
  f:tf;
begin
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter name fail','');
  imia:=imia+'.dat';
  pass:=pass+imia;
  assignfile(f,pass);
  erase(f);
  showmessage('File is delete');
end;

procedure TForm1.deletfamilyClick(Sender: TObject);  {Удаление записей по фамилии. Запрашивает путь к фаилу, имя фаила и фамилию}
var vr: tslug;
  f,fr: tf;
  pass:string;
  imia,familiya:string[20];
begin
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter name fail','');
  familiya:=inputbox('Familiya','Enter family','');
  imia:=imia+'.dat';
  pass:=pass+imia;
  assignfile(f,pass);
  assignfile(fr,'reserv.dat');
  reset(f);
  rewrite(fr);
  while not(eof(f)) do
  begin
  read(f,vr);
  if vr.fam<>familiya then
  begin
  write(fr,vr);
  end;
  end;
  closefile(f);
  closefile(fr);
  reset(fr);
  rewrite(f);
  while not(eof(fr)) do
  begin
  read(fr,vr);
  write(f,vr);
  end;
  closefile(f);
  closefile(fr);
  erase(fr);
  showmessage('Danye is delete');

end;

procedure TForm1.checkfailClick(Sender: TObject); {Проверка существования фаила. Запрашивает путь к фаилу, имя фаила}
var pass:string;
  imia:string[20];
  findinfo:searchrec;
begin
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter name fail','');
  imia:=imia+'.dat';
  pass:=pass+imia;
  findfirst(pass, anyfile, findInfo);
  if findinfo.name=imia then begin showmessage('yes file'); end else begin showmessage('no file'); end;
  end;

procedure TForm1.ageClick(Sender: TObject); {Поиск по возрасту.Запрашивает путь к фаилу, имя фаила и возраст. Выводит фамилию имя возраст и телефон}
var vr: tslug;
  f: tf;
  pass,vivod:string;
  imia:string[20];
  n:byte;
  agen:byte;
begin
  n:=0;
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter name fail','');
  imia:=imia+'.dat';
  pass:=pass+imia;
  assignfile(f,pass);
  reset(f);
  agen:=strtoint(inputbox('search of age','Enter age',''));
  form3.memo1.lines.add('fail '+pass+'  serch result:');
  while not(eof(f)) do
  begin
  read(f,vr);
  if agen=(2022-vr.date) then
  begin
  n:=n+1;
  vivod:='';
  vivod:=vivod+inttostr(n);
  vivod:=vivod+'|';
  vivod:=vivod+vr.fam;
  vivod:=vivod+'|';
  vivod:=vivod+vr.nam;
  vivod:=vivod+'|';
  vivod:=vivod+inttostr(agen)+'|';
  vivod:=vivod+inttostr(vr.dolgn.telef);
  form3.memo1.lines.add(vivod);
  end;
  end;
  closefile(f);
  Unit3.Form3.showmodal;
end;

procedure TForm1.informationClick(Sender: TObject);
begin
  showmessage('This program was creating for "informatica" in the second semestr Student the first course. Group FN2-22B Pakhotin A.E.');
end;

procedure TForm1.addClick(Sender: TObject); {Добавления записи в типизированный фаил.Запрашивает путьк фаилу имя фаила количество новых записей}
var vr: tslug;
  f: tf;
  pass:string;
  imia:string[20];
  n,i:byte;
begin
  n:=0;
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter name fail','');
  imia:=imia+'.dat';
  pass:=pass+imia;
  assignfile(f,pass);
  reset(f);
  seek(f,filesize(f));
  n:=strtoint(inputbox('colvo','Enter colvo sotrud',''));
  for i:=1 to n do
  begin
  Unit2.Form2.showmodal;
  vr.nam:=form2.edit1.text;
  vr.fam:=form2.edit2.text;
  vr.date:=strtoint(form2.year.text);
  if form2.radiogroup1.itemindex=0 then
  begin
  vr.sex:=man;
  end else begin vr.sex:=woman; end;
  vr.dolgn.prof.name:=form2.edit5.text;
  vr.dolgn.prof.stag:=strtoint(form2.edit6.text);
  vr.dolgn.prof.doxod.osn:=strtoint(form2.edit7.text);
  vr.dolgn.prof.doxod.premiya:=strtoint(form2.edit8.text);
  vr.dolgn.prof.doxod.nalog:=(vr.dolgn.prof.doxod.osn+vr.dolgn.prof.doxod.premiya)*0.13;
  vr.dolgn.telef:=strtoint(form2.edit9.text);
  write(f,vr);
  form2.edit1.clear;
  form2.edit2.clear;
  form2.edit5.clear;
  form2.edit6.clear;
  form2.edit7.clear;
  form2.edit8.clear;
  form2.edit9.clear;
  form2.year.itemindex:=-1;
  form2.radiogroup1.itemindex:=-1;
  end;
  closefile(f);
end;

procedure TForm1.renamefailClick(Sender: TObject); {Переименование типизированного фаила.Запрашивает путьк фаилу имя фаила и новое имя фаила}
var pass,newpass:string;
  imia,renamef:string[20];
  f:tf;
begin
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter name fail','');
  imia:=imia+'.dat';
  newpass:=pass;
  pass:=pass+imia;
  renamef:=inputbox('Nmae fail','Enter new name fail','');
  assignfile(f,pass);
  renamef:=renamef+'.dat';
  newpass:=newpass+renamef;
  rename(f,newpass);
  showmessage('File is rename');
end;

procedure TForm1.searchnameClick(Sender: TObject); {Поиск фаила по имени. Запрашивает путь к фаилу, имя фаила}
var pass:string;
  imia:string[20];
  findinfo:searchrec;
begin
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter name fail','');
  pass:=pass+imia+'.*';
  findfirst(pass, anyfile, findInfo);
  while DosError=0 do begin
         Form5.Memo1.Lines.add(findInfo.Name);
         findnext(findinfo);
  end;
  Unit5.Form5.showmodal;
  end;

procedure TForm1.searchrasshClick(Sender: TObject); {Поиск фаила по имени. Запрашивает путь к фаилу, расширение фаила}
var pass:string;
  imia:string[20];
  findinfo:searchrec;
begin
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter rasshrenie faila','');
  pass:=pass+'*.'+imia;
  findfirst(pass, anyfile, findInfo);
  while DosError=0 do begin
         form5.Memo1.Lines.add(findInfo.Name);
         findnext(findinfo);
  end;
  Unit5.Form5.showmodal;
  end;


procedure TForm1.sexClick(Sender: TObject); {Поиск по полу.Запрашивает путь к фаилу, имя фаила и пол. Выводит фамилию имя пол и телефон}
var vr: tslug;
  f: tf;
  pass,vivod:string;
  imia:string[20];
  n:byte;
  agen:tsex;
begin
  n:=0;
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter name fail','');
  imia:=imia+'.dat';
  pass:=pass+imia;
  assignfile(f,pass);
  reset(f);
  Unit4.Form4.showmodal;
  if form4.radiogroup1.itemindex=0 then
  begin
  agen:=woman;
  end else begin agen:=man; end;
  form3.memo1.lines.add('fail '+pass+'  serch result:');
  while not(eof(f)) do
  begin
  read(f,vr);
  if agen=vr.sex then
  begin
  n:=n+1;
  vivod:='';
  vivod:=vivod+inttostr(n);
  vivod:=vivod+'|';
  vivod:=vivod+vr.fam;
  vivod:=vivod+'|';
  vivod:=vivod+vr.nam;
  vivod:=vivod+'|';
  if vr.sex=woman then begin vivod:=vivod+'woman'+'|'; end else begin vivod:=vivod+'man  '+'|'; end;
  vivod:=vivod+inttostr(vr.dolgn.telef);
  form3.memo1.lines.add(vivod);
  end;
  end;
  closefile(f);
  Unit3.Form3.showmodal;

end;

procedure TForm1.proffesClick(Sender: TObject);
var vr: tslug;
  f: tf;
  pass,vivod:string;
  imia:string[20];
  n:byte;
  agen:string;
begin
  n:=0;
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter name fail','');
  imia:=imia+'.dat';
  pass:=pass+imia;
  assignfile(f,pass);
  reset(f);
  agen:=inputbox('search of name prof','Enter name prof','');
  form3.memo1.lines.add('fail '+pass+'  serch result:');
  while not(eof(f)) do
  begin
  read(f,vr);
  if agen=vr.dolgn.prof.name then
  begin
  n:=n+1;
  vivod:='';
  vivod:=vivod+inttostr(n);
  vivod:=vivod+'|';
  vivod:=vivod+vr.fam;
  vivod:=vivod+'|';
  vivod:=vivod+vr.nam;
  vivod:=vivod+'|';
  vivod:=vivod+vr.dolgn.prof.name+'|';
  vivod:=vivod+inttostr(vr.dolgn.telef);
  form3.memo1.lines.add(vivod);
  end;
  end;
  closefile(f);
  Unit3.Form3.showmodal;

end;

procedure TForm1.textfile1Click(Sender: TObject);
var vr: tslug;
  f: tf;
  tf:textfile;
  pass,passtext:string;
  imia,imiatext,dir:string[20];
begin
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter name fail','');
  dir:=inputbox('Nmae dir','Enter name dir','');
  passtext:=pass;
  createdir(passtext+dir);
  passtext:=passtext+dir;
  if passtext[length(passtext)]<>'\' then passtext:=passtext + '\';
  passtextg:=passtext;
  imiatextg:=imia;
  imiatext:='1_'+imia+'.txt';
  imia:=imia+'.dat';
  pass:=pass+imia;
  passtext:=passtext+imiatext;
  assignfile(f,pass);
  reset(f);
  assignfile(tf,passtext);
  rewrite(tf);
  while not(eof(f)) do
  begin
  read(f,vr);
  write(tf,inttostr(vr.dolgn.prof.doxod.osn));
  write(tf,' ');
  write(tf,inttostr(vr.dolgn.prof.doxod.premiya));
  write(tf,' ');
  write(tf,floattostr(vr.dolgn.prof.doxod.nalog));
  writeln(tf);
  end;
  closefile(f);
  closefile(tf);
  showmessage('fail is create');
end;

procedure TForm1.textfile2Click(Sender: TObject);
var f1,f2:textfile;
  res,resint:string;
  osndoh,premiyadoh:longint;
  i:byte;
begin
  if passtextg<>'' then begin
  assignfile(f1,passtextg+'1_'+imiatextg+'.txt');
  assignfile(f2,passtextg+'2_'+imiatextg+'.txt');
  reset(f1);
  rewrite(f2);
  while not(eof(f1)) do
  begin
  readln(f1,res);
  resint:='';
  i:=1;
  while res[i]<>' ' do
  begin
  resint:=resint+res[i];
  i:=i+1;
  end;
  osndoh:=strtoint(resint);
  resint:='';
  i:=i+1;
  while res[i]<>' ' do
  begin
  resint:=resint+res[i];
  i:=i+1;
  end;
  premiyadoh:=strtoint(resint);
  write(f2,inttostr(osndoh+premiyadoh));
  write(f2,' ');
  write(f2,res);
  writeln(f2);
  end;
  closefile(f1);
  closefile(f2);
  showmessage('file was creting');
  end else begin
  showmessage('you did not create the first file');
end;
end;

procedure TForm1.vievingfailClick(Sender: TObject);
var vr: tslug;
  f: tf;
  pass:string;
  imia:string[20];
  n:byte;
  vivod:string;
begin
  n:=0;
  pass:=inputbox('Pass to file','Enter pass to file','');
  if pass[length(pass)]<>'\' then pass:=pass + '\';
  imia:=inputbox('Nmae fail','Enter name fail','');
  imia:=imia+'.dat';
  pass:=pass+imia;
  assignfile(f,pass);
  reset(f);
  form3.memo1.lines.add('fail '+pass);
  while not(eof(f)) do
  begin
  n:=n+1;
  read(f,vr);
  vivod:='';
  vivod:=vivod+inttostr(n);
  vivod:=vivod+'|';
  vivod:=vivod+vr.nam;
  vivod:=vivod+'|';
  vivod:=vivod+vr.fam;
  vivod:=vivod+'|';
  vivod:=vivod+inttostr(vr.date)+'|';
  if vr.sex=woman then begin vivod:=vivod+'woman'+'|'; end else begin vivod:=vivod+'man  '+'|'; end;
  vivod:=vivod+vr.dolgn.prof.name;
  vivod:=vivod+'|';
  vivod:=vivod+inttostr(vr.dolgn.prof.stag);
  vivod:=vivod+'|';
  vivod:=vivod+inttostr(vr.dolgn.prof.doxod.osn);
  vivod:=vivod+'|';
  vivod:=vivod+inttostr(vr.dolgn.prof.doxod.premiya);
  vivod:=vivod+'|';
  vivod:=vivod+floattostr(vr.dolgn.prof.doxod.nalog);
  vivod:=vivod+'|';
  vivod:=vivod+inttostr(vr.dolgn.telef);
  form3.memo1.lines.add(vivod);
  end;
  closefile(f);
  Unit3.Form3.showmodal;
end;

end.

