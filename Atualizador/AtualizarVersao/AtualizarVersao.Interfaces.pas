unit AtualizarVersao.Interfaces;

interface

uses AtualizarVersao.Eventos;

type
  IAtualizarVersaoInterfaces = interface
    ['{C2F90CB9-0A6A-4B0F-9847-EC04FDB771EF}']
    function AtualizarVersao: IAtualizarVersaoInterfaces;
    function ClienteAtualizado: Boolean;
    function SetStatus(Value: TevStatus):IAtualizarVersaoInterfaces;
    function GravarErro(Value: String): IAtualizarVersaoInterfaces;
    function GravarLog(Value: String): IAtualizarVersaoInterfaces;
  end;

var
  oAtualizarVersaoFacade: IAtualizarVersaoInterfaces;

implementation

end.
