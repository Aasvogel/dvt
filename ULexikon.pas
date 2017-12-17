unit ULexikon;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, StdCtrls, UService;

type
  TLexikon = class(TForm)
    LabSuchen: TLabel;
    MainMenu1: TMainMenu;
    MenSuchen: TMenuItem;
    GridLexikon: TStringGrid;
    MenExit: TMenuItem;
    Zeilellschen1: TMenuItem;
    procedure MenSuchenClick(Sender: TObject);
    procedure MenExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GridLexikonKeyPress(Sender: TObject; var Key: Char);
    procedure Zeilellschen1Click(Sender: TObject);
  private
    Suchwort: String;
    bSuchen: Boolean;
    procedure Zeiglexikon;
  public
    { Public-Deklarationen }
  end;

var
  Lexikon: TLexikon;

implementation

{$R *.dfm}

procedure TLexikon.FormActivate(Sender: TObject);
var
  LexStr: String;
begin
  GridLexikon.Visible:= false; BSuchen:= false;
  Height := 290;
  If Vorgabenrekord.Sprache = 'e' then LexStr := 'Lexikon Englisch-Deutsch       ';
  If Vorgabenrekord.Sprache = 'f' then LexStr := 'Lexikon Französisch-Deutsch    ';
  Caption:= LexStr + IntToStr(Lexikonliste.Count-1)+' Wörter';
  GridLexikon.RowCount:= Lexikonliste.Count-1;
  ZeigLexikon;
end;


procedure TLexikon.Zeiglexikon;
var
  ZL: Integer;
begin
  For ZL:= 0 to LexikonListe.Count-1 do
  begin
    GridLexikon.Cells[0,ZL]:=(TWortRekord(LexikonListe.Items[ZL]).AWort);
    GridLexikon.Cells[1,ZL]:=(TWortRekord(LexikonListe.Items[ZL]).DWort);
  end;
  GridLexikon.Visible:= true;
  GridLexikon.SetFocus;
end;


procedure TLexikon.GridLexikonKeyPress(Sender: TObject; var Key: Char);
var
  SortWort: String;
begin
  If bSuchen then begin
    Case Key of
      '0'..'9' : Key:= #0;
      #8  : begin SuchWort:= copy(Suchwort, 1, length(Suchwort)-1); Key:= #0; end;     //back
    end; {of case}
     If (GridLexikon.Col = 0) and (VorgabenRekord.Sprache = 'f') then Key:= FranzBuchstaben(Key);
    If (Key <> #0) and (Key <>#13)  then Suchwort:= SuchWort + Key;

    LabSuchen.Caption := 'Suche: '+ Suchwort;
    SortWort:= SortierformatAWort(Suchwort);
    GridLexikon.Row := FindAWortPosition(SortWort);

    If Key = #13 then
    begin
      LabSuchen.Visible:= false;
      Height:= 290;
      Suchwort:= '';
      bSuchen:= false;
    end;
  end;
end;

{+++++++++++++++++++++++++++++++++suche, Zeile löschen +++++++++++++++++++++++++++}


procedure TLexikon.MenSuchenClick(Sender: TObject);
begin
  bSuchen:= true;
  Height:= 320; GridLexikon.Row:= 0;
  LabSuchen.Visible:= true; LabSuchen.Caption := 'Suche: ';
end;

procedure TLexikon.Zeilellschen1Click(Sender: TObject);
begin
  LexikonListe.Delete(GridLexikon.Row);
  ZeigLexikon;
  LexikonSpeichern(VorgabenRekord.Sprache);
end;

{+++++++++++++++++++++++++++++++++++++++++ beenden +++++++++++++++++++++++++++++++++}


procedure TLexikon.MenExitClick(Sender: TObject);
begin
  close
end;

end.
