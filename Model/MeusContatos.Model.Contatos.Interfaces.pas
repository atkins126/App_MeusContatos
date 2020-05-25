unit MeusContatos.Model.Contatos.Interfaces;

interface

uses data.db, MeusContatos.Model.entidades.Contatos;

type

 iModelContatos = interface
   ['{AFD0A1AD-8EFC-40D2-9348-A4AF8E2D77E5}']
   Function ListaContatos : string;
   Function Contato (Aid: Integer) : tcontatos;
   function Inserir (Contato : Tcontatos) : boolean;
   Function Alterar (Contato : Tcontatos) : boolean;
   Function Deletar (Aid: integer) : Boolean;
 end;

implementation

end.
