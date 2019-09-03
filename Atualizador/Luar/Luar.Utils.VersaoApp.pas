unit Luar.Utils.VersaoApp;

interface

uses Winapi.Windows, System.SysUtils;

type
  TLuarUtilsVersaoApp = class
  public
    class function GetVersao(const pPathApp:String):String;
  end;

implementation

{ TLuarUtilsVersaoApp }

class function TLuarUtilsVersaoApp.GetVersao(const pPathApp: String): String;
var
 VerInfoSize: DWORD;
 VerInfo: Pointer;
 VerValueSize: DWORD;
 VerValue: PVSFixedFileInfo;
 Dummy: DWORD;
 V1, V2, V3, V4: Word;
begin
 try
   VerInfoSize := GetFileVersionInfoSize(PChar(pPathApp), Dummy);
   GetMem(VerInfo, VerInfoSize);
   GetFileVersionInfo(PChar(pPathApp), 0, VerInfoSize, VerInfo);
   VerQueryValue(VerInfo, '', Pointer(VerValue), VerValueSize);
   with (VerValue^) do
   begin
     V1 := dwFileVersionMS shr 16;
     V2 := dwFileVersionMS and $FFFF;
     V3 := dwFileVersionLS shr 16;
     V4 := dwFileVersionLS and $FFFF;
   end;
   FreeMem(VerInfo, VerInfoSize);
   Result := Format('%d.%d.%d.%d', [v1, v2, v3, v4]);
 except
   Result := '1.0.0';
 end;
end;

end.
