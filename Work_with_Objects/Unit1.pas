unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TDemoClass=class(TObject)
    {Un champ bidon qui occupe 1KB}
    Field:array[0..1023] of Byte;
    
    constructor Create;
    destructor Destroy; override;

    procedure doCreate;
    procedure doDestroy;

    class function NewInstance: TObject; override;
    procedure FreeInstance; override;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TDemoClass }

{Le code ajout� dans le constructeur est regroup� dans doCreate pour ne pas avoir � passer par l'assembleur
 pour l'extraire}
constructor TDemoClass.Create;
begin
  doCreate;
end;

{Le code ajout� dans le destructeur est regroup� dans doDestroy pour ne pas avoir � passer par l'assembleur
 pour l'extraire}
destructor TDemoClass.Destroy;
begin
  doDestroy;
end;

class function TDemoClass.NewInstance: TObject;
begin
  ShowMessage('1 - Calling NewInstance'#13'    '+IntToStr(InstanceSize)+' Bytes will be allocated');
  Result:=inherited NewInstance;
end;

{Le code de doCreate devrait �tre �crit dans le constructeur, mais �a simplifie l'exemple de le mettre ici}
procedure TDemoClass.doCreate;
begin
  ShowMessage('2 - Calling Constructor');
  if Form1.CheckBox1.Checked then
    raise Exception.Create('Exception raised in constructor');
end;

procedure TDemoClass.AfterConstruction;
begin
  ShowMessage('3 - Calling AfterConstruction');
  inherited;
end;

procedure TDemoClass.BeforeDestruction;
begin
  ShowMessage('4 - Calling BeforeDestruction');
  inherited;
end;

{Le code de doDestroy devrait �tre �crit dans le destructeur, mais �a simplifie l'exemple de le mettre ici}
procedure TDemoClass.doDestroy;
begin
  ShowMessage('5 - Calling Destructor');
  if Form1.CheckBox2.Checked then
    raise Exception.Create('Exception raised in destructor');
end;

procedure TDemoClass.FreeInstance;
begin
  ShowMessage('6 - Calling FreeInstance'#13'    '+IntToStr(InstanceSize)+' Bytes will be unallocated');
  inherited;
end;

{ TForm1 }

{Simulation du code automatiquement g�n�r� par Delphi lors de la cr�ation "normale" d'un object}
procedure TForm1.Button1Click(Sender: TObject);
var
  o:TDemoClass;
  tmp:TObject;
begin
  tmp:=TDemoClass.NewInstance;
  try
    TDemoClass(tmp).doCreate;
    tmp.AfterConstruction;
  except
    tmp.Destroy;
    raise;
  end;
  o:=TDemoClass(tmp);
end;

{Cr�ation "normale" d'un object}
procedure TForm1.Button2Click(Sender: TObject);
var
  o:TDemoClass;
begin
  o:=TDemoClass.Create;
end;

{Ce que ne FAIT PAS Delphi: code pour lib�rer toutes les resources lors de la destruction, m�me en cas
 d'erreur dans le destructeur}
procedure TForm1.Button3Click(Sender: TObject);
var
  o:TDemoClass;
begin
  o:=TDemoClass.Create;
  try
    o.BeforeDestruction;
    o.doDestroy;
  finally
    o.FreeInstance;
  end;
end;

{Destruction "normale" d'un object: si une exception est lev�e dans le destructeur, la m�moire occup�e par
 l'instance (en tout InstanceSize octets, ici au moins 1KB) n'est pas lib�r�e}
procedure TForm1.Button4Click(Sender: TObject);
var
  o:TDemoClass;
begin
  o:=TDemoClass.Create;
  o.Destroy;
end;

end.

