unit MeusContatos.Model.ServidorAberto;

interface

uses
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient;

type
  TFuncoes = class
    public
      class function ServidorAtivo (Porta: integer; Host: string): Boolean;
  end;

implementation

{ TFuncoes }

class function TFuncoes.ServidorAtivo (Porta: integer; Host: string): Boolean;
var
  VCon : TidTCPClient;
begin
  //Result := false;

  vCon :=  TIdTCPClient.create;
  try
    vCon.ReadTimeout := 2000;
    vCon.ConnectTimeout := 2000;
    vCon.Port := Porta;
    vCon.Host := Host;
    try
     vCon.Connect;
     vCon.Disconnect;
     Result := true;
    Except
     Result := false;
    end;
  finally
    vCon.DisposeOf;
  end;
end;

end.
