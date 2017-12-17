unit UEingabefenster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, StdCtrls, ExtCtrls, UService, Buttons;

type
  TEingabefenster = class(TForm)
    Panel1: TPanel;
    Lab1: TLabel;
    Lab2: TLabel;
    LabNeueSeite: TLabel;
    LabUebungsseite: TLabel;
    LabInfoEintrag: TLabel;
    LabWortVorhanden: TLabel;
    EingabeGrid: TStringGrid;
    DisplayDGrid: TStringGrid;
    DisplayADGrid: TStringGrid;
    MainMenu1: TMainMenu;
    MenSeiteLoeschen: TMenuItem;
    MeneineZeilelschen1: TMenuItem;
    Seitenzahleintragen1: TMenuItem;
    MenSchliessen: TMenuItem;
    Exit1: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure MenSchliessenClick(Sender: TObject);
    procedure MeneineZeilelschen1Click(Sender: TObject);
    procedure MenSeiteLoeschenClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Seitenzahleintragen1Click(Sender: TObject);
    procedure EingabeGridKeyPress(Sender: TObject; var Key: Char);
    procedure EingabeGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DisplayDGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DisplayDGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    SeiteNr, WortPos: Integer;
    MehrfArr: array[0..10,0..1]of string;
    SuchWort, AEinfuegewort: String;
    bAVorhanden, bDVorhanden: Boolean;
    procedure EingabefensterSpeichern;
    procedure CheckDeutschListe(Checkwort: string);
    {____________________________________________________Serviceroutinen_______}
    procedure ZeigEingabefensteranweisungen;
    procedure LoeschEingabefensteranweisungen;
    procedure ZeigDoppelwortDAnweisungen;
    procedure ZeigWortListe;
    procedure ZeigDListe(ErstPos, LetztPos: Integer);        //mehrere DWörter
    procedure ZeigADListe(ErstPos, LetztPos: Integer);
    procedure EmptyInfoRekord;

  public
    { Public-Deklarationen }
  end;

var
  Eingabefenster: TEingabefenster;
  SortierAWort: string;

implementation

{$R *.dfm}

procedure TEingabefenster.FormActivate(Sender: TObject);
var
  Lexname: string;
begin
  With VorgabenRekord do
  begin
    If Sprache = 'e' then begin SeiteNr:= SeitArrE[1]; LexName:= 'Lexikon.elx'; end;
    If Sprache = 'f' then begin SeiteNr:= SeitArrF[1]; Lexname:= 'Lexikon.flx'; end;
  end;
  try
    ErgebnisseUndDateiLaden(Dateiname);
  except ShowMessage ('Diese Datei gibt es noch nicht'); EmptyInfoRekord; end;
  LexikonLaden(Lexname);

  Eingabefenster.Caption:= 'Seite '+IntToStr(SeiteNr)+'   -   '
   +IntToStr(Wortliste.Count-1)+' Wörter';
  LabUebungsseite.Caption:= 'Seite '+IntToStr(SeiteNr)+ ' bearbeiten';
  LabNeueSeite.Caption:= 'Seite '+IntToStr(SeiteNr)+ ' neu erstellen';
  If Wortliste.Count-1 > 20 then
  begin
    EingabeGrid.RowCount:= Wortliste.Count-1;
    EingabeGrid.DefaultColWidth:= 192;
  end;
  ZeigWortListe;
  LabInfoEintrag.visible:= false;
  EingabeGrid.Row:= 0; SuchWort:= '';
end;


procedure TEingabefenster.EmptyInfoRekord;
var
  ZL: Integer;
begin
  With InfoRekord do
  For ZL := 1 to 10 do begin
    DatArr[ZL]:= '';
    ZeitArr[ZL]:= '';
    FehlArr[ZL]:= '';
    FlWortArr[ZL]:= ''; 
  end;
end;


procedure TEingabefenster.ZeigWortListe;
var
  ZL: Integer;
begin
  for ZL := 0 to Eingabegrid.RowCount do
  If ZL < WortListe.Count-1 then              {solange Wörter drin sind}
  begin
    EingabeGrid.Cells[0, ZL] := TWortRekord(WortListe.Items[Zl + 1]).AWort;
    EingabeGrid.Cells[1, ZL] := TWortRekord(WortListe.Items[ZL + 1]).DWort;
  end
    else                                      {anschliessend ohne Wörter..}
  begin
    EingabeGrid.Cells[0, ZL] := ' ';
    EingabeGrid.Cells[1, ZL] := ' ';
  end;
