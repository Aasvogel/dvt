unit UTrainingsfenster;       //Vokabeltrainer

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, StdCtrls, ExtCtrls, UService, jpeg;

type
  FehlWortRekord = Record
    FehlWort: String[40];
    FehlZL: Integer;
  end;
  TTrainingsfenster = class(TForm)
    LabTitel: TLabel;
    PaTraining: TPanel;
    LaKAWort: TLabel;
    LaKDWort: TLabel;
    LaUebWortAnz: TLabel;
    LaNullSeite: TLabel;
    EdAWort: TEdit;
    EdDWort: TEdit;
    StriErgebnisse: TStringGrid;
    MainMenu1: TMainMenu;
    Hilfe1: TMenuItem;
    Lexikon1: TMenuItem;
    DLexikon1: TMenuItem;
    Exit1: TMenuItem;
    Image1: TImage;
    procedure FormActivate(Sender: TObject);
    procedure EdAWortKeyPress(Sender: TObject; var Key: Char);
    procedure EdDWortKeyPress(Sender: TObject; var Key: Char);
    procedure Exit1Click(Sender: TObject);
  private
    SeiteNr, WortZl, BildZl, FehlwortListenZl, FalschWortZl: Integer;
    Auswahlreihe: Array[1..40]of Integer;
    f_zeigeKorrektesWortAn, Geuebt: Boolean;
    VorgabeDaten, ZeroDatenRekord: TWortRekord;
    BildArray: Array[1..100]of string[30];
    Bildname, Bildtitel: string;
    SprachVorgabe: Char;
    procedure ZeigCaption;
    procedure MachAuswahlreihe;
    procedure ZeigErgebnisse;
    procedure UpdateAuswahlreihe;
    procedure NullSeitenAnzeige;
    procedure AuswertungA;
    procedure AuswertungD;
    procedure InFehlwortListe(p_Wort: String);
    procedure InZeroListe;
    procedure Trainingsvorgabe;
    procedure Trainingweiter;
    procedure TrainingsEnde;
    procedure NullseitenTrainingsEnde;
    procedure UpdateInfoRekord;
    procedure NullseiteLeerSpeichern;
    procedure Bilderwahl;


  public
    FehlWortArr: Array[1..40]of FehlWortRekord;
    MaxFehlWort: string[40];
  end;

var
  Trainingsfenster: TTrainingsfenster;
    BildNr: Integer;

implementation

uses URahmenfenster;

{$R *.dfm}


procedure TTrainingsfenster.FormActivate(Sender: TObject);
begin
  LaKAWort.Caption:= ''; LaKDWort.Caption:= '';
  If not bTraining then        //Trainingsprozess inaktiv
  begin
    LaNullSeite.Visible := f_unbekannteSpeichern;

    ErgebnisseUndDateiLaden(Dateiname);
    With VorgabenRekord do
    begin
      If Sprache = 'e' then SeiteNr:= SeitArrE[1];
      If Sprache = 'f' then SeiteNr:= SeitArrF[1];
    end;

    ZeigCaption;
    Bilderwahl;
    MachAuswahlreihe;

    If SeiteNr <> 0 then
    begin
      FalschwortZL:= 0;
      ZeigErgebnisse;
    end;
    PaTraining.Visible:= true;
    Trainingsvorgabe;
    bTraining:= true;       //Trainingsprozess aktiv   
  end;
end;


procedure TTrainingsfenster.ZeigCaption;
begin
  Trainingsfenster.Caption := 'Seite '+IntToStr(SeiteNr);
end;


procedure TTrainingsfenster.ZeigErgebnisse;
var
  ZL: Integer;
  SRect: TGridRect;
