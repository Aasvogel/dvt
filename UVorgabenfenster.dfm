object Vorgabenfenster: TVorgabenfenster
  Left = 301
  Top = 189
  Width = 870
  Height = 500
  Caption = 'Vorgabenfenster'
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
  object Label1: TLabel
    Left = 384
    Top = 325
    Width = 77
    Height = 23
    Caption = 'anklicken !'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 101
    Top = 123
    Width = 128
    Height = 40
    Caption = 'Vorgaben'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -29
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LabUebernCaption: TLabel
    Left = 422
    Top = 54
    Width = 193
    Height = 26
    Caption = 'Vorgaben '#252'bernehmen'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object LabLoeschCaption: TLabel
    Left = 448
    Top = 256
    Width = 152
    Height = 26
    Caption = 'Vorgaben l'#246'schen'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 52
    Top = 182
    Width = 227
    Height = 35
    Caption = '(Sicherungsdateien)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -24
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 381
    Top = 118
    Width = 77
    Height = 23
    Caption = 'anklicken !'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object FLBLoeschen: TFileListBox
    Left = 473
    Top = 294
    Width = 105
    Height = 115
    Color = 14932411
    ItemHeight = 16
    Mask = '*.vrg'
    TabOrder = 0
    OnClick = FLBLoeschenClick
  end
  object FLBUebernehmen: TFileListBox
    Left = 473
    Top = 94
    Width = 105
    Height = 115
    Color = 14932411
    ItemHeight = 16
    Mask = '*.vrg'
    TabOrder = 1
    OnClick = FLBUebernehmenClick
  end
  object MainMenu1: TMainMenu
    Left = 368
    Top = 32
    object schliessen1: TMenuItem
      Caption = 's&chliessen'
      OnClick = schliessen1Click
    end
  end
end