end;


procedure TEingabefenster.MenSchliessenClick(Sender: TObject);
begin
  close
end;


procedure TEingabefenster.MeneineZeilelschen1Click(Sender: TObject);
begin
  try
  begin
    Wortliste.Delete(EingabeGrid.Row+1);
    ZeigWortListe;
  end except ShowMessage('Diese Zeile kann nicht gelöscht werden'); end;
end;


procedure TEingabefenster.MenSeiteLoeschenClick(Sender: TObject);
var
  ZL: Integer;
begin
  EmptyInfoRekord;
  For ZL := Wortliste.Count-1 downto 1 do
  Wortliste.Delete(ZL);
  ZeigWortListe;
end;


procedure TEingabefenster.EingabefensterSpeichern;
var
  ZL: Integer;
  Writer: TWriter;
  Stream: TFileStream;
  InfoListe, TestListe: TList;
  UebergabeRekord: TWortRekord;
begin
  Stream := TFileStream.Create(Dateiname, fmCreate);
  Writer := TWriter.Create(Stream, 1024);
  Writer.WriteListBegin;

  InfoListe:= TList.Create;                            {Dateibeginn: Infoliste}
  InfoListe.Add(InfoRekord);
  TInfoRekord(InfoListe.Items[0]).WriteToStream(Writer);

  UebergabeRekord:= TWortRekord.Create;                {Dateifortsetzung: NullItem}
  UebergabeRekord.AWort:= '';UebergabeRekord.DWort:= '';
  TWortRekord(UebergabeRekord).WriteToStream(Writer);

  TestListe:= TList.Create;                            {anschl. Wörter aus Grid}
  For ZL:= 0 to EingabeGrid.Rowcount do
  If (EingabeGrid.Cells[0, ZL] <> ' ') and (EingabeGrid.Cells[0, ZL] <> '') then
  begin
    UebergabeRekord:= TWortRekord.Create;
    UebergabeRekord.AWort:= EingabeGrid.Cells[0, ZL];
    UebergabeRekord.DWort:= EingabeGrid.Cells[1, ZL];
    TestListe.Add(UebergabeRekord);
  end;

  For ZL:= 0 to TestListe.Count-1 do TWortRekord(TestListe.Items[ZL]).WriteToStream(Writer);

  Writer.WriteListEnd;
  Writer.Free;
  Stream.Free;
end;


procedure TEingabefenster.CheckDeutschListe(Checkwort: string);
var
  SortDeWort: String;
  ZL, DWortPos, ErstPos, LetztPos: Integer;
begin
  ErstPos:= 0; LetztPos:= 0;
  If Deutschliste = nil then MachDeutschListe;
  SortDeWort:= SortierformatDWort(Checkwort);  DWortPos := FindDWortPosition(SortDeWort);
  {---------------------------------------------------------}      //mehrere AWörter vorhanden?
  For ZL:= DWortPos downto DWortPos-5 do
    If TWortRekord(DeutschListe[ZL]).SortDWort = SortDeWort then ErstPos:= ZL;
  For ZL:= DWortPos to DWortPos+5 do
    If TWortRekord(DeutschListe[ZL]).SortDWort = SortDeWort then LetztPos:= ZL;
  {---------------------------------------------------------}
  If ErstPos <> LetztPos then ZeigADListe(ErstPos, LetztPos);
end;

{___________ServiceRoutinen______________________________________________________________}


procedure TEingabefenster.ZeigEingabefensteranweisungen;
begin
  Lab1.Font.Color:= clOlive; Lab1.Caption:= 'Wörter korrigieren,';
  Lab2.Font.Size:= 18;
  Lab2.Font.Color:= clOlive; Lab2.Caption:= 'löschen, hinzufügen';
end;


procedure TEingabefenster.LoeschEingabefensteranweisungen;
begin
  Lab1.Visible:= false; Lab2.Visible:= false;
  LabNeueSeite.Visible:= false;
end;


procedure TEingabefenster.ZeigDoppelwortDAnweisungen;
begin
  Lab1.Font.Color:= clRed; Lab1.Caption:= 'bereits vorhandene Wörter';
  Lab2.Font.Size:= 12; Lab2.Font.Color:= clRed;
  Lab2.Caption:= 'anklicken oder anderes Wort eingeben';
  LabNeueSeite.Visible:= false;
