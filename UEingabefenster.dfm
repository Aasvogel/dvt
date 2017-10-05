object Eingabefenster: TEingabefenster
  Left = 230
  Top = 114
  Width = 828
  Height = 630
  Caption = 'Eingabefenster'
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
  object Panel1: TPanel
    Left = 9
    Top = -7
    Width = 789
    Height = 567
    Caption = 'Panel1'
    Color = 8896214
    TabOrder = 0
    object Lab1: TLabel
      Left = 54
      Top = 191
      Width = 199
      Height = 27
      Caption = 'W'#246'rter korrigieren,'
      Color = 8896214
      Font.Charset = ANSI_CHARSET
      Font.Color = clOlive
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object Lab2: TLabel
      Left = 54
      Top = 229
      Width = 219
      Height = 27
      Caption = 'l'#246'schen, hinzuf'#252'gen'
      Font.Charset = ANSI_CHARSET
      Font.Color = clOlive
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LabNeueSeite: TLabel
      Left = 55
      Top = 386
      Width = 217
      Height = 27
      Caption = 'Neue Seite erstellen'
      Font.Charset = ANSI_CHARSET
      Font.Color = clOlive
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object LabUebungsseite: TLabel
      Left = 54
      Top = 68
      Width = 272
      Height = 29
      Caption = #220'bungsseite bearbeiten'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabInfoEintrag: TLabel
      Left = 54
      Top = 482
      Width = 235
      Height = 18
      Caption = 'Neue Seitennummer eingetragen'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object LabWortVorhanden: TLabel
      Left = 127
      Top = 264
      Width = 188
      Height = 20
      Caption = 'Wort bereits vorhanden'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object EingabeGrid: TStringGrid
      Left = 366
      Top = 43
      Width = 405
      Height = 506
      BiDiMode = bdLeftToRight
      Color = 10277867
      ColCount = 2
      DefaultColWidth = 200
      FixedColor = 10277867
      FixedCols = 0
      RowCount = 20
      FixedRows = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      Options = [goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goEditing, goThumbTracking]
      ParentBiDiMode = False
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnKeyDown = EingabeGridKeyDown
      OnKeyPress = EingabeGridKeyPress
    end
    object DisplayDGrid: TStringGrid
      Left = 162
      Top = 290
      Width = 155
      Height = 54
      BiDiMode = bdLeftToRight
      Color = clCream
      ColCount = 1
      DefaultColWidth = 150
      FixedColor = 10277867
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      Options = [goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goThumbTracking]
      ParentBiDiMode = False
      ParentFont = False
      ScrollBars = ssNone
      TabOrder = 1
      Visible = False
      OnKeyDown = DisplayDGridKeyDown
      OnMouseDown = DisplayDGridMouseDown
    end
    object DisplayADGrid: TStringGrid
      Left = 30
      Top = 411
      Width = 305
      Height = 53
      BiDiMode = bdLeftToRight
      ColCount = 2
      DefaultColWidth = 150
      DragCursor = crDefault
      FixedCols = 0
      RowCount = 2
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
      TabOrder = 2
      Visible = False
    end
  end
  object MainMenu1: TMainMenu
    Left = 49
    Top = 62
    object MenSeiteLoeschen: TMenuItem
      Caption = '&Alle W'#246'rter l'#246'schen'
      OnClick = MenSeiteLoeschenClick
    end
    object MeneineZeilelschen1: TMenuItem
      Caption = 'eine Zeile &l'#246'schen'
      OnClick = MeneineZeilelschen1Click
    end
    object Seitenzahleintragen1: TMenuItem
      Caption = '&Seitenzahl eintragen'
      OnClick = Seitenzahleintragen1Click
    end
    object MenSchliessen: TMenuItem
      Caption = 's&chliessen'
      OnClick = MenSchliessenClick
    end
    object Exit1: TMenuItem
      Caption = 'E&xit+speichern'
      OnClick = Exit1Click
    end
  end
end
