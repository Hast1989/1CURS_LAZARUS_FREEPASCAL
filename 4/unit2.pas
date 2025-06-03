unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    CheckGroup1: TCheckGroup;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    procedure Button1Click(Sender: TObject);


  public

  end;

var
  Form2: TForm2;

implementation


{$R *.lfm}

{ TForm2 }
procedure TForm2.Button1Click(Sender: TObject);
var j,i:byte;
begin
  j:=0;
  for i:=0 to 4 do
  begin
    if unit2.Form2.checkgroup1.checked[i]=true then
    begin
    j:=j+1;
    end;
  end;
  if j=2 then
  begin
  close;
  end
  else
  begin
    showmessage('ENTER TWO FUNCTIONS');
  end;
end;




end.