end;


procedure TEingabefenster.ZeigDListe(ErstPos, LetztPos: Integer);        //mehrere DWörter
var
  ZL, ZeilenZl: Integer;
begin
  ZeilenZl:= LetztPos - ErstPos + 1;
  DisplayDGrid.RowCount:= ZeilenZL;
  DisplayDGrid.Height:= ZeilenZL * DisplayDGrid.DefaultRowHeight+6;         //anzeigen
  DisplayDGrid.Visible:= true;
             
  DisplayDGrid.SetFocus;                      //XXXXXXXXXXXXXXXXXXX


  ZeigDoppelwortDAnweisungen;
  LabWortVorhanden.Visible:= true;
  For ZL:= ErstPos to LetztPos do
  begin
    MehrfArr[ZL-ErstPos,0]:= (TWortRekord(LexikonListe[ZL]).AWort);
    MehrfArr[ZL-ErstPos,1]:= (TWortRekord(LexikonListe[ZL]).DWort);
    DisplayDGrid.Cells[0,ZL-ErstPos]:= (TWortRekord(LexikonListe[ZL]).DWort);
  end;
  LabWortVorhanden.Caption:= MehrfArr[0,0];
end;

procedure TEingabefenster.ZeigADListe(ErstPos, LetztPos: Integer);  //mehrere AWörter zu DWort
var
  ZL: Integer;
begin
  For ZL := ErstPos to LetztPos do
  With DisplayADGrid do
  begin
    Visible:= true;
    Cells[0,ZL-ErstPos]:= TWortRekord(DeutschListe[ZL]).AWort;
    Cells[1,ZL-ErstPos]:= TWortRekord(DeutschListe[ZL]).DWort
  end;
  LabNeueSeite.Font.Size:= 12; LabNeueSeite.Font.Color:= clRed;
  LabNeueSeite.Caption:= 'Zeile anklicken oder Return';
end;


procedure TEingabefenster.Exit1Click(Sender: TObject);
begin
  EingabefensterSpeichern;
  LexikonSpeichern(VorgabenRekord.Sprache);
  close;
end;

procedure TEingabefenster.Seitenzahleintragen1Click(Sender: TObject);
var
  ZL: Integer;
begin
  With VorgabenRekord do
  begin
    If Sprache = 'e' then For ZL:= 5 downto 2 do SeitArrE[ZL]:= SeitArrE[ZL-1];
    If Sprache = 'f' then For ZL:= 5 downto 2 do SeitArrF[ZL]:= SeitArrF[ZL-1];
  end;
  LabInfoEintrag.visible:= true;
end;


procedure TEingabefenster.EingabeGridKeyPress(Sender: TObject;
  var Key: Char);
var
  EinfuegeRekord: TWortRekord;
  ZL, ErstPos, LetztPos: Integer;
