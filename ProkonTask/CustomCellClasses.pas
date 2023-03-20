unit CustomCellClasses;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  Vcl.Grids,
  Vcl.Graphics,
  DesignIntf,
  DesignEditors,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.Dialogs,
  System.Types,
  System.Generics.Collections;

type

  TPRCell = class(TCollectionItem)
    private
      FColor : TColor;
      FY : integer;
      FX : integer;
      FFont: TFont;
      procedure SetFont(const Value: TFont);
      function GetFont: TFont;

    public
      constructor Create(AOwner: TCollection); override;
      destructor Destroy(); override;
      procedure FontChanged(Sender: TObject);

    published
      property Y : integer read FY write FY;
      property X : integer read FX write FX;
      property CellColor : TColor read FColor write FColor;
      property CellFont : TFont read GetFont write SetFont;
  end;

  TPRCells = class(TCollection)
  private
    FOwner: TComponent;
  public
    constructor Create (AOwner: TComponent);
    function GetOwner: TPersistent; override;
  end;

implementation

{ TPRCells }

constructor TPRCells.Create(AOwner: TComponent);
begin
  inherited Create(TPRCell);
  FOwner := AOwner;
end;

function TPRCells.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

{ TPRCell }

constructor TPRCell.Create(AOwner: TCollection);
begin
  inherited Create(AOwner);
  FFont := TFont.Create;
  FFont.Color := clBlack;
  FFont.Name := 'Segoe UI';
  FFont.Charset := 0;
  FFont.Size := 9;
  FFont.OnChange := FontChanged;
end;

destructor TPRCell.Destroy;
begin
  FreeAndNil(FFont);
  inherited;
end;

procedure TPRCell.FontChanged(Sender: TObject);
begin
  (self.Collection.Owner as TStringGrid).Invalidate;
end;

function TPRCell.GetFont: TFont;
begin
  result := self.FFont;
end;

procedure TPRCell.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

end.
