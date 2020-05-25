unit MeusContatos.Controller.Contatos.Interfaces;

interface

type

 iControllerContatos = interface
   ['{A20F2DDF-FF3F-474B-A747-DC0E35ED64E0}']
   Function Listar : icontrollerContatos;
   Function Contato (Aid: integer) : icontrollerContatos;
   Function Novo : icontrollercontatos;
   Function Alterar (Aid: integer) : icontrollerContatos;
   Function Apagar (Aid: integer) : Boolean;
 end;

implementation

end.
