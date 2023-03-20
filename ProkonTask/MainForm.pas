unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtDlgs, Vcl.Grids,
  PRStringGrid;

type
  TfrmMain = class(TForm)
    btnLoad: TButton;
    btnSave: TButton;
    OpenTextFileDialog1: TOpenTextFileDialog;
    PRStringGrid1: TPRStringGrid;
    procedure btnLoadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.btnLoadClick(Sender: TObject);
var
  _file, _tempFile1, _tempFile2 : TextFile;
  _text, _fileName: string;

begin
  if OpenTextFileDialog1.Execute then
    begin
    _fileName := OpenTextFileDialog1.FileName;
    self.PRStringGrid1.LoadFromTextFile(_fileName, ',');
  end;
//    if FileExists(_fileName) then
//      begin
//      AssignFile(_file, _fileName);
//      while Eof(_file) do
//        begin
//        if True then
//      end;
//    end
//    else
//      raise Exception.Create('File does not exist.');
//  end;

end;

end.
