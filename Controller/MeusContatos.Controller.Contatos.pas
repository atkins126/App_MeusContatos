unit MeusContatos.Controller.Contatos;

interface

uses
  MeusContatos.Controller.Contatos.Interfaces;

Type
  TControllerContatos = Class(TInterfacedObject, iControllerContatos)
    Private
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iControllerContatos;
     Function Listar : icontrollerContatos;
     Function Contato (Aid: integer) : icontrollerContatos;
     Function Novo : icontrollercontatos;
     Function Alterar (Aid: integer) : icontrollerContatos;
     Function Apagar (Aid: integer) : Boolean;
  End;

implementation

uses
  MeusContatos.Model.Contatos, FMX.ListBox, Data.DB, Contatos.view.principal, MeusContatos.Model.Contatos.Interfaces,
  System.JSON, System.SysUtils, MeusContatos.Model.entidades.Contatos,
  FMX.Dialogs, system.generics.Collections;

{ TControllerContatos }

function TControllerContatos.Alterar(Aid: integer): icontrollerContatos;
Var Contato : tcontatos;
    iContatos : iModelContatos;
begin
   Result := Self;
   iContatos := TModelContatos.New;
   Contato := Tcontatos.Create;
   Contato.id := Aid;
   Contato.nome := FormPrincipal.EdNome.Text;
   Contato.fixo := FormPrincipal.EdTelefone.Text;
   Contato.Celular := FormPrincipal.EdCelular.Text;
   Contato.Email := FormPrincipal.EdEmail.Text;
   iContatos.Alterar(contato);
   Contato.free;
end;

function TControllerContatos.Apagar(Aid: integer): Boolean;
var
    Contato : Boolean;
    iContatos : iModelContatos;
begin
   iContatos := TModelContatos.New;
   Contato := iContatos.Deletar(Aid);
   Result := contato;
end;

function TControllerContatos.Contato(Aid: integer): icontrollerContatos;
Var Contato : tcontatos;
    iContatos : iModelContatos;
begin
   Result := Self;
   iContatos := TModelContatos.New;
   //Contato := Tcontatos.Create;
   Contato := iContatos.Contato(Aid);
   FormPrincipal.LNome.Text := Contato.nome;
   FormPrincipal.LTelefone.Text := Contato.fixo;
   FormPrincipal.LCelular.Text  := Contato.Celular;
   FormPrincipal.Lemail.Text    := Contato.Email;
   Contato.DisposeOf;
end;

constructor TControllerContatos.Create;
begin

end;

destructor TControllerContatos.Destroy;
begin

  inherited;
end;

function TControllerContatos.Listar: icontrollerContatos;
var Item : tlistboxitem;
    Data : string;
    JArray : tjsonarray;
    i : integer;
begin
   Result := self;
   FormPrincipal.ListaDeContatos.Items.Clear;
   data := TModelContatos.New.ListaContatos;
   JArray := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Data), 0) as TJSONArray;
   for I := 0 to JArray.Count-1 do
    begin
      Item := TListBoxItem.Create(nil);
      Item.Text := JArray.Items[i].GetValue<string>('Nome');
      Item.Tag  := JArray.Items[i].GetValue<integer>('Id');
      formprincipal.ListaDeContatos.AddObject(item);
    end;
    jarray.DisposeOf;
end;

class function TControllerContatos.New: iControllerContatos;
begin
   Result := self.create;
end;

function TControllerContatos.Novo: icontrollercontatos;
Var Contato : tcontatos;
    iContatos : iModelContatos;
begin
   Result := Self;
   iContatos := TModelContatos.New;
   Contato := Tcontatos.Create;
   Contato.nome := FormPrincipal.EdNome.Text;
   Contato.fixo := FormPrincipal.EdTelefone.Text;
   Contato.Celular := FormPrincipal.EdCelular.Text;
   Contato.Email := FormPrincipal.EdEmail.Text;
   iContatos.Inserir(contato);
   Contato.free;
end;

end.
