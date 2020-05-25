unit Contatos.view.Mensagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Effects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Ani;

type
  TFormMsg = class(TForm)
    Estilos: TStyleBook;
    LayMsg: TLayout;
    Sombra: TRectangle;
    CaixaDlg: TRectangle;
    EfeitoSombra: TShadowEffect;
    LayTitulo: TLayout;
    LayMensagem: TLayout;
    LayBotoes: TLayout;
    BtNao: TSpeedButton;
    BtSim: TSpeedButton;
    Titulo: TLabel;
    Mensagem: TLabel;
    Linha_titulo: TLine;
    Line1: TLine;
    AbreMsg: TFloatAnimation;
    FechaMsgNao: TFloatAnimation;
    FechaMsgSim: TFloatAnimation;
    procedure BtNaoClick(Sender: TObject);
    procedure BtSimClick(Sender: TObject);
    procedure SombraClick(Sender: TObject);
    procedure FechaMsgNaoFinish(Sender: TObject);
    procedure FechaMsgSimFinish(Sender: TObject);
  private
    FMainLayout: tlayout;
    FPYes: tproc;
    { Private declarations }
  public
    { Public declarations }
    Property MainLayout : tlayout Read FMainLayout write FMainLayout;
    Procedure Confirmar (Title, Text : string; PYes : tProc);
    Procedure SimpleMsg (Title, Text : string);
  end;


var
  FormMsg: TFormMsg;

implementation

{$R *.fmx}

procedure TFormMsg.BtNaoClick(Sender: TObject);
begin
    FechaMsgNao.Start;
end;

procedure TFormMsg.BtSimClick(Sender: TObject);
begin
    FechaMsgSim.Start;
end;

procedure TFormMsg.Confirmar(Title, Text: string; PYes: tProc);
begin
   LayMsg.Opacity := 0;
   Titulo.Text := Title;
   Mensagem.Text := Text;
   FPYes := pyes;
   BtNao.Text := 'Não';
   BtNao.Visible := True;
   BtSim.Text := 'Sim';
   BtSim.Visible := true;
   LayMsg.Parent := FMainLayout;
   AbreMsg.Start;
end;

procedure TFormMsg.FechaMsgNaoFinish(Sender: TObject);
begin
    LayMsg.Parent := nil;
end;

procedure TFormMsg.FechaMsgSimFinish(Sender: TObject);
begin
    LayMsg.Parent := nil;
    FPYes;
end;

procedure TFormMsg.SimpleMsg(Title, Text: string);
begin
   LayMsg.Opacity := 0;
   Titulo.Text := Title;
   Mensagem.Text := Text;
   BtNao.Text := 'OK';
   BtNao.Visible := True;
   BtSim.Text := 'Sim';
   BtSim.Visible := false;
   LayMsg.Parent := FMainLayout;
   AbreMsg.Start;
end;

procedure TFormMsg.SombraClick(Sender: TObject);
begin
    FechaMsgnao.Start;
end;

end.
