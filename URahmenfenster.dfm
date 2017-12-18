object Rahmenfenster: TRahmenfenster
  Left = 80
  Top = 379
  HorzScrollBar.Visible = False
  ClientHeight = 328
  ClientWidth = 573
  Color = 12709613
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabTitelGrau: TLabel
    Left = 55
    Top = 59
    Width = 444
    Height = 41
    Caption = 'Vokabeltrainer Franz'#246'sisch'
    Color = 6579300
    Font.Charset = ANSI_CHARSET
    Font.Color = clSilver
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    Transparent = True
  end
  object LabTitelWeiss: TLabel
    Left = 50
    Top = 53
    Width = 444
    Height = 41
    Caption = 'Vokabeltrainer Franz'#246'sisch'
    Color = 6579300
    Font.Charset = ANSI_CHARSET
    Font.Color = 16512
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 450
    Top = 125
    Width = 82
    Height = 17
    Caption = 'Vokabeltrainer'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object LabUebungsseite: TLabel
    Left = 40
    Top = 251
    Width = 53
    Height = 21
    Caption = 'Seite 0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -15
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LaUebWoAnz: TLabel
    Left = 184
    Top = 251
    Width = 78
    Height = 21
    Caption = '20 W'#246'rter'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -15
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabNullseite: TLabel
    Left = 357
    Top = 251
    Width = 130
    Height = 21
    Caption = 'Nullseite: 1 Wort'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -15
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlPanelholder: TPanel
    Left = 77
    Top = 106
    Width = 348
    Height = 129
    TabOrder = 0
    object PanWortzahl: TPanel
      Left = 1
      Top = 1
      Width = 346
      Height = 127
      Align = alClient
      BevelOuter = bvNone
      Color = 15124164
      TabOrder = 0
      Visible = False
      OnClick = PanWortzahlClick
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 348
      ExplicitHeight = 129
      object LaWortZl: TLabel
        Left = 87
        Top = 19
        Width = 185
        Height = 23
        Caption = #220'bungswortzahl eingeben'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Comic Sans MS'
        Font.Style = []
        ParentFont = False
      end
      object EdWortzahl: TEdit
        Left = 170
        Top = 61
        Width = 30
        Height = 35
        Color = clScrollBar
        Font.Charset = ANSI_CHARSET
        Font.Color = clGray
        Font.Height = -19
        Font.Name = 'Comic Sans MS'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Text = ' '
        OnKeyDown = EdWortzahlKeyDown
        OnKeyPress = EdWortzahlKeyPress
      end
    end
    object PanSeitenzahl: TPanel
      Left = 1
      Top = 1
      Width = 346
      Height = 127
      Align = alClient
      BevelOuter = bvNone
      Color = 9145227
      TabOrder = 1
      Visible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 353
      ExplicitHeight = 129
      object LabSeite: TLabel
        Left = 114
        Top = 48
        Width = 86
        Height = 23
        Caption = #220'bungseite:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Comic Sans MS'
        Font.Style = []
        ParentFont = False
      end
      object EdSeite: TEdit
        Left = 242
        Top = 48
        Width = 30
        Height = 28
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnKeyPress = EdSeiteKeyPress
      end
    end
    object pnlLoslegen: TPanel
      Left = 1
      Top = 1
      Width = 346
      Height = 127
      Align = alClient
      BevelOuter = bvNone
      Color = 13750750
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMoneyGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      ExplicitTop = 0
      object Label5: TLabel
        Left = 89
        Top = 6
        Width = 173
        Height = 49
        Caption = 'Trainieren'
        Color = 6579300
        Font.Charset = ANSI_CHARSET
        Font.Color = clMedGray
        Font.Height = -35
        Font.Name = 'Comic Sans MS'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        OnClick = TrainierenClick
      end
      object Label4: TLabel
        Left = 95
        Top = 9
        Width = 173
        Height = 49
        Caption = 'Trainieren'
        Color = 6579300
        Font.Charset = ANSI_CHARSET
        Font.Color = 176
        Font.Height = -35
        Font.Name = 'Comic Sans MS'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        OnClick = TrainierenClick
      end
      object pnlUebungsmodus: TPanel
        Left = 206
        Top = 77
        Width = 114
        Height = 36
        Caption = #220'bungsmodus'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Comic Sans MS'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object pnlTrainieren: TPanel
        Left = 15
        Top = 77
        Width = 114
        Height = 36
        Caption = 'Training'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Comic Sans MS'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = TrainierenClick
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 13
    object MenSeitenwahl: TMenuItem
      Caption = '&Seite'
    end
    object Eingeben: TMenuItem
      Caption = '&Eingeben'
      OnClick = EingebenClick
    end
    object Wortzahl: TMenuItem
      Caption = '&Wortzahl'
      OnClick = WortzahlClick
    end
    object Trainieren: TMenuItem
      Caption = '&Trainieren'
      OnClick = TrainierenClick
    end
    object Lexikon1: TMenuItem
      Caption = '&Lexikon'
      OnClick = Lexikon1Click
    end
    object DLexikon1: TMenuItem
      Caption = '&DLexikon'
      OnClick = DLexikon1Click
    end
    object InDateienSuchen1: TMenuItem
      Caption = '&ISuchen'
      OnClick = InDateienSuchen1Click
    end
    object Optionen1: TMenuItem
      Caption = '&Optionen'
      object Spracheenglisch1: TMenuItem
        Caption = 'Sprache &englisch'
        OnClick = Spracheenglisch1Click
      end
      object Sprachefranzsisch1: TMenuItem
        Caption = 'Sprache &franz'#246'sisch'
        OnClick = Sprachefranzsisch1Click
      end
      object Vorgaben1: TMenuItem
        Caption = '&Vorgaben'
        OnClick = Vorgaben1Click
      end
      object DoppelwrterA2: TMenuItem
        Caption = 'Doppelw'#246'rterA'
        OnClick = DoppelwrterA1Click
      end
      object D1: TMenuItem
        Caption = 'Doppelw'#246'rterD'
        OnClick = DoppelwrterD1Click
      end
    end
    object MenHilfe: TMenuItem
      Caption = '&Hilfe'
      OnClick = MenHilfeClick
    end
    object Exit1: TMenuItem
      Caption = 'E&xit'
      ShortCut = 27
      OnClick = Exit1Click
    end
  end
end
