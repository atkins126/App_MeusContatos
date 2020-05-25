program MeusContatos;

uses
  System.StartUpCopy,
  FMX.Forms,
  Contatos.view.principal in 'View\Contatos.view.principal.pas' {FormPrincipal},
  MeusContatos.Model.Configuracao.Interfaces in 'Model\MeusContatos.Model.Configuracao.Interfaces.pas',
  MeusContatos.Model.Configuracao in 'Model\MeusContatos.Model.Configuracao.pas',
  MeusContatos.Model.entidades.Contatos in 'Model\Entidades\MeusContatos.Model.entidades.Contatos.pas',
  MeusContatos.Model.Contatos.Interfaces in 'Model\MeusContatos.Model.Contatos.Interfaces.pas',
  MeusContatos.Model.Contatos in 'Model\MeusContatos.Model.Contatos.pas',
  MeusContatos.Controller.Contatos.Interfaces in 'Controller\MeusContatos.Controller.Contatos.Interfaces.pas',
  MeusContatos.Controller.Contatos in 'Controller\MeusContatos.Controller.Contatos.pas',
  Contatos.view.mensagem in 'View\Contatos.view.mensagem.pas' {FormMsg},
  MeusContatos.Model.ServidorAberto in 'Model\MeusContatos.Model.ServidorAberto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.CreateForm(TFormMsg, FormMsg);
  Application.Run;
end.
