unit Luar.RestApi.Client.Impl;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, IPPeerClient, Vcl.StdCtrls,
  Luar.RestApi.Client.Interfaces, System.JSON, Vcl.ComCtrls, REST.Authenticator.OAuth,
  Web.HTTPApp, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TLuarRestApiClientImpl = class(TInterfacedObject, ILuarRestApiClientInterface)
  Strict private
    fBaseURL:String;
    fResource:String;

    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    procedure CriarObjetosRest;
  public
    function Get: ILuarRestApiClientInterface;
    function Post(pBody: TJSONObject): ILuarRestApiClientInterface;
    function Put(pBody: TJSONObject): ILuarRestApiClientInterface;
    function SetResource(const value:String): ILuarRestApiClientInterface;
    function GetRetorno: TJSONObject;

    constructor create(const pBaseURL:String);
    destructor Destroy; override;

    class function New(const pBaseURL:String):ILuarRestApiClientInterface;

  end;

implementation

{ TLuarRestApiClientImpl }

constructor TLuarRestApiClientImpl.create(const pBaseURL: String);
begin
  fBaseURL := pBaseURL;
  CriarObjetosRest;
end;

procedure TLuarRestApiClientImpl.CriarObjetosRest;
begin
  RESTClient := TRESTClient.create(fBaseURL);
  RESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  RESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  RESTClient.ContentType := 'application/x-www-form-urlencoded';
  RESTClient.HandleRedirects := True;
  RESTClient.RaiseExceptionOn500 := False;

  RESTResponse := TRESTResponse.create(nil);
  RESTResponse.ContentType := 'application/json';

  RESTRequest := TRESTRequest.create(nil);
  RESTRequest.Client := RESTClient;
  RESTRequest.Response := RESTResponse;
  RESTRequest.SynchronizedEvents := False;

  RESTClient.Authenticator := nil;
end;

destructor TLuarRestApiClientImpl.destroy;
begin
  FreeAndNil(RESTClient);
  FreeAndNil(RESTRequest);
  FreeAndNil(RESTResponse);
  inherited;
end;

function TLuarRestApiClientImpl.Get: ILuarRestApiClientInterface;
begin
  Result := Self;
  RESTRequest.Method := rmGET;
  RESTRequest.Resource := fResource;
  RESTRequest.Execute;
end;

function TLuarRestApiClientImpl.GetRetorno: TJSONObject;
begin
  if RESTRequest.Response <> nil then
  begin
    Result := RESTRequest.Response.JSONValue as TJSONObject;
  end
  else
    Result := nil;
end;

class function TLuarRestApiClientImpl.New(
 const pBaseURL: String): ILuarRestApiClientInterface;
begin
  Result := Self.create(pBaseURL);
end;

function TLuarRestApiClientImpl.Post(
  pBody: TJSONObject): ILuarRestApiClientInterface;
begin
  Result := Self;
  RESTRequest.Method := rmPOST;
  RESTRequest.Resource := fResource;
  RESTRequest.ClearBody;
  RESTRequest.AddBody(pBody.ToJSON, ContentTypeFromString('application/json'));
  RESTRequest.Execute;
  GetRetorno;
end;

function TLuarRestApiClientImpl.Put(
  pBody: TJSONObject): ILuarRestApiClientInterface;
begin
  Result := Self;
  RESTRequest.Method := rmPUT;
  RESTRequest.Resource := fResource;
  RESTRequest.ClearBody;
  RESTRequest.AddBody(pBody.ToJSON, ContentTypeFromString('application/json'));
end;

function TLuarRestApiClientImpl.SetResource(
  const value: String): ILuarRestApiClientInterface;
begin
  Result := Self;
  fResource := Value;
end;

end.