begin
  SRect.Top := -1;
  SRect.Left := -1;
  SRect.Bottom := -1;
  SRect.Right := -1;
  StriErgebnisse.Selection := SRect;  {Fokussierung weg}

  StriErgebnisse.Left:= 50;
  StriErgebnisse.Top:= 505;
  LabTitel.Left:= 60;

  For ZL:= 1 to 10 do
  begin
   StriErgebnisse.Cells[1,ZL-1]:= InfoRekord.DatArr[ZL];
   StriErgebnisse.Cells[2,ZL-1]:= InfoRekord.ZeitArr[ZL];
   StriErgebnisse.Cells[3,ZL-1]:= InfoRekord.FehlArr[ZL];
   StriErgebnisse.Cells[4,ZL-1]:= InfoRekord.FLWortArr[ZL];
  end;
  If VorgabenRekord.Sprache = 'e' then ZL := VorgabenRekord.SeitArrE[1];
  If VorgabenRekord.Sprache = 'f' then ZL := VorgabenRekord.SeitArrF[1];
  LabTitel.Caption:=
    ' geübt am              wie lange          nicht gewusst     schwierigstes Wort';
  NullSeitenAnzeige;
  StriErgebnisse.visible:= true; LabTitel.visible:= true;
  MessageDlgPos('', mtConfirmation, [mbYes], 0, 1, 1100);{Stopp; unsichtbar, weil außerhalb}
  StriErgebnisse.visible:= false; LabTitel.visible:= false;
end;

procedure TTrainingsfenster.Trainingsvorgabe;
var
  s: string;
begin
  If SeiteNr <> 0 then ZuArbeitArray(SeiteNr);
  f_zeigeKorrektesWortAn:= false; {solange kein Fehlversuch gelaufen}
  FehlwortListenZl:= -1;
  SetCursorPos(0,0);
  NullSeitenAnzeige;

  DLexikon1.Visible:= false;  Lexikon1.Visible:= false;  Hilfe1.Visible:= false;     //XXXXXXXXXX

//  PaTraining.Visible:= true;  //Trainisgspanel wird eingeblendet
  Vorgabedaten:= TWortRekord(WortListe.Items[Auswahlreihe[1]]);
  If Vorgabenrekord.Sprache = 'e' then s:= 'englisch    ' else s:= 'französisch ';
  LaUebWortAnz.Caption:= s + IntToStr(WortZL)+' Wörter';
  If SeiteNr = 0 then
  SprachVorgabe:= Vorgabedaten.Sprache else
    begin Randomize; if Random(20)> 10 then SprachVorgabe:= 'd' else
    SprachVorgabe := 'a'; end;

  If (SprachVorgabe= 'e') or (SprachVorgabe= 'f') or (SprachVorgabe= 'a') then
  begin EdAWort.Text:= Vorgabedaten.AWort; EdDWort.Text:= ''; EdDWort.SetFocus; end else
  begin EdAWort.Text:= ''; EdDWort.Text:= Vorgabedaten.DWort; EdAWort.SetFocus; end;

  {Warten auf KeyPress...}
end;

procedure TTrainingsfenster.NullSeitenAnzeige;
var
  ZeroC: Integer;
begin
  if not f_unbekannteSpeichern then
    exit;

  If Zeroliste.Count-1 <0 then
    ZeroC:= 0
  else
    ZeroC:= Zeroliste.Count-1;

  LaNullSeite.Caption:= 'NullSeite: '+IntToStr(ZeroC)+' Wörter  ';
end;


procedure TTrainingsfenster.MachAuswahlreihe;
var
  Loop, UebungsZL, ArbeitsZL, Wert: Integer;
begin
  Randomize;
  ArbeitsZL:= 0;
  UebungsZL:= VorgabenRekord.UebgWZL;
  try
    If UebungsZL > Wortliste.Count-1 then UebungsZL:= Wortliste.Count-1;
    Repeat
      Wert:= Random(Wortliste.Count-1)+1;                          {darf nicht Null sein}
      For Loop := 1 to (ArbeitsZL+1) do if Wert = Auswahlreihe[Loop] then Wert:= 99;
      If Wert <> 99 then
      begin
        inc(ArbeitsZL); Auswahlreihe[ArbeitsZL]:= Wert;
      end;
    until (ArbeitsZL = UebungsZL);
  except
    ShowMessage('Auswahlreihe kann nicht erstellt werden');
    Halt;
  end;
  For Loop := 1 to 40 do             {Fehlwortarraylöschen}
  begin
    Fehlwortarr[Loop].Fehlwort:= '';
    FehlwortArr[Loop].FehlZL:= 0;
  end;
  WortZl:= ArbeitsZL    {WortZL: UTrainingbildfenster, private}
