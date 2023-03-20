object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Prokon task'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object btnLoad: TButton
    Left = 8
    Top = 8
    Width = 121
    Height = 25
    Caption = 'Load'
    TabOrder = 0
    OnClick = btnLoadClick
  end
  object btnSave: TButton
    Left = 135
    Top = 8
    Width = 121
    Height = 25
    Caption = 'Save'
    TabOrder = 1
  end
  object PRStringGrid1: TPRStringGrid
    Left = 168
    Top = 144
    Width = 320
    Height = 120
    TabOrder = 2
    PRCell.Y = 0
    PRCell.X = 0
    PRCell.CellColor = clWhite
    PRCell.CellFont.Charset = DEFAULT_CHARSET
    PRCell.CellFont.Color = clWindowText
    PRCell.CellFont.Height = -12
    PRCell.CellFont.Name = 'Segoe UI'
    PRCell.CellFont.Style = []
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Left = 536
    Top = 16
  end
end
