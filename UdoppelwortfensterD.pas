unit UdoppelwortfensterD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Buttons, Grids, Uservice;

type
  TDoppelwortfensterD = class(TForm)
    LabUeberschrift: TLabel;
    LabSpracheA: TLabel;
    MainMenu1: TMainMenu;
    Suchen1: TMenuItem;
    MenSuchenAb: TMenuItem;
    Abbrecgeb1: TMenuItem;
    Exit1: TMenuItem;
    LabSuchenAb: TLabel;
    SuchGrid: TStringGrid;
    SButADoppWort: TSpeedButton;
    LabLoeschdA: TLabel;
    Label2: TLabel;
    LabFrzLex: TLabel;
    SButRueckw: TSpeedButton;
    EdSuchenAb: TEdit;
    ArbeitsGrid: TStringGrid;
    AbbrBtn: TBitBtn;
    LoeschBtn: TBitBtn;
    RueckSuchen: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Abbrecgeb1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure SButADoppWortClick(Sender: TObject);
    procedure SuchGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AbbrBtnClick(Sender: TObject);
    procedure LoeschBtnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdSuchenAbKeyPress(Sender: TObject; var Key: Char);
    procedure SButRueckwClick(Sender: TObject);
    procedure MenSuchenAbClick(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure MehrfachDSuchen;
    procedure MehrfachDSuchenRueckwaerts;
    procedure ZeigLexikon;
  public
    PosZL: Integer;
    { Public-Deklarationen }
  end;

var
  DoppelwortfensterD: TDoppelwortfensterD;
  BoolRueckwaerts: Boolean;

implementation

{$R *.dfm}

procedure TDoppelwortfensterD.FormCreate(Sender: TObject);
begin
  PosZL:= -1;
  If VorgabenRekord.Sprache = 'f' then LabSpracheA.Caption:= 'Deutsch ( - Französisch)';
  If VorgabenRekord.Sprache = 'e' then LabSpracheA.Caption:= 'Deutsch ( - Englisch)';
end;



procedure TDoppelwortfensterD.FormActivate(Sender: TObject);
begin

  MachDeutschListe;
  With SuchGrid do
  begin
    Width:= (DefaultColWidth+1) * ColCount + 3;
    Height:= (DefaultRowHeight+1) * 2 + 3;
  end;
end;



procedure TDoppelwortfensterD.Abbrecgeb1Click(Sender: TObject);
begin
  close
end;



procedure TDoppelwortfensterD.Exit1Click(Sender: TObject);
begin
  close
end;



procedure TDoppelwortfensterD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LexikonSpeichern(VorgabenRekord.Sprache);
end;


{___________________________________________________________________________________}

procedure TDoppelwortfensterD.SButADoppWortClick(Sender: TObject);
begin
  try
    MehrfachDSuchen
  except Showmessage('Lexikonende erreicht'); end;
end;


procedure TDoppelwortfensterD.MehrfachDSuchen;
var
  Nr, Zeile, DoppelZL: Integer;
  s1, s2, s3, s4: string;
begin
  BoolRueckwaerts := false;
  repeat
    inc(PosZL);                DoppelwortfensterD.Caption:= IntToStr(PosZL);
    s1:=  TWortRekord(Deutschliste.Items[PosZL]).DWort;
    s2:= TWortRekord(Deutschliste.Items[PosZL+1]).DWort;
    DoppelZL:= 2;
  until (s2 = s1);
  s3:= TWortRekord(Deutschliste.Items[PosZL+2]).DWort;
  If (s3 = s1) then
  begin
    DoppelZL:= 3;
    s4:= TWortRekord(Deutschliste.Items[PosZL+3]).DWort;
    If (s4 = s1) then DoppelZL := 4;
  end;

  SuchGrid.Height:= (Suchgrid.DefaultRowHeight+1) * (DoppelZl) + 3;
  SButRueckw.Top:= SuchGrid.Top + (DoppelZL+1) * SuchGrid.DefaultRowHeight+1;

  Zeile:= 0;
  For Nr:= PosZL to (PosZL+(DoppelZL-1)) do
  begin
    SuchGrid.Cells[0,Zeile]:= TWortRekord(Deutschliste.Items[Nr]).DWort;
    SuchGrid.Cells[1,Zeile]:= TWortRekord(Deutschliste.Items[Nr]).AWort;
    inc(Zeile);
  end;
end;


{___________________________________________________________________________________}


procedure TDoppelwortfensterD.SButRueckwClick(Sender: TObject);
begin
  try
    MehrfachDSuchenRueckwaerts
  except Showmessage('Lexikonanfang erreicht'); end;
end;



procedure TDoppelwortfensterD.MehrfachDSuchenRueckwaerts;
var
  Nr, Zeile, DoppelZL: Integer;
  s1, s2, s3, s4: string;
begin
  BoolRueckwaerts := true;
  repeat
    dec(PosZL);                DoppelwortfensterD.Caption:= IntToStr(PosZL);
    s1:=  TWortRekord(Deutschliste.Items[PosZL]).DWort;
    s2:= TWortRekord(Deutschliste.Items[PosZL-1]).DWort;
    DoppelZL:= 2;
  until (s2 = s1);
  s3:= TWortRekord(Deutschliste.Items[PosZL-2]).DWort;
  If (s3 = s1) then
  begin
    DoppelZL:= 3;
    s4:= TWortRekord(Deutschliste.Items[PosZL-3]).DWort;
    If (s4 = s1) then DoppelZL := 4;
  end;

  SuchGrid.Height:= (Suchgrid.DefaultRowHeight+1) * (DoppelZl) + 3;
  SButRueckw.Top:= SuchGrid.Top + (DoppelZL+1) * SuchGrid.DefaultRowHeight+1;

  Zeile:= 0;
  For Nr:= PosZL-(DoppelZL-1) to PosZL do
  begin
    SuchGrid.Cells[0,Zeile]:= TWortRekord(Deutschliste.Items[Nr]).DWort;
    SuchGrid.Cells[1,Zeile]:= TWortRekord(Deutschliste.Items[Nr]).AWort;
    inc(Zeile);
  end;
end;

{_______________________________________________________________________________________}

procedure TDoppelwortfensterD.SuchGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  SuchGridPosition: Integer;
  SuchWort, SortWort: string;
begin
  SuchGridPosition:= (PosZL+SuchGrid.Row);
  ZeigLexikon;
  Suchwort:= TWortRekord(Deutschliste.Items[SuchGridPosition]).AWort;
  SortWort:= SortierformatAWort(Suchwort);
  If not BoolRueckwaerts then
  begin
    ArbeitsGrid.RowCount:= Lexikonliste.Count-1;
    Arbeitsgrid.Row:= FindAWortPosition(SortWort);
    LabFrzLex.Visible:= true; LabLoeschdA.Visible:= true;
    Arbeitsgrid.visible:= true; AbbrBtn.visible:= true; LoeschBtn.Visible:= true;
  end;  
end;

{___________________________________________________________________________________}



procedure TDoppelwortfensterD.ZeigLexikon;
var
  ZL: Integer;
begin
  For ZL:= 0 to LexikonListe.Count-1 do
  begin
    ArbeitsGrid.Cells[0,ZL]:=(TWortRekord(LexikonListe.Items[ZL]).AWort);
    ArbeitsGrid.Cells[1,ZL]:=(TWortRekord(LexikonListe.Items[ZL]).DWort);
  end;
end;


procedure TDoppelwortfensterD.AbbrBtnClick(Sender: TObject);
begin
  LabFrzLex.Visible:= false; LabLoeschdA.Visible:= false;
  Arbeitsgrid.visible:= false; AbbrBtn.visible:= false; LoeschBtn.Visible:= false;
end;



procedure TDoppelwortfensterD.LoeschBtnClick(Sender: TObject);
begin
  LexikonListe.Delete(Arbeitsgrid.Row);
  ZeigLexikon;
  MachDeutschListe;
end;

procedure TDoppelwortfensterD.EdSuchenAbKeyPress(Sender: TObject;
  var Key: Char);
var
  SuchAb, SortWort: string;
begin
  case Key of
    '0'..'9' : Key:= #0;
    #8       : Key:= #0;
  end; {of case}
  SuchAb:= SuchAb + Key;
  SortWort:= SortierformatDWort(SuchAb);
  PosZL := FindDWortPosition(SortWort);
  EdSuchenAb.Visible:= false;
  LabSuchenAb.Visible:= false;
  MehrfachDSuchen;
end;

procedure TDoppelwortfensterD.MenSuchenAbClick(Sender: TObject);
begin
  EdSuchenAb.Visible:= true;
  LabSuchenAb.Visible:= true;
  EdSuchenAb.SetFocus;
end;

end.
