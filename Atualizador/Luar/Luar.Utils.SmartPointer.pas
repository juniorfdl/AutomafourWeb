unit Luar.Utils.SmartPointer;

interface

uses dbclient;

type
  TevSmartPointer = procedure(Value: TObject) of object;

  TSmartPointer<T : class, constructor> = record
  strict private
    FonBeforeFree: TevSmartPointer;
    FValue: T;
    FFreeTheValue: IInterface;
    function GetValue: T;
  private
    procedure SetonBeforeFree(const Value: TevSmartPointer);
  public
    constructor Create(pValue: T); overload;
    property Value: T read GetValue;

    property onBeforeFree: TevSmartPointer read FonBeforeFree write SetonBeforeFree;

    class operator Implicit(pSmart: TSmartPointer<t>): T;
    class operator Implicit(pValue: T): TSmartPointer<T>;
  end;

  TFreeTheValue = class(TInterfacedObject)
  strict private
    FonBeforeFree: TevSmartPointer;
  private
    fObjectToFree: TObject;
  public
    constructor Create(pObjectToFree: TObject);
    destructor Destroy; override;

    property onBeforeFree: TevSmartPointer read FonBeforeFree write FonBeforeFree;
  end;

implementation

uses
  System.Classes;

{ SmartPointer<T> }

constructor TSmartPointer<T>.Create(pValue: T);
begin
  FValue := pValue;
  FFreeTheValue := TFreeTheValue.Create(FValue);
end;

function TSmartPointer<T>.GetValue: T;
begin
  if not Assigned(FFreeTheValue) then
  begin
    if TClass(T).InheritsFrom(TComponent) then
      Self := TSmartPointer<T>.Create(TComponentClass(T).Create(nil))
    else
      Self := TSmartPointer<T>.Create(T.Create);
  end;

  Result := FValue;
end;

class operator TSmartPointer<T>.Implicit(pSmart: TSmartPointer<t>): T;
begin
  Result := pSmart.Value;
end;

class operator TSmartPointer<T>.Implicit(pValue: T): TSmartPointer<T>;
begin
  Result := TSmartPointer<T>.Create(pValue);
end;

procedure TSmartPointer<T>.SetonBeforeFree(const Value: TevSmartPointer);
begin
  FonBeforeFree := Value;
  TFreeTheValue(FFreeTheValue).onBeforeFree := FonBeforeFree;
end;

{ TFreeTheValue }

constructor TFreeTheValue.Create(pObjectToFree: TObject);
begin
  fObjectToFree := pObjectToFree;
end;

destructor TFreeTheValue.Destroy;
begin
  if Assigned(FonBeforeFree) then
    FonBeforeFree(fObjectToFree);

  fObjectToFree.DisposeOf;
  inherited;
end;

end.
