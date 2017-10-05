object Doppelwortfenster: TDoppelwortfenster
  Left = 245
  Top = 195
  Width = 809
  Height = 513
  Caption = 'Doppelwortfenster'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LabUeberschrift: TLabel
    Left = 75
    Top = 66
    Width = 596
    Height = 40
    Caption = 'Suche nach doppelten W'#246'rtern im Lexikon'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -29
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabSuchenAb: TLabel
    Left = 63
    Top = 191
    Width = 153
    Height = 23
    Caption = 'Suche ab Buchstaben'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object LabSpracheA: TLabel
    Left = 301
    Top = 118
    Width = 136
    Height = 35
    Caption = 'Franz'#246'sisch'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -24
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabLoeschen: TLabel
    Left = 127
    Top = 298
    Width = 208
    Height = 23
    Caption = 'Zum L'#246'schen Zeile anklicken'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object SButADoppWort: TSpeedButton
    Left = 390
    Top = 219
    Width = 260
    Height = 30
    Caption = 'Suche gleiche W'#246'rter'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    OnClick = SButADoppWortClick
  end
  object ButSucheRueckw: TSpeedButton
    Left = 390
    Top = 364
    Width = 260
    Height = 30
    Caption = 'Suche gleiche W'#246'rter r'#252'ckw'#228'rts'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    OnClick = ButSucheRueckwClick
  end
  object ButSuche: TSpeedButton
    Left = 390
    Top = 219
    Width = 260
    Height = 30
    Caption = 'Suche gleiche W'#246'rter'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    OnClick = SButADoppWortClick
  end
  object SuchGrid: TStringGrid
    Left = 366
    Top = 285
    Width = 307
    Height = 53
    ColCount = 2
    DefaultColWidth = 150
    FixedColor = clActiveBorder
    FixedCols = 0
    RowCount = 2
    FixedRows = 0
    Options = [goFixedVertLine, goVertLine, goHorzLine, goRangeSelect]
    TabOrder = 0
    OnMouseDown = SuchGridMouseDown
  end
  object EdSuchenAb: TEdit
    Left = 221
    Top = 189
    Width = 29
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Visible = False
    OnKeyPress = EdSuchenAbKeyPress
  end
  object MainMenu1: TMainMenu
    Left = 525
    Top = 2
    object MenSuchen: TMenuItem
      Caption = '&Suchen'
    end
    object MenSuchenAb: TMenuItem
      Caption = 'Suchen &ab '
      OnClick = MenSuchenAbClick
    end
    object MenAbbrech: TMenuItem
      Caption = 'A&bbrechen '
      OnClick = MenAbbrechClick
    end
    object MenExit: TMenuItem
      Caption = '&Exit'
      OnClick = MenExitClick
    end
  end
end
