unit PRStringGrid;

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
  System.Generics.Collections,
  CustomCellClasses,
  ColnEdit;

type

  TPRCellsPropertyEditor = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  TPRStringGrid = class(TStringGrid)
    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  private
    { Private declarations }
    FCells : TPRCells;
    FImportHeaderFromFile: boolean;
    procedure SetPRCells(const Value: TPRCells);
    procedure SetImportHeaderFromFile(const Value: boolean);

  protected
    { Protected declarations }
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
  public
    { Public declarations }
    function LoadFromTextFile(AFilePath : string; ASeparatorChar: string;
                              out AErrorMessage: string): boolean;
    function SaveToTextFile(AFilePath : string; ASeparatorChar: string;
                              out AErrorMessage: string): boolean;
  protected

  published
    property PRCells : TPRCells read FCells write SetPRCells;
    property ImportHeaderFromFile : boolean read FImportHeaderFromFile write SetImportHeaderFromFile;
  end;

implementation

uses
  Math,
  IOUtils,
  System.StrUtils;

{ TPRStringGrid }

constructor TPRStringGrid.Create(AOwner: TComponent);
begin
  inherited;
    self.Options := self.Options +
    [goFixedVertLine,
     goFixedHorzLine,
     goVertLine,
     goHorzLine,
     goEditing];
  FCells := TPRCells.Create(self);
  self.FixedCols := 0;
  self.FixedRows := 0;
end;

destructor TPRStringGrid.Destroy;
begin
  FreeAndNil(FCells);
  inherited;
end;

procedure TPRStringGrid.DrawCell(ACol, ARow: Longint; ARect: TRect;
  AState: TGridDrawState);
var
  _cell: TPRCell;
  _text: string;
  i: Integer;

begin
  inherited;
  if FCells.Count > 0 then
    begin
    for i := 0 to FCells.Count -1 do
      begin
      _cell := TPRCell(FCells.Items[i]);
      if (_cell.Y = ACol) and
         (_cell.X = ARow) then
        begin
        _text := self.Cells[ACol, ARow];
        self.Canvas.Brush.Color := _cell.CellColor;
        self.Canvas.FillRect(ARect);
        self.Canvas.Font.Assign(_cell.CellFont);
        self.Canvas.TextRect(ARect, _text);
      end;
    end;
  end;
end;

function TPRStringGrid.LoadFromTextFile(AFilePath: string; ASeparatorChar: string;
                                        out AErrorMessage: string): boolean;
var
  _file : TextFile;
  j: integer;
  _text : string;
  _listOfStrings: TObjectList<TStringList>;
  _splittedText: TStringList;
  _colCount: integer;
  k: Integer;

begin
  try
    AErrorMessage := String.Empty;
    AssignFile(_file, AFilePath);
    Reset(_file);
    _listOfStrings := TObjectList<TStringList>.Create;
    try
      _colCount := 0;
      _splittedText := nil;
      while not Eof(_file) do
        begin
        ReadLn(_file, _text);
        _splittedText := TStringList.Create;
        _splittedText.AddStrings(SplitString(_text, ASeparatorChar));
        _colCount := Max(_colCount, _splittedText.Count);
        _listOfStrings.Add(_splittedText);
      end;
      CloseFile(_file);

      self.RowCount := _listOfStrings.Count;
      self.ColCount := _colCount;

      if FImportHeaderFromFile then
        self.FixedRows := 1;

      for k := 0 to _listOfStrings.Count - 1 do
        for j := 0 to _listOfStrings.Items[k].Count - 1 do
          self.Cells[j, k] := _listOfStrings.Items[k][j];

      result := true;
    Except
      on e: exception do
        begin
        AErrorMessage := e.GetBaseException().Message;
        result := false;
      end;
    end;
  finally
    FreeAndNil(_splittedText);
  end;
end;

function TPRStringGrid.SaveToTextFile(AFilePath, ASeparatorChar: string;
                                      out AErrorMessage: string): boolean;
var
  _text: string;
  _textFile : TextFile;
  I: Integer;
  k: Integer;

begin
  try
    AErrorMessage := String.Empty;
    try
      if not FileExists(AFilePath) then
        FileCreate(AFilePath);

      AssignFile(_textFile, AFilePath);
      ReWrite(_textFile);

      for i := 0 to self.RowCount - 1 do
        begin
        _text := string.Empty;
        for k := 0 to self.ColCount - 1 do
          _text := _text + self.Cells[k,i] + ASeparatorChar;
        WriteLn(_textFile, Copy(_text, 1, _text.Length-1));
      end;

      result := true;
    except
      on e: exception do
        begin
        AErrorMessage := e.GetBaseException.Message;
        result := false;
      end;
    end;

  finally
    CloseFile(_textFile);
  end;
end;

procedure TPRStringGrid.SetImportHeaderFromFile(const Value: boolean);
begin
  FImportHeaderFromFile := Value;
end;

procedure TPRStringGrid.SetPRCells(const Value: TPRCells);
begin
  FCells.Assign(Value);
end;

{ TPRCellsPropertyEditor }

procedure TPRCellsPropertyEditor.Edit;
begin
  ShowCollectionEditor(Designer,
    (GetComponent(0) as TPRStringGrid),
    (GetComponent(0) as TPRStringGrid).PRCells,
    'PRCell');
end;

function TPRCellsPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

end.
