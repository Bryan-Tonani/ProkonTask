object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Prokon test form'
  ClientHeight = 250
  ClientWidth = 741
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object GridPanel1: TGridPanel
    Left = 0
    Top = 8
    Width = 741
    Height = 239
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColumnCollection = <
      item
        Value = 50.000000000000000000
      end
      item
        Value = 50.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = btnLoad
        Row = 0
      end
      item
        Column = 1
        Control = btnSave
        Row = 0
      end
      item
        Column = 0
        Control = PRStringGrid1
        Row = 1
      end
      item
        Column = 1
        Control = PRStringGrid2
        Row = 1
      end>
    Padding.Left = 5
    Padding.Top = 5
    Padding.Right = 5
    Padding.Bottom = 5
    RowCollection = <
      item
        Value = 22.942643391521190000
      end
      item
        Value = 77.057356608478800000
      end
      item
        SizeStyle = ssAuto
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 0
    object btnLoad: TButton
      Left = 11
      Top = 11
      Width = 354
      Height = 42
      Align = alClient
      Caption = 'Load'
      TabOrder = 0
      OnClick = btnLoadClick
    end
    object btnSave: TButton
      Left = 375
      Top = 11
      Width = 355
      Height = 42
      Align = alClient
      Caption = 'Save'
      TabOrder = 1
      OnClick = btnSaveClick
    end
    object PRStringGrid1: TPRStringGrid
      Left = 11
      Top = 63
      Width = 354
      Height = 165
      Align = alClient
      FixedCols = 0
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goFixedRowDefAlign]
      TabOrder = 2
      PRCells = <
        item
          Y = 1
          X = 2
          CellColor = clLime
          CellFont.Charset = ANSI_CHARSET
          CellFont.Color = clBlack
          CellFont.Height = -16
          CellFont.Name = 'Algerian'
          CellFont.Style = [fsItalic]
        end>
      ImportHeaderFromFile = True
    end
    object PRStringGrid2: TPRStringGrid
      Left = 375
      Top = 63
      Width = 355
      Height = 165
      Align = alClient
      FixedCols = 0
      FixedRows = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing, goFixedRowDefAlign]
      TabOrder = 3
      PRCells = <
        item
          Y = 0
          X = 0
          CellColor = clNavy
          CellFont.Charset = ANSI_CHARSET
          CellFont.Color = clRed
          CellFont.Height = -16
          CellFont.Name = 'System'
          CellFont.Style = [fsBold]
        end>
      ImportHeaderFromFile = False
    end
  end
  object OpenTextFileDialog1: TOpenTextFileDialog
    Left = 648
    Top = 8
  end
  object SaveTextFileDialog1: TSaveTextFileDialog
    Left = 560
    Top = 8
  end
end
