unit Luar.Utils.FTP.Interfaces;

interface

uses AtualizarVersao.Eventos, System.Classes;

type
  ILuarUtilsFTPInterfaces = interface
    ['{9F7B6ECB-E9B0-4CF7-9BCC-6D0B2275921A}']
    function Conectar: ILuarUtilsFTPInterfaces;
    function BaixarArquivo(const pOrigem, pDestino:String): ILuarUtilsFTPInterfaces;
    function BaixarDaPasta(const pPasta, pPastaDestino:String): ILuarUtilsFTPInterfaces;
    function SetStatus(Value: TevStatus):ILuarUtilsFTPInterfaces;
    function GetListaArquivos: TStringList;
  end;

implementation

end.
