object InDatSuchFenster: TInDatSuchFenster
  Left = 356
  Top = 243
  Width = 790
  Height = 443
  Caption = 'InDatSuchFenster'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object LabDurchsucht: TLabel
    Left = 330
    Top = 145
    Width = 192
    Height = 23
    Caption = 'Dateien 0 - 40 durchsucht'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label1: TLabel
    Left = 61
    Top = 65
    Width = 241
    Height = 23
    Caption = 'Gesuchtes Wort (Fremdsprache):'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object LabStartA: TLabel
    Left = 470
    Top = 68
    Width = 188
    Height = 23
    Caption = 'Suche mit <Enter> starten'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 61
    Top = 101
    Width = 197
    Height = 23
    Caption = 'Gesuchtes Wort (Deutsch):'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object LabStartD: TLabel
    Left = 470
    Top = 101
    Width = 188
    Height = 23
    Caption = 'Suche mit <Enter> starten'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object BitBtn1: TBitBtn
    Left = 528
    Top = 143
    Width = 100
    Height = 25
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkClose
  end
  object ErgebnisGrid: TStringGrid
    Left = 160
    Top = 217
    Width = 450
    Height = 103
    ColCount = 3
    DefaultColWidth = 149
    FixedColor = clActiveBorder
    FixedCols = 0
    RowCount = 4
    FixedRows = 0
    Options = [goVertLine, goHorzLine, goRowSelect, goThumbTracking]
    ScrollBars = ssNone
    TabOrder = 1
  end
  object EdSuchwortA: TEdit
    Left = 313
    Top = 66
    Width = 121
    Height = 21
    TabOrder = 2
    Text = ' '
    OnClick = EdSuchwortAClick
    OnKeyDown = EdSuchwortAKeyDown
    OnKeyPress = EdSuchwortAKeyPress
  end
  object EdSuchwortD: TEdit
    Left = 314
    Top = 104
    Width = 121
    Height = 21
    TabOrder = 3
    OnClick = EdSuchwortDClick
    OnKeyDown = EdSuchwortDKeyDown
    OnKeyPress = EdSuchwortDKeyPress
  end
end
