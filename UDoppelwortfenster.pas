unit UDoppelwortfenster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Grids, Buttons, UService;

type
  TDoppelwortfenster = class(TForm)
    LabUeberschrift: TLabel;
    LabSuchenAb: TLabel;
    LabSpracheA: TLabel;
    LabLoeschen: TLabel;
    SButADoppWort: TSpeedButton;
    ButSucheRueckw: TSpeedButton;
    SuchGrid: TStringGrid;
    EdSuchenAb: TEdit;
    MainMenu1: TMainMenu;
    MenSuchen: TMenuItem;
    MenSuchenAb: TMenuItem;
    MenAbbrech: TMenuItem;
    MenExit: TMenuItem;
    ButSuche: TSpeedButton;


    procedure FormActivate(Sender: TObject);
    procedure SButADoppWortClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenSuchenAbClick(Sender: TObject);
    procedure EdSuchenAbKeyPress(Sender: TObject; var Key: Char);
    procedure MenExitClick(Sender: TObject);
    procedure MenAbbrechClick(Sender: TObject);
    procedure SuchGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ButSucheRueckwClick(Sender: TObject);
  private
   procedure MehrfachASuchen;
   procedure MehrfachASuchenRueckwaerts;
    { Private-Deklarationen }
  public
    PosZL: Integer;
    { Public-Deklarationen }
  end;

var
  Doppelwortfenster: TDoppelwortfenster;
  BoolRueckwaerts: Boolean;

implementation

{$R *.dfm}

procedure TDoppelwortfenster.FormActivate(Sender: TObject);
begin
  With SuchGrid do
  begin
    Width:= (DefaultColWidth+1) * ColCount + 3;
    Height:= (DefaultRowHeight+1) * RowCount + 3;
  end;
end;

procedure TDoppelwortfenster.SButADoppWortClick(Sender: TObject);
begin
  try
    MehrfachASuchen
  except Showmessage('Lexikonende erreicht'); end;
end;

procedure TDoppelwortfenster.FormCreate(Sender: TObject);
begin
  PosZL:= -1;
  If VorgabenRekord.Sprache = 'f' then LabSpracheA.Caption:= 'Französisch';
  If VorgabenRekord.Sprache = 'e' then LabSpracheA.Caption:= 'Englisch';
end;

procedure TDoppelwortfenster.MenSuchenAbClick(Sender: TObject);
begin
  LabSuchenAb.Visible:= true;
  EdSuchenAb.Visible:= true;
  EdSuchenAb.SetFocus;
end;

procedure TDoppelwortfenster.EdSuchenAbKeyPress(Sender: TObject;
  var Key: Char);
var
  SuchAb, SortWort: string;
begin
  case Key of
    '0'..'9' : Key:= #0;
    #8       : Key:= #0;
  end; {of case}
  SuchAb:= SuchAb + Key;
  SortWort:= SortierformatAWort(SuchAb);
  PosZL := FindAWortPosition(SortWort);
  EdSuchenAb.Visible:= false;
  LabSuchenAb.Visible:= false;
  MehrfachASuchen;
end;

procedure TDoppelwortfenster.MenExitClick(Sender: TObject);
begin
  LexikonSpeichern(VorgabenRekord.Sprache);
  close
end;

procedure TDoppelwortfenster.MenAbbrechClick(Sender: TObject);
begin
  close
end;

procedure TDoppelwortfenster.SuchGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  LexikonListe.Delete(PosZl + SuchGrid.Row);
  MehrfachASuchen;
end;


procedure TDoppelwortfenster.ButSucheRueckwClick(Sender: TObject);
begin
  try
    MehrfachASuchenRueckwaerts
  except Showmessage('Lexikonanfang erreicht'); end;
end;


procedure TDoppelwortfenster.MehrfachASuchen;
var
  Nr, Zeile: Integer;
  s, s1, s2, s3, Ss, Ss1: string;
begin
  repeat
    inc(PosZL);    Doppelwortfenster.Caption:= IntToStr(PosZL);
    s:=  TWortRekord(LexikonListe.Items[PosZL]).AWort;
    s1:= TWortRekord(LexikonListe.Items[PosZL+1]).AWort;
    s2:= TWortRekord(LexikonListe.Items[PosZL+2]).AWort;
    s3:= TWortRekord(LexikonListe.Items[PosZL+3]).AWort;
    Ss:= SortierformatAWort(s); Ss1:= SortierformatAWort(s1);
    If PosZL > (Lexikonliste.Count-5) then
      begin ShowMessage('Lexikonende erreicht'); exit; end;
  until (Ss = Ss1);

  SuchGrid.RowCount:= 2;
  If SortierformatAWort(s2) = Ss1 then
    SuchGrid.RowCount:= 3; //SuchGrid.Height:= 78;
  If SortierformatAWort(s3) = Ss1 then
    SuchGrid.RowCount:= 4; //SuchGrid.Height:= 103;
  SuchGrid.Height:= (SuchGrid.DefaultRowHeight+1) * SuchGrid.RowCount + 3;

  Zeile:= 0;
  For Nr:= PosZl to (PosZl+SuchGrid.RowCount-1) do
  begin
    SuchGrid.Cells[0,Zeile]:= TWortRekord(LexikonListe.Items[Nr]).AWort;
    SuchGrid.Cells[1,Zeile]:= TWortRekord(LexikonListe.Items[Nr]).DWort;
    inc(Zeile);
  end;
  ButSuche.Caption:= 'Weitersuchen';
end;


procedure TDoppelwortfenster.MehrfachASuchenRueckwaerts;
var
  Nr, Zeile, DoppelZL: Integer;
  s1, s2, s3, s4: string;
begin
  BoolRueckwaerts := true;
  repeat
    dec(PosZL);
    s1:=  TWortRekord(Lexikonliste.Items[PosZL]).AWort;
    s2:= TWortRekord(Lexikonliste.Items[PosZL-1]).AWort;
    DoppelZL:= 2;
  until (s2 = s1);
  s3:= TWortRekord(Lexikonliste.Items[PosZL-2]).AWort;
  If (s3 = s1) then
  begin
    DoppelZL:= 3;
    s4:= TWortRekord(Lexikonliste.Items[PosZL-3]).AWort;
    If (s4 = s1) then DoppelZL := 4;
  end;

  SuchGrid.Height:= (Suchgrid.DefaultRowHeight+1) * (DoppelZl) + 3;

  Zeile:= 0;
  For Nr:= PosZL-(DoppelZL-1) to PosZL do
  begin
    SuchGrid.Cells[0,Zeile]:= TWortRekord(Lexikonliste.Items[Nr]).AWort;
    SuchGrid.Cells[1,Zeile]:= TWortRekord(Lexikonliste.Items[Nr]).DWort;
    inc(Zeile);
  end;
end;


end.
