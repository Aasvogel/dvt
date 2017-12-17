unit UDatSuchFenster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, Buttons, UService;

type
  TInDatSuchFenster = class(TForm)
    LabDurchsucht: TLabel;
    Label1: TLabel;
    LabStartA: TLabel;
    Label4: TLabel;
    LabStartD: TLabel;
    BitBtn1: TBitBtn;
    ErgebnisGrid: TStringGrid;
    EdSuchwortA: TEdit;
    EdSuchwortD: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure EdSuchwortAKeyPress(Sender: TObject; var Key: Char);
    procedure EdSuchwortDKeyPress(Sender: TObject; var Key: Char);
    procedure EdSuchwortDClick(Sender: TObject);
    procedure EdSuchwortAKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdSuchwortDKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdSuchwortAClick(Sender: TObject);
  private
    RowNr: Integer;
    VorgabeDaten: TWortRekord;
    SuchDatei: string;
    procedure ZeigWort;
    procedure Clear;
    procedure FokusA;
    procedure FokusD;
  public
    { Public-Deklarationen }
  end;

var
  InDatSuchFenster: TInDatSuchFenster;

implementation

{$R *.dfm}

procedure TInDatSuchFenster.BitBtn1Click(Sender: TObject);
begin
  Clear;
  Close
end;


procedure TInDatSuchFenster.ZeigWort;
begin
  ErgebnisGrid.Cells[0,RowNr]:= Vorgabedaten.AWort;
  ErgebnisGrid.Cells[1,RowNr]:= Vorgabedaten.DWort;
  ErgebnisGrid.Cells[2,RowNr]:= SuchDatei;
end;

{_______________________________________________________________________________}

procedure TInDatSuchFenster.Clear;
var
  ZL: Integer;
begin
  With ErgebnisGrid do For ZL := 0 to Rowcount do
  begin
   Cells[0,ZL]:= '';
   Cells[1,ZL]:= '';
   Cells[2,ZL]:= '';
  end;
  EdSuchwortA.Text:= '';
end;


procedure TInDatSuchFenster.FormActivate(Sender: TObject);
begin
  RowNr:= 0;
  Clear;
  EdSuchwortA.SetFocus;
end;

{_______________________________________________________________________________}


procedure TInDatSuchFenster.FokusA;
begin
  EdSuchwortA.SetFocus;
  LabStartA.Visible:= true;
  LabStartD.Visible:= false;
end;


procedure TInDatSuchFenster.FokusD;
begin
  EdSuchwortD.SetFocus;
  LabStartA.Visible:= false;
  LabStartD.Visible:= true;
end;


procedure TInDatSuchFenster.EdSuchwortAKeyPress(Sender: TObject;
  var Key: Char);
var
  s: string;
  Zl, ZL1: Integer;
begin
  LabDurchsucht.visible:= false;
  If VorgabenRekord.Sprache = 'e' then s:= '.dte';
  If VorgabenRekord.Sprache = 'f' then
    begin s:= '.dtf'; Key:= FranzBuchstaben(Key); end;

  If Key = #13 then
  begin
    For ZL:= 0 to 40 do
    begin
      SuchDatei:= 'Seite'+IntToStr(Zl)+s;
      Try
        ErgebnisseUndDateiLaden(SuchDatei);
        For ZL1:= 1 to (WortListe.Count-1) do
        begin
          Vorgabedaten:= TWortRekord(WortListe.Items[ZL1]);
          If SortierformatAWort(Vorgabedaten.AWort)
            = SortierformatAWort(EdSuchwortA.Text) then
          begin
            ZeigWort;
            Inc(RowNr);
          end;
        end;
      except {ShowMessage(SuchDatei +' gibt es nicht')}; end;
    end;
    EdSuchwortA.Text:= '';
    LabDurchsucht.Visible:= true;
  end;
end;

procedure TInDatSuchFenster.EdSuchwortDKeyPress(Sender: TObject;
  var Key: Char);
var
  s: string;
  Zl, ZL1: Integer;
begin
  LabDurchsucht.visible:= false;
  If VorgabenRekord.Sprache = 'e' then s:= '.dte';
  If VorgabenRekord.Sprache = 'f' then s:= '.dtf';

  If Key = #13 then
  begin
    For ZL:= 0 to 40 do
    begin
      SuchDatei:= 'Seite'+IntToStr(Zl)+s;
      Try
        ErgebnisseUndDateiLaden(SuchDatei);
        {XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}
        For ZL1:= 0 to (Wortliste.count-1) do
        begin
          Vorgabedaten:= TWortRekord(WortListe.Items[ZL1]);
          If SortierformatDWort(Vorgabedaten.DWort) = SortierformatDWort(EdSuchwortD.Text) then
          begin
            ZeigWort;
            Inc(RowNr);
          end;
        end;
        {XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}
      except {ShowMessage(SuchDatei +' gibt es nicht')}; end;
    end;
    EdSuchwortD.Text:= '';
    LabDurchsucht.Visible:= true;
  end;
end;


procedure TInDatSuchFenster.EdSuchwortDClick(Sender: TObject);
begin
  EdSuchwortD.SetFocus;
  LabStartD.Visible:= true;
  LabStartA.Visible:= false;
end;

procedure TInDatSuchFenster.EdSuchwortAKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = 40 then FokusD;
end;

procedure TInDatSuchFenster.EdSuchwortDKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If Key = 38 then FokusA ;
end;

procedure TInDatSuchFenster.EdSuchwortAClick(Sender: TObject);
begin
  FokusA;
end;

end.
