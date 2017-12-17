object DoppelwortfensterD: TDoppelwortfensterD
  Left = 249
  Top = 114
  Width = 902
  Height = 642
  Caption = 'DoppelwortfensterD'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LabUeberschrift: TLabel
    Left = 156
    Top = 63
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
  object LabSpracheA: TLabel
    Left = 301
    Top = 108
    Width = 290
    Height = 35
    Caption = 'Deutsch ( - Franz'#246'sisch)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -24
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabSuchenAb: TLabel
    Left = 82
    Top = 238
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
  object SButADoppWort: TSpeedButton
    Left = 494
    Top = 232
    Width = 260
    Height = 30
    Caption = 'Suche gleiche W'#246'rter'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object LabLoeschdA: TLabel
    Left = 231
    Top = 498
    Width = 203
    Height = 23
    Caption = 'Ausw'#228'hlen durch Anklicken:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object Label2: TLabel
    Left = 230
    Top = 320
    Width = 203
    Height = 23
    Caption = 'Ausw'#228'hlen durch Anklicken:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object LabFrzLex: TLabel
    Left = 61
    Top = 444
    Width = 352
    Height = 35
    Caption = 'L'#246'schen im Franz'#246'sischlexikon'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -24
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object SButRueckw: TSpeedButton
    Left = 496
    Top = 362
    Width = 260
    Height = 30
    Caption = 'R'#252'ckw'#228'rtssuche'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object SuchGrid: TStringGrid
    Left = 470
    Top = 285
    Width = 307
    Height = 55
    ColCount = 2
    DefaultColWidth = 150
    FixedColor = clActiveBorder
    FixedCols = 0
    RowCount = 4
    FixedRows = 0
    Options = [goVertLine, goHorzLine, goRowSelect, goThumbTracking]
    ScrollBars = ssNone
    TabOrder = 0
  end
  object EdSuchenAb: TEdit
    Left = 240
    Top = 236
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
  end
  object ArbeitsGrid: TStringGrid
    Left = 469
    Top = 440
    Width = 307
    Height = 105
    ColCount = 2
    DefaultColWidth = 150
    FixedColor = clActiveBorder
    FixedCols = 0
    RowCount = 4
    FixedRows = 0
    Options = [goVertLine, goHorzLine, goRowSelect]
    ScrollBars = ssVertical
    TabOrder = 2
    Visible = False
  end
  object AbbrBtn: TBitBtn
    Left = 799
    Top = 515
    Width = 75
    Height = 25
    Caption = 'Abbrechen'
    ModalResult = 3
    TabOrder = 3
    Visible = False
    NumGlyphs = 2
  end
  object LoeschBtn: TBitBtn
    Left = 799
    Top = 479
    Width = 75
    Height = 25
    Caption = 'L'#246'schen'
    TabOrder = 4
    Visible = False
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    Layout = blGlyphRight
    NumGlyphs = 2
  end
  object MainMenu1: TMainMenu
    Left = 525
    Top = 2
    object Suchen1: TMenuItem
      Caption = '&Suchen'
    end
    object MenSuchenAb: TMenuItem
      Caption = 'Suchen &ab '
    end
    object RueckSuchen: TMenuItem
      Caption = '&R'#252'ckw'#228'rts suchen'
    end
    object Abbrecgeb1: TMenuItem
      Caption = 'A&bbrechen '
    end
    object Exit1: TMenuItem
      Caption = 'E&xit'
    end
  end
end