end;


procedure TTrainingsfenster.EdAWortKeyPress(Sender: TObject;
  var Key: Char);
begin
  If VorgabenRekord.Sprache = 'f' then  Key:= FranzBuchstaben(Key);{aendert deutsche Tasten in FranzBuchstaben}
  If Key = #13 then
  begin
    If not f_zeigeKorrektesWortAn then
      AuswertungA     {wenn richtig}
    else
    begin                                    {wenn falsch}
      LaKAWort.Caption:= '';
      f_zeigeKorrektesWortAn:= false;
      Trainingweiter;
    end;
    Key:= #0;
  end;
end;


procedure TTrainingsfenster.EdDWortKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Key = #13 then
  begin
    if not f_zeigeKorrektesWortAn then
      AuswertungD
    else
    begin
      LaKDWort.Caption:= '';
      f_zeigeKorrektesWortAn:= false;
      Trainingweiter;
    end;
    Key:= #0;
  end;
end;


procedure TTrainingsfenster.AuswertungA;
begin
  If Trim(EdAWort.Text) = Trim(Vorgabedaten.AWort) then                    {if richtig:}
  begin
    {OkSound;}
    f_zeigeKorrektesWortAn:= false;
    UpdateAuswahlreihe;
  end
  else
  begin                                                   {if falsch:}
    inc(FalschWortZl);
    InFehlwortListe(Vorgabedaten.AWort);
    LaKAWort.Caption:= Vorgabedaten.AWort;
    f_zeigeKorrektesWortAn:= true;
    UpdateAuswahlreihe;
    If SeiteNr <> 0 then
      InZeroliste;
    {FalseSound; }
  end;
end;


procedure TTrainingsfenster.AuswertungD;
begin
  If Trim(EdDWort.Text) = Trim(Vorgabedaten.DWort) then                     {if richtig:}
    begin
      {OkSound; }
      f_zeigeKorrektesWortAn:= false;
      UpdateAuswahlreihe;
    end
  else
  begin                                                    {if falsch:}
    {FalseSound; }
    inc(FalschWortZl);
    InFehlwortListe(Vorgabedaten.DWort);
    LaKDWort.Caption:= Vorgabedaten.DWort;
    f_zeigeKorrektesWortAn:= true;
    UpdateAuswahlreihe;
    If VorgabenRekord.Sprache = 'e' then if VorgabenRekord.SeitArrE[1]<> 0 then InZeroliste;
    If VorgabenRekord.Sprache = 'f' then if VorgabenRekord.SeitArrF[1]<> 0 then InZeroliste;
  end;
end;


procedure TTrainingsfenster.Trainingweiter;
var
  SNr: Integer;
begin
  NullSeitenAnzeige;
  If WortZl > 0 then Trainingsvorgabe else
  begin
    If VorgabenRekord.Sprache = 'e' then
      SNr:= VorgabenRekord.SeitArrE[1];

    If VorgabenRekord.Sprache = 'f' then
      SNr:= VorgabenRekord.SeitArrF[1];

    If FalschWortZl = 0 then AusArbeitArray(SNr);   {loescht Seiteneintrag}

    if SNr <> 0 then
      Trainingsende
    else
      NullseitenTrainingsEnde;
  end;
end;


procedure TTrainingsfenster.TrainingsEnde;
begin
  UpdateInfoRekord;
  PaTraining.Visible:= false;  //Trainingspanel wird ausgeblendet
  ZeigErgebnisse;
  Rahmenfenster.MachSeitenmenu;
  ErgebnisseUndDateiSpeichern(SeiteNr);

  if f_unbekannteSpeichern then
  begin
    If ZeroListe.Count < 1 then
      NullseiteLeerSpeichern
    else
      NullseiteAusZerolisteSpeichern;
  end;

  bTraining:= false;           //Trainingsprozess inaktiv
  close;
end;


procedure TTrainingsfenster.UpdateAuswahlreihe;
var
  Anzahl, Loop, Ret: Integer;
