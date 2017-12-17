object LexikonD: TLexikonD
  Left = 331
  Top = 297
  Width = 375
  Height = 282
  Caption = 'LexikonD'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object LabSuchen: TLabel
    Left = 23
    Top = 238
    Width = 59
    Height = 22
    Caption = 'Suche:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object GridLexikon: TStringGrid
    Left = 11
    Top = 1
    Width = 340
    Height = 220
    BiDiMode = bdLeftToRight
    ColCount = 2
    DefaultColWidth = 159
    DragCursor = crDefault
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    Options = [goVertLine, goHorzLine, goDrawFocusSelected, goThumbTracking]
    ParentBiDiMode = False
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnKeyPress = GridLexikonKeyPress
  end
  object MainMenu1: TMainMenu
    Left = 89
    Top = 101
    object MenSuchen: TMenuItem
      Caption = '&Suchen'
      OnClick = MenSuchenClick
    end
    object MenExit: TMenuItem
      Caption = 'E&xit'
      OnClick = MenExitClick
    end
  end
end
