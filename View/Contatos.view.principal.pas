unit Contatos.view.principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Effects,
  FMX.Objects, FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.TabControl, FMX.Edit, FMX.SearchBox, FMX.ListBox, FMX.MultiView,
  MeusContatos.Model.Configuracao.Interfaces, Data.Bind.Components,
  Data.Bind.ObjectScope, system.math,

  {$ifdef ANDROID}
  AndroidApi.JNI.OS,
  AndroidApi.JNI.GraphicsContentViewText,
  AndroidApi.Helpers,
  AndroidApi.JNIBridge,
  {$endif}
  FMX.Ani;

type
  tOperacao = (tpNovo, tpAlterar, tpExibe, tplista);

type
  TFormPrincipal = class(TForm)
    Estilos: TStyleBook;
    LayoutBarraPrincipal: TLayout;
    BarraPrincipal: TRectangle;
    SobraBarraPrincipal: TShadowEffect;
    BotaoMenu: TButton;
    imgMenu: TPath;
    TabPrincipal: TTabControl;
    TabLista: TTabItem;
    TabExibe: TTabItem;
    TabNovo: TTabItem;
    BotaoNovo: TButton;
    imgAddContato: TPath;
    BotaoEditar: TButton;
    imgEdit: TPath;
    BotaoApagar: TButton;
    imgdelete: TPath;
    BotaoOK: TButton;
    imgOK: TPath;
    BotaoVoltar: TButton;
    imgBack: TPath;
    LabelTitulo: TLabel;
    ListaDeContatos: TListBox;
    CaixaPesquisa: TSearchBox;
    LayoutPrincipal: TLayout;
    MenuPrincipal: TMultiView;
    LayoutSobre: TLayout;
    LabelSobre: TLabel;
    LayoutCofiguracoes: TLayout;
    RecConfigTitle: TRectangle;
    RecConfig1: TRectangle;
    LayoutConfig2: TLayout;
    ShadowEffect1: TShadowEffect;
    LabelConfigTitulo: TLabel;
    LabelServidor: TLabel;
    EdServidor: TEdit;
    LabelPorta: TLabel;
    EdPorta: TEdit;
    LayoutBarraConfig: TLayout;
    BotaoConfigOK: TButton;
    imgOK2: TPath;
    BotaoRefresh: TButton;
    imgRefresh: TPath;
    ImgSobre: TPath;
    LayExibeId: TLayout;
    LabelNome: TLabel;
    LNome: TLabel;
    Layout1: TLayout;
    LabelTelFixo: TLabel;
    LTelefone: TLabel;
    Layout2: TLayout;
    LabelTelCel: TLabel;
    LCelular: TLabel;
    Layout3: TLayout;
    LabelEmail: TLabel;
    Lemail: TLabel;
    Layout4: TLayout;
    Label1: TLabel;
    Layout5: TLayout;
    Label3: TLabel;
    Layout6: TLayout;
    Label5: TLabel;
    Layout7: TLayout;
    Label7: TLabel;
    EdNome: TEdit;
    EdTelefone: TEdit;
    EdCelular: TEdit;
    EdEmail: TEdit;
    LaySplash: TLayout;
    Rectangle1: TRectangle;
    Image1: TImage;
    LayImg: TLayout;
    LayImg2: TLayout;
    Label2: TLabel;
    AniSplash: TFloatAnimation;
    Label4: TLabel;
    AniSplashPre: TFloatAnimation;
    VertScrollBox1: TVertScrollBox;
    LaySec: TLayout;
    LaySemConexao: TLayout;
    LaySemConxao1: TLayout;
    ImgSemConexao: TPath;
    LaySemConexao2: TLayout;
    LabelSemConexao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BotaoNovoClick(Sender: TObject);
    procedure BotaoEditarClick(Sender: TObject);
    procedure BotaoApagarClick(Sender: TObject);
    procedure BotaoVoltarClick(Sender: TObject);
    procedure BotaoConfigOKClick(Sender: TObject);
    procedure BotaoRefreshClick(Sender: TObject);
    procedure ListaDeContatosItemClick(const Sender: TCustomListBox;
      const Item: TListBoxItem);
    procedure BotaoOKClick(Sender: TObject);
    procedure AniSplashFinish(Sender: TObject);
    procedure TabPrincipalChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AniSplashPreFinish(Sender: TObject);
    procedure EdNomeEnter(Sender: TObject);
    procedure FormVirtualKeyboardHidden(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
    procedure EdTelefoneKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdTelefoneChangeTracking(Sender: TObject);
    procedure EdCelularChangeTracking(Sender: TObject);
    procedure EdCelularKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdTelefoneEnter(Sender: TObject);
    procedure EdCelularEnter(Sender: TObject);
    procedure EdEmailEnter(Sender: TObject);
    procedure FormFocusChanged(Sender: TObject);
    procedure FormVirtualKeyboardShown(Sender: TObject;
      KeyboardVisible: Boolean; const Bounds: TRect);
  private
    { Private declarations }
    FOperacao : toperacao;
    FId       : integer;
    FKBBounds: TRectF;
    FNeedOffset: Boolean;
    procedure CalcContentBoundsProc(Sender: TObject;
                                    var ContentBounds: TRectF);
    procedure RestorePosition;
    procedure UpdateKBBounds;
    Procedure Navegacao(Operacao : tOperacao);
  public
    { Public declarations }
    fconfiguracao : iModelConfiguracao;
    Foco : Tcontrol;

  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  MeusContatos.Model.Configuracao, MeusContatos.Controller.Contatos, MeusContatos.Controller.Contatos.Interfaces, system.maskUtils, Contatos.view.mensagem,  MeusContatos.Model.ServidorAberto;

{$R *.fmx}
{$R *.iPhone4in.fmx IOS}
{$R *.Windows.fmx MSWINDOWS}
{$R *.NmXhdpiPh.fmx ANDROID}

Procedure Vibrar (Tempo: integer);
{$IFDEF Android}
var
  Vibrar : JVibrator;
{$ENDIF}
begin
 {$IFDEF ANDROID}
   Vibrar := TJVibrator.Wrap((SharedActivityContext.getSystemService(TJcontext.JavaClass.VIBRATOR_SERVICE) as ILocalObject).GetObjectID);
   Vibrar.vibrate(tempo);
 {$ENDIF}
end;

Procedure MaskText (Const Aedit: TEdit; Const Mask: string);
Var
  LAux: String;
  i: integer;
begin
    if (Aedit.MaxLength <> mask.Length) then
     Aedit.MaxLength := mask.Length;
    LAux := Aedit.Text.Replace('.', '');
    LAux := LAux.Replace('-', '');
    LAux := LAux.Replace('/', '');
    LAux := LAux.Replace('(', '');
    LAux := LAux.Replace(')', '');
    LAux := FormatMaskText(Mask+';0;_', LAux).Trim;
    for  i := LAux.Length-1 downto 0 do
      if not CharInSet(LAux.Chars[i], ['0'..'9']) then
       Delete(LAux, i+1, 1)
      else
       Break;
     TEdit(Aedit).Text := LAux;
     TEdit(Aedit).GoToTextEnd;
     // if not CharInSet(LAux.Chars[i], ['0'..'9']) then
end;

Procedure Ajustar_scroll();
Begin
  With FormPrincipal do
   begin
     LaySec.Height := 90;
     VertScrollBox1.Margins.Bottom := 250;
     VertScrollBox1.ViewportPosition := PointF(VertScrollBox1.ViewportPosition.X, TControl(foco).Position.Y - 90);
   end;
End;

procedure TFormPrincipal.AniSplashFinish(Sender: TObject);
begin
    LaySplash.Visible := False;
end;

procedure TFormPrincipal.AniSplashPreFinish(Sender: TObject);
begin
    AniSplash.Start;
end;

procedure TFormPrincipal.BotaoApagarClick(Sender: TObject);
var FControllerContatos : iControllerContatos;
begin
   Vibrar(1500);
   FormMsg.Confirmar('Exclusão de contato', 'Você clicou em "Excluir Contato". Tem certeza de que deseja apagar este contato?',
    Procedure
      begin
       FControllerContatos := tControllerContatos.New;
       if FControllerContatos.Apagar(FId) = true then
        begin
         FormMsg.SimpleMsg('Contato apagado', 'Contato foi excluído com sucesso.');
         Navegacao(tplista);
         FControllerContatos.Listar;
        end;
      end);
end;

procedure TFormPrincipal.BotaoConfigOKClick(Sender: TObject);
var Resultado : boolean;
begin
   Resultado := fconfiguracao
                          .Servidor(EdServidor.Text)
                          .Porta   (EdPorta.Text)
                          .GravaConfig;
   if Resultado = true then
    begin
     MenuPrincipal.HideMaster;
     FormMsg.SimpleMsg('Configurações salvas', 'As alterações efetuadas nas configurações foram salvas e aplicadas com sucesso.');
    end;
end;

procedure TFormPrincipal.BotaoEditarClick(Sender: TObject);
begin
   EdNome.Text := LNome.Text;
   EdTelefone.Text := LTelefone.Text;
   EdCelular.Text := LCelular.Text;
   EdEmail.Text := Lemail.Text;
   Navegacao(tpAlterar);
end;

procedure TFormPrincipal.BotaoNovoClick(Sender: TObject);
begin
   Navegacao(tpNovo);
end;

procedure TFormPrincipal.BotaoOKClick(Sender: TObject);
var FControllerContatos : iControllerContatos;
begin
    case FOperacao of
      tpNovo:
       begin
         FControllerContatos := tControllerContatos.New.Novo;
         FormMsg.SimpleMsg('Contato cadastrado', 'Contato foi adicionado com sucesso.');
         Navegacao(tplista);
         FControllerContatos := tControllerContatos.New.Listar;
       end;
      tpAlterar:
       begin
         FControllerContatos := tControllerContatos.New.Alterar(FId);
         FormMsg.SimpleMsg('Contato alterado', 'Contato foi alterado com sucesso.');
         Navegacao(tplista);
         FControllerContatos := tControllerContatos.New.Listar;
       end;
      tpExibe: ;
      tplista: ;
    end;

end;

procedure TFormPrincipal.BotaoRefreshClick(Sender: TObject);
var
  iConfig: imodelconfiguracao;
  FControllerContatos : iControllerContatos;
begin
   iConfig := tConfiguracao.New;
    if TFuncoes.ServidorAtivo(strtoint(iConfig.Porta), iConfig.Servidor) = true then
     begin
      CaixaPesquisa.Visible := true;
      LaySemConexao.Visible := false;
      ListaDeContatos.Clear;
      BotaoNovo.Enabled := True;
      FControllerContatos := tControllerContatos.New.Listar;
     end
    else
     begin
       CaixaPesquisa.Visible := false;
       LaySemConexao.Visible := True;
       ListaDeContatos.Clear;
       BotaoNovo.Enabled := false;
     end;
end;

procedure TFormPrincipal.BotaoVoltarClick(Sender: TObject);
begin
    case FOperacao of
     tpNovo    : Navegacao(tplista);
     tpAlterar : Navegacao(tpExibe);
     tpExibe   : Navegacao(tplista);
    end;
end;

procedure TFormPrincipal.CalcContentBoundsProc(Sender: TObject;
  var ContentBounds: TRectF);
begin
  if FNeedOffset and (FKBBounds.Top > 0) then
  begin
    ContentBounds.Bottom := Max(ContentBounds.Bottom,
                                2 * ClientHeight - FKBBounds.Top);
  end;
end;

procedure TFormPrincipal.EdCelularChangeTracking(Sender: TObject);
begin
    {$IFNDEF MSWINDOWS}
      MaskText(sender as Tedit, '(99)99999-9999');
    {$ENDIF}
end;

procedure TFormPrincipal.EdCelularEnter(Sender: TObject);
begin
    {$IFDEF ANDROID}
    // Foco := TControl(TEdit(sender).Parent);
    // Ajustar_scroll;
    {$ENDIF}
end;

procedure TFormPrincipal.EdCelularKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
    {$IFDEF MSWINDOWS}
      MaskText(sender as Tedit, '(99)99999-9999');
    {$ENDIF}
end;

procedure TFormPrincipal.EdEmailEnter(Sender: TObject);
begin
    {$IFDEF ANDROID}
    // Foco := TControl(TEdit(sender).Parent);
    // Ajustar_scroll;
    {$ENDIF}
end;

procedure TFormPrincipal.EdNomeEnter(Sender: TObject);
begin
    {$IFDEF ANDROID}
    // Foco := TControl(TEdit(sender).Parent);
    // Ajustar_scroll;
    {$ENDIF}
end;

procedure TFormPrincipal.EdTelefoneChangeTracking(Sender: TObject);
begin
    {$IFNDEF MSWINDOWS}
      MaskText(sender as Tedit, '(99)9999-9999');
    {$ENDIF}
end;

procedure TFormPrincipal.EdTelefoneEnter(Sender: TObject);
begin
    {$IFDEF ANDROID}
    // Foco := TControl(TEdit(sender).Parent);
    // Ajustar_scroll;
    {$ENDIF}
end;

procedure TFormPrincipal.EdTelefoneKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
    {$IFDEF MSWINDOWS}
      MaskText(sender as Tedit, '(99)9999-9999');
    {$ENDIF}
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
var
  FControllerContatos : iControllerContatos;
begin
    BotaoVoltar.Visible      := false;
    BotaoEditar.Visible      := false;
    BotaoApagar.Visible      := false;
    BotaoOK.Visible          := false;
    BotaoMenu.Visible        := True;
    BotaoNovo.Visible        := true;
    TabPrincipal.TabPosition := TTabPosition.None;
    TabPrincipal.TabIndex    := 0;
    fconfiguracao            := tconfiguracao.New;
    EdServidor.Text          := fconfiguracao.Servidor;
    EdPorta.Text             := fconfiguracao.Porta;
    ReportMemoryLeaksOnShutdown := true;
    fConfiguracao := tConfiguracao.New;
    if TFuncoes.ServidorAtivo(strtoint(fConfiguracao.Porta), fConfiguracao.Servidor) = true then
     begin
      CaixaPesquisa.Visible := true;
      LaySemConexao.Visible := false;
      ListaDeContatos.Clear;
      BotaoNovo.Enabled := true;
      FControllerContatos := tControllerContatos.New.Listar;
     end
    else
     begin
       CaixaPesquisa.Visible := false;
       LaySemConexao.Visible := True;
       ListaDeContatos.Clear;
       BotaoNovo.Enabled := false;
     end;
    VertScrollBox1.OnCalcContentBounds := CalcContentBoundsProc;
end;

procedure TFormPrincipal.FormFocusChanged(Sender: TObject);
begin
    UpdateKBBounds;
end;

procedure TFormPrincipal.FormShow(Sender: TObject);
begin
     AniSplashPre.Start;
     FormMsg.MainLayout := LayoutPrincipal;
end;

procedure TFormPrincipal.FormVirtualKeyboardHidden(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
   // VertScrollBox1.Margins.Bottom := 0;
   // LaySec.Height := 50;
  FKBBounds.Create(0, 0, 0, 0);
  FNeedOffset := False;
  RestorePosition;
end;

procedure TFormPrincipal.FormVirtualKeyboardShown(Sender: TObject;
  KeyboardVisible: Boolean; const Bounds: TRect);
begin
  FKBBounds := TRectF.Create(Bounds);
  FKBBounds.TopLeft := ScreenToClient(FKBBounds.TopLeft);
  FKBBounds.BottomRight := ScreenToClient(FKBBounds.BottomRight);
  UpdateKBBounds;
end;

Procedure TFormPrincipal.ListaDeContatosItemClick(const Sender: TCustomListBox;
  const Item: TListBoxItem);
var FControllerContatos : iControllerContatos;
begin
    FId := Item.Tag;
    //ShowMessage(inttostr(fid));
    FControllerContatos := tControllerContatos.New.Contato(Fid);
    Navegacao(tpExibe);
    ListaDeContatos.ItemIndex := -1;
end;

procedure TFormPrincipal.Navegacao(Operacao: tOperacao);
begin
    FOperacao := operacao;
    case FOperacao of
      tpNovo:
       begin
           BotaoVoltar.Visible      := true;
           BotaoEditar.Visible      := false;
           BotaoApagar.Visible      := false;
           BotaoOK.Visible          := true;
           BotaoMenu.Visible        := false;
           BotaoNovo.Visible        := false;
           BotaoRefresh.Visible     := false;
           EdNome.Text := '';
           EdTelefone.Text := '';
           EdCelular.Text := '';
           EdEmail.Text := '';
           tabPrincipal.GotoVisibleTab(2);
           EdNome.SetFocus;
       end;
      tpAlterar:
       begin
           BotaoVoltar.Visible      := true;
           BotaoEditar.Visible      := false;
           BotaoApagar.Visible      := false;
           BotaoOK.Visible          := true;
           BotaoMenu.Visible        := false;
           BotaoNovo.Visible        := false;
           BotaoRefresh.Visible     := false;
           tabPrincipal.GotoVisibleTab(2);
       end;
      tpExibe:
       begin
           BotaoVoltar.Visible      := true;
           BotaoEditar.Visible      := true;
           BotaoApagar.Visible      := true;
           BotaoOK.Visible          := false;
           BotaoMenu.Visible        := false;
           BotaoNovo.Visible        := false;
           BotaoRefresh.Visible     := false;
           tabPrincipal.GotoVisibleTab(1);
       end;
      tplista:
       begin
           BotaoVoltar.Visible      := false;
           BotaoEditar.Visible      := false;
           BotaoApagar.Visible      := false;
           BotaoOK.Visible          := false;
           BotaoMenu.Visible        := True;
           BotaoNovo.Visible        := true;
           BotaoRefresh.Visible     := True;
           tabPrincipal.GotoVisibleTab(0);
       end;
    end;
end;

procedure TFormPrincipal.RestorePosition;
begin
  VertScrollBox1.ViewportPosition := PointF(VertScrollBox1.ViewportPosition.X, 0);
  // MainLayout1.Align := TAlignLayout.Client;
  VertScrollBox1.RealignContent;
end;

procedure TFormPrincipal.TabPrincipalChange(Sender: TObject);
begin
    if TabPrincipal.ActiveTab <> TabLista then
     MenuPrincipal.DrawerOptions.TouchAreaSize := -1
    else
     MenuPrincipal.DrawerOptions.TouchAreaSize := 20;
end;

procedure TFormPrincipal.UpdateKBBounds;
var
  LFocused : TControl;
  LFocusRect: TRectF;
begin
  FNeedOffset := False;
  if Assigned(Focused) then
  begin
    LFocused := TControl(Focused.GetObject);
    LFocusRect := LFocused.AbsoluteRect;
    LFocusRect.Offset(VertScrollBox1.ViewportPosition);
    if (LFocusRect.IntersectsWith(TRectF.Create(FKBBounds))) and
       (LFocusRect.Bottom > FKBBounds.Top) then
    begin
      FNeedOffset := True;
      // MainLayout1.Align := TAlignLayout.Horizontal;
      VertScrollBox1.RealignContent;
      Application.ProcessMessages;
      VertScrollBox1.ViewportPosition :=
        PointF(VertScrollBox1.ViewportPosition.X,
               LFocusRect.Bottom - FKBBounds.Top);
    end;
  end;
  if not FNeedOffset then
    RestorePosition;

end;

end.
