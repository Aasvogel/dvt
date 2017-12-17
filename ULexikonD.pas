unit ULexikonD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, StdCtrls, UService;

type
  TLexikonD = class(TForm)
    LabSuchen: TLabel;
    GridLexikon: TStringGrid;
    MainMenu1: TMainMenu;
    MenSuchen: TMenuItem;
    MenExit: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure GridLexikonKeyPress(Sender: TObject; var Key: Char);
    procedure MenSuchenClick(Sender: TObject);
    procedure MenExitClick(Sender: TObject);
  private
    Suchwort: String;
    bSuchen: Boolean;
  public
    { Public-Deklarationen }
  end;

var
  LexikonD: TLexikonD;

implementation

{$R *.dfm}

procedure TLexikonD.FormActivate(Sender: TObject);
var
  ZL: Integer;
  LexStr: String;
begin
  GridLexikon.Visible:= false; bSuchen:= false;
  LexikonD.Height:= 285;
  If Vorgabenrekord.Sprache = 'f' then LexStr := 'Lexikon Deutsch-Französisch    '
    else LexStr:= 'Lexikon Deutsch-Englisch    ';
  MachDeutschListe;
  LexikonD.Caption:= LexStr + IntToStr(Deutschliste.Count-1)+' Wörter';
  GridLexikon.RowCount:= Deutschliste.Count-1;
  For ZL:= 0 to DeutschListe.Count-1 do
  begin
    GridLexikon.Cells[0,ZL]:=(TWortRekord(DeutschListe.Items[ZL]).DWort);
    GridLexikon.Cells[1,ZL]:=(TWortRekord(DeutschListe.Items[ZL]).AWort);
  end;
  GridLexikon.Visible:= true;
  GridLexikon.SetFocus;
end;


procedure TLexikonD.GridLexikonKeyPress(Sender: TObject; var Key: Char);
var
  SortWort: String;
begin
  if bSuchen then begin
    Case Key of
      '0'..'9' : Key:= #0;
      #8  : begin SuchWort:= copy(Suchwort, 1, length(Suchwort)-1); Key:= #0; end;     //back
    end; {of case}
    If (Key <> #0) and (Key <>#13)  then Suchwort:= SuchWort + Key;

    LabSuchen.Caption := 'Suche: '+ Suchwort;
    SortWort:= SortierformatDWort(Suchwort);
    GridLexikon.Row := FindDWortPosition(SortWort);

    If Key = #13 then
    begin
      LabSuchen.Visible:= false; LexikonD.Height:= 285;
      bSuchen:= false;
    end;
  end;
end;


procedure TLexikonD.MenSuchenClick(Sender: TObject);
begin
  bSuchen:= true; Suchwort:= '';
  LexikonD.Height:= 320; GridLexikon.Row:= 0;
  LabSuchen.Visible:= true; LabSuchen.Caption := 'Suche: ';
end;

procedure TLexikonD.MenExitClick(Sender: TObject);
begin
  LabSuchen.Caption := 'Suche: ';
  Suchwort:= ''; 
  close
end;

end.