begin
  Anzahl:= WortListe.Count;
  Ret:= Auswahlreihe[1];
  For Loop:= 1 to Anzahl do
    If Auswahlreihe[Loop]<>0 then WortZl:= Loop;
  For Loop:= 1 to WortZl do
    Auswahlreihe[Loop]:= Auswahlreihe[Loop+1];
  If not f_zeigeKorrektesWortAn then
  begin
    Auswahlreihe[WortZl]:= 0; dec(WortZl);
    Trainingweiter;
  end
  else Auswahlreihe[WortZl]:= Ret;
end;


procedure TTrainingsfenster.InFehlwortListe(p_Wort: String);
var
  Anz: Integer;
begin
  Anz:= 1;
  Repeat

    //bereits falsch geübt, also inc FehlZL
    If (p_Wort<>'') and (p_Wort = FehlWortArr[Anz].Fehlwort) then
    begin
      inc(FehlWortArr[Anz].FehlZL);
      p_Wort:= '';
    end;

    //neu falsch geübt, wird angehängt
    If (p_Wort<>'') and (FehlWortArr[Anz].Fehlwort = '') then
    begin
      FehlWortArr[Anz].Fehlwort:= p_Wort;
      p_Wort:= '';

      If FehlwortArr[Anz].FehlZL > FehlwortListenZl then
        MaxFehlwort:= FehlwortArr[Anz].Fehlwort;            //FehlSieger gesucht
      inc(FehlWortArr[Anz].FehlZL);
    end;

    If (p_Wort<>'')and(FehlwortArr[Anz].FehlZL > FehlwortListenZl) then
    begin
      FehlwortListenZl := FehlwortArr[Anz].FehlZL;
      MaxFehlwort:= FehlwortArr[Anz].Fehlwort;             //Höchste Fehlerzahl gesucht
    end;

    inc(Anz);

  until (FehlWortArr[Anz-1].Fehlwort = '') or (Anz = 39);
end;


procedure TTrainingsfenster.InZeroListe;

var
  wortInListe : TWortRekord;

begin
  if not f_unbekannteSpeichern then
    exit;

  If Zeroliste = nil then Zeroliste := TList.Create;
  If ZeroListe.Count = 0 then
  begin
    ZeroDatenRekord:= TWortRekord.Create;
    ZeroDatenRekord.AWort:= '';
    ZeroDatenRekord.DWort:= '';          {Das Null-Item bleibt leer:}
    ZeroListe.Add(ZeroDatenRekord);      {Leeranzeige, wenn Einträge über- oder unterschritten werden}
  end;

  // Ist das Wort schon vorhanden kommt es nicht nochmal dazu!
  for wortInListe in Zeroliste do
  begin
    if (wortInListe.AWort = Vorgabedaten.AWort) and
       (wortInListe.DWort = Vorgabedaten.DWort) then
    exit;
  end;

  If Zeroliste.Count <= VorgabenRekord.UebgWZl then
  begin
    ZeroDatenRekord:= TWortRekord.Create;
    ZeroDatenRekord.AWort:= Vorgabedaten.AWort;
    ZeroDatenRekord.DWort:= Vorgabedaten.DWort;
    ZeroDatenRekord.Sprache:= SprachVorgabe;
    Zeroliste.Add(ZeroDatenRekord);
  end;
end;


procedure TTrainingsFenster.UpdateInfoRekord;
var
  ZL, Loop, InfoZl: Integer;
  SDat, SZeit: String[18];
  SFehl, SSek, SMin: String[2];
  SMaxW: String[40];
  ZeitWrd: TDateTime;
  EndStd, EndMin, EndSek, EndMSek: Word;
