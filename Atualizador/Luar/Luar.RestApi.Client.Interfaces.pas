unit Luar.RestApi.Client.Interfaces;

interface

uses
  System.JSON;

type
  ILuarRestApiClientInterface = interface
    ['{E2092639-6264-4027-B4A3-E2AC8EEFED1B}']
    function Get: ILuarRestApiClientInterface;
    function Post(pBody: TJSONObject): ILuarRestApiClientInterface;
    function Put(pBody: TJSONObject): ILuarRestApiClientInterface;
    function SetResource(const value:String): ILuarRestApiClientInterface;
    function GetRetorno: TJSONObject;
  end;

implementation

end.
