unit MeusContatos.Model.Configuracao;

interface

uses
  MeusContatos.Model.Configuracao.Interfaces;

Type
  TConfiguracao = Class(TInterfacedObject, iModelConfiguracao)
    Private
     class var Fconfig   : tconfiguracao;
     FServidor : string;
     FPorta    : string;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iModelConfiguracao;
     Function Servidor : String; overload;
     Function Servidor (valor: string) : iModelconfiguracao; overload;
     Function Porta : String; overload;
     Function Porta (valor: string) : iModelconfiguracao; overload;
     Function GravaConfig : boolean;
  End;

implementation

{ TConfiguracao }

Uses inifiles, System.SysUtils, System.IOUtils;

constructor TConfiguracao.Create;
var Cfg : tinifile;
    arq : string;
begin
  arq       := TPath.GetDocumentsPath + '\configMeusContatos.ini';
  Cfg       := TIniFile.Create(arq);
  FServidor := Cfg.ReadString('Configuracao', 'Servidor', '192.168.0.15');
  Fporta    := Cfg.ReadString('Configuracao', 'Porta', '8080');
  Cfg.DisposeOf;
end;

destructor TConfiguracao.Destroy;
begin

  inherited;
end;

function TConfiguracao.GravaConfig: boolean;
var Cfg : tinifile;
    arq : string;
begin
  Result := false;
  arq       := TPath.GetDocumentsPath + '\configMeusContatos.ini';
  Cfg       := TIniFile.Create(arq);
  Cfg.WriteString('Configuracao', 'Servidor', FServidor);
  Cfg.WriteString('Configuracao', 'Porta', Fporta);
  cfg.DisposeOf;
  Result := true;
end;

class function TConfiguracao.New: iModelConfiguracao;
begin
   if not assigned(fconfig) then
    Fconfig := self.Create;
   Result := fconfig;
end;

function TConfiguracao.Porta: String;
begin
   Result := FPorta;
end;

function TConfiguracao.Porta(valor: string): iModelconfiguracao;
begin
   Result := Self;
   FPorta := valor;
end;

function TConfiguracao.Servidor(valor: string): iModelconfiguracao;
begin
   Result := Self;
   FServidor := valor;
end;

function TConfiguracao.Servidor: String;
begin
    Result := FServidor;
end;

end.
