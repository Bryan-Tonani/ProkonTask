unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, PRStringGrid, Vcl.StdCtrls,
  Vcl.ExtDlgs, Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    GridPanel1: TGridPanel;
    btnLoad: TButton;
    btnSave: TButton;
    OpenTextFileDialog1: TOpenTextFileDialog;
    SaveTextFileDialog1: TSaveTextFileDialog;
    PRStringGrid1: TPRStringGrid;
    PRStringGrid2: TPRStringGrid;
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses
  Math;

{$R *.dfm}

procedure TMainForm.btnLoadClick(Sender: TObject);
var
  _error,
  _fileName: string;
  _textFile : TextFile;
  _stringList: TStringList;
  _copy: boolean;
  I: Integer;

begin
  try
    _stringList := TStringList.Create;
    if OpenTextFileDialog1.Execute() then
      begin
      _stringList.LoadFromFile(OpenTextFileDialog1.FileName);
      _copy := false;
      for I := 0 to _stringList.Count -1 do
        begin
        if CompareStr(_stringList[i], '__FILE1__') = 0 then
          begin
          _copy := true;
          _fileName := ExpandFileName(ExtractFileDir(Application.ExeName)) + 'Temp_FILE1.txt';
          AssignFile(_textFile, _fileName);
          Rewrite(_textFile);
          continue;
        end;
        if CompareStr(_stringList[i], '__ENDFILE1__') = 0 then
          begin
          _copy := false;
          CloseFile(_textFile);
          if not self.PRStringGrid1.LoadFromTextFile(_fileName, ',', _error) then
            ShowMessage('Error loading file: ' + _error);
          continue;
        end;
        if CompareStr(_stringList[i], '__FILE2__') = 0 then
          begin
          _copy := true;
          _fileName := ExpandFileName(ExtractFileDir(Application.ExeName)) + 'Temp_FILE2.txt';
          AssignFile(_textFile, _fileName);
          Rewrite(_textFile);
          continue;
        end;
        if CompareStr(_stringList[i], '__ENDFILE2__') = 0 then
          begin
          _copy := false;
          CloseFile(_textFile);
          if not self.PRStringGrid2.LoadFromTextFile(_fileName, ',', _error) then
            ShowMessage('Error loading file: ' + _error);
          continue;
        end;
        if _copy then
          WriteLn(_textFile, _stringList[i]);
      end;
  end;
  finally
    FreeAndNil(_stringList);
  end;
end;

procedure TMainForm.btnSaveClick(Sender: TObject);
var
  _text,
  _error: string;
  _tempFile,
  _textFile : TextFile;
  _buf: array[0..MAX_PATH] of char;
  _temp: array[0..MAX_PATH] of char;

begin
  try
    if SaveTextFileDialog1.Execute() then
      begin
      AssignFile(_textFile, SaveTextFileDialog1.FileName);
      ReWrite(_textFile);

      GetTempPath(MAX_PATH, _buf);
      if GetTempFilename(_buf, 'prTemp_', 0, _temp) = 0 then
        raise Exception.CreateFmt('Win32 Error %d: %s', [GetLastError,
          SysErrorMessage(GetLastError)]);

      if not PRStringGrid1.SaveToTextFile(_temp, ',', _error) then
        ShowMessage('Error saving file from grid 1: ' + _error);

      AssignFile(_tempFile, _temp);
      Reset(_tempFile);
      WriteLn(_textFile, '__FILE1__');
      while not Eof(_tempFile) do
        begin
        ReadLn(_tempFile, _text);
        WriteLn(_textFile, _text);
      end;
      WriteLn(_textFile, '__ENDFILE1__');

      GetTempPath(MAX_PATH, _buf);
      if GetTempFilename(_buf, 'prTemp_', 0, _temp) = 0 then
        raise Exception.CreateFmt('Win32 Error %d: %s', [GetLastError,
          SysErrorMessage(GetLastError)]);

      if not PRStringGrid2.SaveToTextFile(_temp, ',', _error) then
        ShowMessage('Error saving file from grid 2: ' + _error);

      AssignFile(_tempFile, _temp);
      Reset(_tempFile);
      WriteLn(_textFile, '__FILE2__');
      while not Eof(_tempFile) do
        begin
        ReadLn(_tempFile, _text);
        WriteLn(_textFile, _text);
      end;
      WriteLn(_textFile, '__ENDFILE2__');
  end;
  finally
    CloseFile(_tempFile);
    CloseFile(_textFile);
  end;
end;

end.
