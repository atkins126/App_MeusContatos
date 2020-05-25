unit MeusContatos.Model.Contatos;

interface

uses
  MeusContatos.Model.Contatos.Interfaces, Rest.client,  IPPeerClient, Data.DB,
  MeusContatos.Model.entidades.Contatos, Rest.response.adapter;

Type
  TModelContatos = Class(TInterfacedObject, iModelContatos)
    Private
     FRestClient : trestclient;
     FRestResponse : trestresponse;
     FRestRequest : TRESTRequest;
     FRespAdapter : TRESTResponseDataSetAdapter;
    Public
     Constructor Create;
     Destructor Destroy; Override;
     Class function New: iModelContatos;
     Function ListaContatos : string;
     Function Contato (Aid: Integer) : tcontatos;
     function Inserir (Contato : Tcontatos) : boolean;
     Function Alterar (Contato : Tcontatos) : boolean;
     Function Deletar (Aid: integer) : Boolean;
  End;

implementation

uses
  MeusContatos.Model.Configuracao.Interfaces, MeusContatos.Model.Configuracao,
  REST.Types, Firedac.comp.client, System.SysUtils, Rest.json, System.JSON;

{ TModelContatos }

function TModelContatos.Alterar(Contato: Tcontatos): boolean;
Var Conteudo : string;
begin
  FRestRequest.Method := tRestRequestMethod.rmPUT;
  FRestRequest.Resource := 'contatos';
  Conteudo := TJson.ObjectToJsonString(Contato);
  FRestRequest.body.Add('['+Conteudo+']', ctAPPLICATION_JSON);
  FRestRequest.Execute;
end;

function TModelContatos.Contato(Aid: Integer): tcontatos;
var jarray : tjsonarray;
    i: integer;
    Contato : Tcontatos;
begin
  FRestRequest.Method := tRestRequestMethod.rmGET;
  FRestRequest.Resource := 'contato/'+inttostr(aid);
  FRestRequest.Execute;
   JArray := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(FRestResponse.content), 0) as TJSONArray;
   Contato:= Tcontatos.Create;
   for I := 0 to JArray.Count-1 do
    begin
      contato.nome := JArray.Items[i].GetValue<string>('nome');
      contato.id  := JArray.Items[i].GetValue<integer>('id');
      contato.fixo  := JArray.Items[i].GetValue<string>('telefone');
      contato.Celular  := JArray.Items[i].GetValue<string>('celular');
      contato.Email  := JArray.Items[i].GetValue<string>('email');
    end;
    jarray.DisposeOf;
    Result := Contato;
end;

constructor TModelContatos.Create;
Var Servidor, Porta : string;
    iConfig: imodelconfiguracao;
begin
     iconfig := tconfiguracao.New;
     Servidor := iConfig.Servidor;
     Porta := iConfig.Porta;
     FRestClient := trestclient.Create('http://'+servidor+':'+Porta+'/desk/v1/main');
     FRestResponse := trestresponse.Create(nil);
     FRestRequest := TRESTRequest.Create(Nil);
     FrestRequest.Response := FRestResponse;
     FRestRequest.Client  := FRestClient;
end;

function TModelContatos.Deletar(Aid: integer): Boolean;
begin
  FRestRequest.Method := tRestRequestMethod.rmDELETE;
  FRestRequest.Resource := 'contatos/'+inttostr(aid);
  FRestRequest.Execute;
  Result := (FRestResponse.StatusCode = 200);
end;

destructor TModelContatos.Destroy;
begin
     FRestRequest.DisposeOf;
     FRestResponse.DisposeOf;
     FRestClient.DisposeOf;
  inherited;
end;

function TModelContatos.Inserir(Contato: Tcontatos): boolean;
Var Conteudo : string;
begin
    FRestRequest.Method := tRestRequestMethod.rmPost;
    FRestRequest.Resource := 'contatos';
    Conteudo := TJson.ObjectToJsonString(Contato);
    FRestRequest.body.Add('['+Conteudo+']', ctAPPLICATION_JSON);
    FRestRequest.Execute;
    Result := (FRestResponse.StatusCode = 200);
end;

function TModelContatos.ListaContatos : string;
begin
  FRestRequest.Method := tRestRequestMethod.rmGET;
  FRestRequest.Resource := 'contatos';
  FRestRequest.Execute;
  Result := FRestResponse.Content;
end;

class function TModelContatos.New: iModelContatos;
begin
    Result := Self.Create;
end;

end.