begin
  {.........................Zeiterfassung und -auswertung............}
  InfoZl:= 0;
  ZeitWrd:= Now;
  DecodeTime(ZeitWrd, EndStd, EndMin, EndSek, EndMSek);
  If EndSek < StartZeitArr[3] then
    begin EndSek:= EndSek+60; inc(StartZeitArr[2]); end;
  SSek := IntToStr(EndSek-StartZeitArr[3]);
  If EndMin < StartZeitArr[2] then EndMin:= EndMin+60;
  SMin := IntToStr(EndMin-StartZeitArr[2]);
  SZeit:= SMin+'  Min.  '+SSek+'  Sek.';
  {..................................................................}
  With InfoRekord do
  begin
    For ZL:= 1 to 10 do if DatArr[ZL] <> '' then InfoZL:= ZL;
    SDat := FormatDateTime('dd. mmmm yy', Date);
    SFehl:= IntToStr(FalschWortZl);
    SMaxW:= MaxFehlWort;
{-------------------------------falls alle Zeilen beschrieben sind-----}
{-} If InfoZL = 10 then                                              {-}
{-} begin                                                            {-}
{-}   For Loop := 2 to 10 do begin                                   {-}
{-}     DatArr[Loop-1]:= DatArr[Loop];                               {-}
{-}     ZeitArr[Loop-1]:= Zeitarr[Loop];                             {-}
{-}     FehlArr[Loop-1]:= FehlArr[Loop];                             {-}
{-}     FLWortArr[Loop-1]:= FLwortArr[Loop];                         {-}
{-}   end;                                                           {-}
{-}   InfoZL:= 9;                                                    {-}
{-} end;                                                             {-}
{----------------------------------------------------------------------}
    begin
      DatArr[InfoZL+1]:= SDat;
      ZeitArr[InfoZL+1]:= SZeit;
      FehlArr[InfoZL+1]:= SFehl;
      FlWortArr[InfoZL+1]:= SMaxW;
    end;
  end;
end;


procedure TTrainingsfenster.NullseiteLeerSpeichern;
var
  Stream : TFileStream;
  Datnam: String[12];
begin
  If VorgabenRekord.Sprache = 'e' then Datnam := 'Seite0.dte';
  If VorgabenRekord.Sprache = 'f' then Datnam := 'Seite0.dtf';
  Stream := TFileStream.Create(Datnam, fmCreate);
  Stream.Free;
  Zeroliste.free;
  Zeroliste:= TList.Create;
end;


procedure TTrainingsfenster.NullseitenTrainingsEnde;
begin
  PaTraining.Visible:= false;  //Trainingspanel wird ausgeblendet

  if Application.MessageBox(PChar('Nullseite löschen?'), 'Nullseite löschen?',
    MB_YESNO or MB_DEFBUTTON2 or MB_ICONQUESTION) = IDYES then

//  If MessageDlgPos('Nullseite behalten?',mtConfirmation, [mbNo, mbYes], 0, 200, 500) <> mrYes then // 0, 100, 700  => 21' Monitor
  //  NullSeiteLeerSpeichern;
  close;
  bTraining:= false;           //Trainingsprozess inaktiv
  Geuebt:= true;
end;



procedure TTrainingsfenster.Exit1Click(Sender: TObject);
begin
  Trainingsfenster.Close
end;


procedure TTrainingsfenster.Bilderwahl;
var
  SearchRec: TSearchRec;
  ZL: Integer;
begin
  ZL:= 1;
  FindFirst('*.bmp', faAnyFile, SearchRec);
  BildArray[ZL]:= SearchRec.Name;
    While (FindNext(SearchRec) = 0) and (ZL < 100) do begin
    inc(Zl); BildArray[ZL]:= SearchRec.Name;
  end;
  BildZL:= ZL;                                // BildZL : Anzahl vorhandener Bilder
  Randomize; BildNr:= Random(ZL)+1;
  Bildname:= BildArray[BildNr];

  try
    Image1.Picture.LoadFromFile(Bildname);
  except ShowMessage('der Bildname ' + Bildname + 'enthält einen Fehler!');
  end;

  BildTitel:= Copy(Bildname, 0, Pos('.', Bildname)-1);      //Bildname ohne Suffix
  Trainingsfenster.Caption := 'Seite '+IntToStr(SeiteNr)+ '    '+Bildtitel;

  If Image1.Picture.Width > Image1.Picture.Height then
  begin
    Image1.Width:= 767;
    Image1.Height:= 550;                          //Querformat
    Image1.left:= 600;
  end

  else begin
    Image1.Left:= 600;
    Image1.Width:= 570;                             //Hochformat
    Image1.Height:= 747
  end;
end;

end.



