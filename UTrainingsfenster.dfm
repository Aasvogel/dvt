object Trainingsfenster: TTrainingsfenster
  Left = 229
  Top = 64
  Caption = 'Trainingsfenster'
  ClientHeight = 841
  ClientWidth = 1584
  Color = 13750737
  Constraints.MaxHeight = 900
  Constraints.MaxWidth = 1600
  Constraints.MinHeight = 900
  Constraints.MinWidth = 1600
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object LabTitel: TLabel
    Left = 42
    Top = 465
    Width = 30
    Height = 19
    Caption = 'Titel'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -13
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object Image1: TImage
    Left = 929
    Top = 42
    Width = 644
    Height = 470
    Stretch = True
  end
  object StriErgebnisse: TStringGrid
    Left = 100
    Top = 500
    Width = 572
    Height = 233
    BorderStyle = bsNone
    DefaultRowHeight = 22
    FixedCols = 0
    RowCount = 10
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    GridLineWidth = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    ParentFont = False
    ScrollBars = ssNone
    TabOrder = 1
    Visible = False
    ColWidths = (
      10
      146
      159
      75
      163)
  end
  object PaTraining: TPanel
    Left = 100
    Top = 500
    Width = 481
    Height = 233
    BorderStyle = bsSingle
    Caption = ' '
    Color = 12572656
    TabOrder = 0
    Visible = False
    object LaKAWort: TLabel
      Left = 24
      Top = 112
      Width = 5
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -17
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
    end
    object LaKDWort: TLabel
      Left = 63
      Top = 199
      Width = 5
      Height = 24
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clPurple
      Font.Height = -17
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
    end
    object LaUebWortAnz: TLabel
      Left = 16
      Top = 23
      Width = 165
      Height = 19
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'LaUebWort'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -15
      Font.Name = 'Comic Sans MS'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LaNullSeite: TLabel
      Left = 293
      Top = 24
      Width = 67
      Height = 16
      Caption = 'LaNullSeite'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Comic Sans MS'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object EdAWort: TEdit
      Left = 16
      Top = 63
      Width = 350
      Height = 34
      Cursor = crIBeam
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -19
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'EdAWort'
      OnKeyPress = EdAWortKeyPress
    end
    object EdDWort: TEdit
      Left = 56
      Top = 157
      Width = 350
      Height = 34
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -19
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'EdDWort'
      OnKeyPress = EdDWortKeyPress
    end
  end
  object MainMenu1: TMainMenu
    Left = 74
    Top = 46
    object Hilfe1: TMenuItem
      Caption = '&Hilfe'
    end
    object Lexikon1: TMenuItem
      Caption = '&Lexikon'
    end
    object DLexikon1: TMenuItem
      Caption = '&DLexikon'
    end
    object Exit1: TMenuItem
      Caption = 'E&xit'
      OnClick = Exit1Click
    end
  end
end
