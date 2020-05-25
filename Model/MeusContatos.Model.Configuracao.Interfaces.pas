unit MeusContatos.Model.Configuracao.Interfaces;

interface

type

 iModelConfiguracao = interface
   ['{E4E35ED9-16AB-49F0-9475-61AEA73E9B55}']
   Function Servidor : String; overload;
   Function Servidor (valor: string) : iModelconfiguracao; overload;
   Function Porta : String; overload;
   Function Porta (valor: string) : iModelconfiguracao; overload;
   Function GravaConfig : boolean;
 end;

implementation

end.