begin
  case Key of
    '0'..'9' : Key:= #0;                                        //keine Zahlen
    #8  : SuchWort:= copy(Suchwort, 1, length(Suchwort)-1);     //back
    #13 :          
      begin
      {----------------------------------------- Col 0 -----------RETURN}
      If EingabeGrid.Col = 0 then
      begin
        bAVorhanden:= false;
        ErstPos:= 0; LetztPos:= 0;
        AEinfuegewort:= Suchwort;
        SortierAWort:= SortierformatAWort(Suchwort); WortPos := FindAWortPosition(SortierAWort);
        If SortierAwort = (TWortRekord(LexikonListe[WortPos]).SortAWort) then    //AWort vorhanden
        begin
          {---------------------------------------------------------}    //mehrere DWörter vorhanden?
          For ZL:= WortPos downto WortPos-5 do
            If TWortRekord(LexikonListe[ZL]).SortAWort = SortierAWort then ErstPos:= ZL;
          For ZL:= WortPos to WortPos+5 do
            If TWortRekord(LexikonListe[ZL]).SortAWort = SortierAWort then LetztPos:= ZL;
          If ErstPos <> LetztPos then ZeigDListe(ErstPos, LetztPos);
          {---------------------------------------------------------}            //DWort vorgeben
          Eingabegrid.Cells[1,EingabeGrid.Row]:= (TWortRekord(LexikonListe[WortPos]).DWort);
          CheckDeutschListe(Eingabegrid.Cells[1,EingabeGrid.Row]);
          bAVorhanden:= true;
        end else
        begin
          Eingabegrid.Cells[1,EingabeGrid.Row]:= '';    //leer, weil AWort noch nicht vorhanden ist
        end;
        EingabeGrid.Col:= 1; SuchWort:= '';
      end
      {----------------------------------------- Col 1 ------------RETURN}
      else begin
        bDVorhanden:= false;
        {----------------------------------------}
        EinfuegeRekord:= TWortRekord.Create;
        With EinfuegeRekord do
        begin
          AWort:= AEinfuegewort;
          SortAWort:= SortierAWort;
          DWort:= Eingabegrid.Cells[1,EingabeGrid.Row];
          SortDWort:= SortierformatDWort(Eingabegrid.Cells[1,EingabeGrid.Row]);
        end;
        {----------------------------------------}
        If bAVorhanden then with EinfuegeRekord do
        begin
          While (TWortRekord(Lexikonliste[WortPos]).SortAWort = SortierAwort)   //zu gleichem AWort
            and (TWortRekord(Lexikonliste[WortPos]).SortDWort < SortDwort)      //kleinstes DWort suchen
            do inc(WortPos);
          If TWortRekord(Lexikonliste[WortPos]).DWort = DWort then bDVorhanden:= true;
        end;
        If not bDVorhanden then begin                                    //neue Wörter in Lexikonliste einfügen
          Lexikonliste.insert(WortPos,EinfuegeRekord); end;
        With EingabeGrid do if Row< RowCount-1 then Row:= Row+1;
        EingabeGrid.Col:= 0; Suchwort:= ''; bdVorhanden:= false;
        LabWortVorhanden.Visible:= false;
        LoeschEingabefensteranweisungen;
        CheckDeutschListe(EinfuegeRekord.DWort);
        DisplayDGrid.Visible:= false; DisplayADGrid.Visible:= false;
      end;  {of else - Col1}       
    end
    else     {---------------- nicht Zahl+back+Return ---------------------}
      begin                                   
        If EingabeGrid.Col = 0 then              { aaa, nicht Zahl+back+Return}
          If (VorgabenRekord.Sprache = 'f') then Key:= FranzBuchstaben(Key);
        SuchWort:= SuchWort + Key;
        DisplayADGrid.Visible:= false; ZeigEingabefensteranweisungen; 
      end;
  end; {of case}
end;

procedure TEingabefenster.EingabeGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var s: string;
begin
  case Key of 40:    {down}  
    begin with DisplayDGrid do
      If Row < Rowcount-1 then
      begin s:= Cells[Col,Row+1]; EingabeGrid.Cells[1,EingabeGrid.Row]:= s; end;
    end;
              38:    {up}
    begin with DisplayDGrid do
      If Row >0 then
      begin s:= Cells[Col,Row-1]; EingabeGrid.Cells[1,EingabeGrid.Row]:= s; end;
    end;
              13:    {Return}     EingabeGrid.SetFocus;
  end; {of case}
end;

procedure TEingabefenster.DisplayDGridMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DoppelDwort: string;
  RowNummer: Integer;
begin
  with DisplayDGrid do
  begin
    DisplayADGrid.Visible:= false;
    DoppelDwort:= DisplayDGrid.Cells[Col, Row];
    EingabeGrid.Cells[1,EingabeGrid.Row]:= DoppelDwort;
    RowNummer:= (Y-2) div DefaultRowHeight;
    EingabeGrid.Cells[0,EingabeGrid.Row]:= MehrfArr[RowNummer,0];    //gewähltes AWort in EingabeGrid
    LabWortVorhanden.Caption:= MehrfArr[RowNummer,0];                //gewähltes AWort anzeigen
    CheckDeutschListe(MehrfArr[RowNummer,1]);
    EingabeGrid.SetFocus;
  end;
end;

procedure TEingabefenster.DisplayDGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var s: string;
begin
  case Key of 40:    {down}  
    begin with DisplayDGrid do
      If Row < Rowcount-1 then
      begin s:= Cells[Col,Row+1]; EingabeGrid.Cells[1,EingabeGrid.Row]:= s; end;
    end;
              38:    {up}
    begin with DisplayDGrid do
      If Row >0 then
      begin s:= Cells[Col,Row-1]; EingabeGrid.Cells[1,EingabeGrid.Row]:= s; end;
    end;
              13:    {Return}     EingabeGrid.SetFocus;
  end; {of case}
end;

end.
