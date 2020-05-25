unit Contatos.view.Interfaces;

interface

Uses Fmx.layouts, System.SysUtils;

Type

 iViewMensagem = Interface
   ['{9D9E5E3C-9817-4E41-BD70-3B8C1F4F34F8}']
   Function GetLayout (Layout : TLayout) : iViewMensagem;
   Function Confirmar (Title, Text : string; PYes : TProc) : iViewMensagem;
   Function SimpleMsg (Title, Text : string) : iViewMensagem;
 End;

implementation

end.
