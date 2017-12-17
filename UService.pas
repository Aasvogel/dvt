unit UService;
interface

uses WinProcs, WinTypes, SysUtils, Classes, Dialogs;

type
  TvorgabenRekord = class
    SeitArrE: array[1..5]of Integer;   {akt.Anzeige/vor Klammer/1,2,3 in Klammer}
    SeitArrF: array[1..5]of Integer;   {akt.Anzeige/vor Klammer/1,2,3 in Klammer}
    SeitArrL: array[1..5]of Integer;   {akt.Anzeige/vor Klammer/1,2,3 in Klammer}
    InArbeitArrE: array[1..10]of Integer;
    InArbeitArrF: array[1..10]of Integer;
    InArbeitArrL: array[1..10]of Integer;
    UebgWZl: Integer;
    Bild: Integer;        {Training mit Bild?}
    Piep: Char;           {'p',  #0}
    Laut: Char;           {'l',  #0}
    Sprache: Char;        {'e', 'f', l}
    procedure   WriteToStream(AWriter: TWriter);
    constructor ReadFromStream(AReader: TReader);
  end;

  TWortRekord = class
      AWort: String[40];
      DWort: String[40];
      SortAWort: String[40];
      SortDWort: String[40];
      Sprache: Char;
      procedure   WriteToStream(AWriter: TWriter);
      constructor ReadFromStream(AReader: TReader);
   end;

  TInfoRekord = class
    DatArr: array[1..10]of String;
    ZeitArr: array[1..10]of String;
    FehlArr: array[1..10]of String[2];
    FLWortArr: array[1..10]of String;
    procedure   WriteToStream(AWriter: TWriter);
    constructor ReadFromStream(AReader: TReader);
  end;


function  SortierformatDWort(S: string): string;
function  SortierformatAWort(S: string): string;
function  MachSortAWort(Aenderwort: string): string;
function  FranzBuchstaben(DBuchst: Char): Char;
procedure LexikonLaden(DateinameL: string);
procedure LexikonSpeichern(Sprache: String);
procedure VorgabenLaden(VorgabenDatei: String);
procedure VorgabenSpeichern(DatNam: String);
procedure Hilfebox;
function  FindAWortPosition(SuchWort: String): Integer;
function  FindDWortPosition(SuchWort: String): Integer;
procedure ErgebnisseUndDateiLaden(Dateiname: String);
procedure ErgebnisseLaden(Dateiname: String);
procedure NullseiteLaden;
procedure NullseiteInWortlisteLaden;
procedure ErgebnisseundDateiSpeichern(SeiteNr: Integer);
procedure ErgebnisseundLeerDateiSpeichern(DatNam: String);
procedure NullseiteAusZerolisteSpeichern;
procedure ZuArbeitarray(Nr: Integer);
procedure AusArbeitArray(Nr: Integer); {loescht Seiteneintrag}
function  DateiWert(Dateiname: String): Integer;
procedure MachLeerDateiErgebn;
procedure MachDeutschListe;

var
  InfoRekord: TInfoRekord;
  WortRekord: TWortRekord;
  WortListe, LexikonListe, ZeroListe, Deutschliste: TList;
  StartZeitArr: Array[1..3]of Word;
  VorgabenRekord: TVorgabenrekord;
  Dateiname, Bildname: string;
  bEnglisch, bFranzsisch, bLatein, bTraining: Boolean;
  WortZl, BildNr: Integer;
  bAVorhanden, bDVorhanden: boolean;

{~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~}

implementation

uses URahmenfenster;

procedure TvorgabenRekord.WriteToStream(AWriter: TWriter);
var
  ZL: Byte;
begin
  For ZL:= 1 to 5 do AWriter.WriteInteger(SeitArrE[ZL]);
  For ZL:= 1 to 5 do AWriter.WriteInteger(SeitArrF[ZL]);
  For ZL:= 1 to 5 do AWriter.WriteInteger(SeitArrL[ZL]);
  For ZL:= 1 to 10 do AWriter.WriteInteger(InArbeitArrE[ZL]);
  For ZL:= 1 to 10 do AWriter.WriteInteger(InArbeitArrF[ZL]);
  For ZL:= 1 to 10 do AWriter.WriteInteger(InArbeitArrL[ZL]);
  AWriter.WriteInteger(UebgWZl);
  AWriter.WriteInteger(Bild);
  AWriter.WriteChar(Piep);
  AWriter.WriteChar(Laut);
  AWriter.WriteChar(Sprache);
end;

constructor TVorgabenRekord.ReadFromStream(AReader: TReader);
var
  ZL: Byte;
begin
  inherited Create;
  For ZL:= 1 to 5 do SeitArrE[ZL] := AReader.ReadInteger;
  For ZL:= 1 to 5 do SeitArrF[ZL] := AReader.ReadInteger;
  For ZL:= 1 to 5 do SeitArrL[ZL] := AReader.ReadInteger;
  For ZL:= 1 to 10 do InArbeitArrE[ZL]:= AReader.ReadInteger;
  For ZL:= 1 to 10 do InArbeitArrF[ZL]:= AReader.ReadInteger;
  For ZL:= 1 to 10 do InArbeitArrL[ZL]:= AReader.ReadInteger;
  UebgWZl:= AReader.ReadInteger;
  Bild:= AReader.ReadInteger;
  Piep := AReader.ReadChar;
  Laut := AReader.ReadChar;
  Sprache := AReader.ReadChar;
end;

{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}
procedure TInfoRekord.WriteToStream(AWriter: TWriter);
var
  ZL: Byte;
begin
  For ZL:= 1 to 10 do AWriter.WriteString(DatArr[ZL]);
  For ZL:= 1 to 10 do AWriter.WriteString(ZeitArr[ZL]);
  For ZL:= 1 to 10 do AWriter.WriteString(FehlArr[ZL]);
  For ZL:= 1 to 10 do AWriter.WriteString(FLWortArr[ZL]);
end;

constructor TInfoRekord.ReadFromStream(AReader: TReader);
var
  ZL: Byte;
begin
  inherited Create;
  For ZL:= 1 to 10 do DatArr[ZL]:= AReader.ReadString;
  For ZL:= 1 to 10 do ZeitArr[ZL]:= AReader.ReadString;
  For ZL:= 1 to 10 do FehlArr[ZL]:= AReader.ReadString;
  For ZL:= 1 to 10 do FLWortArr[ZL]:= AReader.ReadString;
end;

procedure TWortRekord.WriteToStream(AWriter: TWriter);
begin
  AWriter.WriteString(AWort);
  AWriter.WriteString(DWort);
  AWriter.WriteString(SortAWort);
  AWriter.WriteString(SortDWort);
  AWriter.WriteChar(Sprache);
end;

constructor TWortRekord.ReadFromStream(AReader: TReader);
begin
  inherited Create;
  AWort:= AReader.ReadString;
  DWort:= AReader.ReadString;
  SortAWort:= AReader.ReadString;
  SortDWort:= AReader.ReadString;
  Sprache:= AReader.ReadChar;
end;


{=========================================================================}

function FillBackSlash(AStr: TFileName): TFileName;
begin
  if AStr[Length(AStr)] <> '\' then
     Result := AStr + '\'
  else
     Result := AStr;
end;



function SortierformatAWort(S: string): string;
var
  ZL: Integer;
begin
  If VorgabenRekord.Sprache = 'e' then
  begin
    If (Copy(S, 1, 2) = 's''') or (Copy(S, 1, 2) = 'a ')
      then S:= Copy(S,3, length(S)-2);
    If (Copy(S, 1, 3) = 'an ') or (Copy(S, 1, 3) = 'to ')
      then S:= Copy(S,4, length(S)-3);
    If (Copy(S, 1, 4) = 'the ')
      then S:= Copy(S,5, length(S)-4);
    For ZL:= length(S) downto 1 do
       If (Copy(S, Zl, 1) = ' ') or (Copy(S, Zl, 1) = '''')
       then Delete(S, Zl, 1);             {Leerzeichen und Apostroph wegfiltern}
  end;
  If VorgabenRekord.Sprache = 'f' then
  begin
    For ZL:= 1 to length(S) do
    begin
      If S[ZL] = 'é' then S[ZL]:= 'e';
      If S[ZL] = 'ê' then S[ZL]:= 'e';
      If S[ZL] = 'è' then S[ZL]:= 'e';
      If S[ZL] = 'â' then S[ZL]:= 'a';
      If S[ZL] = 'à' then S[ZL]:= 'a';
      If S[ZL] = 'î' then S[ZL]:= 'i';
      If S[ZL] = 'ï' then S[ZL]:= 'i';
      If S[ZL] = 'ô' then S[ZL]:= 'o';
      If S[ZL] = 'û' then S[ZL]:= 'u';
      If S[ZL] = 'ç' then S[ZL]:= 'c';
    end;
    If (Copy(S, 1, 3) = 'la ') or (Copy(S, 1, 3) = 'le ') or (Copy(S, 1, 3) = 'se ')
      or (Copy(S, 1, 3) = 'un ')
      then S:= Copy(S,4, length(S)-3);
    If (Copy(S, 1, 4) = 'les ') or (Copy(S, 1, 4) = 'une ')
      or (Copy(S, 1, 4) = 'a l''')
      then S:= Copy(S,5, length(S)-4);
    If (Copy(S, 1, 2) = 's''') or(Copy(S, 1, 2) = 'a''')
      then S:= Copy(S,3, length(S)-2);
    For ZL:= length(S) downto 1 do
       If (Copy(S, Zl, 1) = ' ') or (Copy(S, Zl, 1) = '''') or (Copy(S, Zl, 1) = '-')
       then Delete(S, Zl, 1);             {Leerzeichen und Apostroph wegfiltern}
  end;
  SortierformatAWort:= LowerCase(S);
end;


function MachSortAWort(Aenderwort: string): string;
var
  ZL: Integer;
begin
  For ZL:= 1 to length(Aenderwort) do
  begin
    If Aenderwort[ZL] = 'é' then Aenderwort[ZL]:= 'e';
    If Aenderwort[ZL] = 'ê' then Aenderwort[ZL]:= 'e';
    If Aenderwort[ZL] = 'è' then Aenderwort[ZL]:= 'e';
    If Aenderwort[ZL] = 'â' then Aenderwort[ZL]:= 'a';
    If Aenderwort[ZL] = 'à' then Aenderwort[ZL]:= 'a';
    If Aenderwort[ZL] = 'î' then Aenderwort[ZL]:= 'i';
    If Aenderwort[ZL] = 'ï' then Aenderwort[ZL]:= 'i';
    If Aenderwort[ZL] = 'ô' then Aenderwort[ZL]:= 'o';
    If Aenderwort[ZL] = 'û' then Aenderwort[ZL]:= 'u';
    If Aenderwort[ZL] = 'ç' then Aenderwort[ZL]:= 'c';
  end;
  Aenderwort:= LowerCase(Aenderwort);
  MachSortAWort:= Aenderwort;
end;


function FranzBuchstaben(DBuchst: Char): Char;
begin
  FranzBuchstaben:= DBuchst;
  Case DBuchst of
    'ä' : FranzBuchstaben := 'é';
    'Ä' : FranzBuchstaben := 'ê';
    'ü' : FranzBuchstaben := 'è';
    '>' : FranzBuchstaben := 'â';
    'ö' : FranzBuchstaben := 'à';
    '*' : FranzBuchstaben := 'î';
    '+' : FranzBuchstaben := 'ï';
    'Ö' : FranzBuchstaben := 'ô';
    'Ü' : FranzBuchstaben := 'û';
    'ß' : FranzBuchstaben := 'ç';
  end;
end;

function SortierformatDWort(S: string): string;
var
  ZL: Integer;
begin
  begin
    If (Copy(S, 1, 5) = 'eine ')
      then S:= Copy(S,6, length(S)-5);

    If (Copy(S, 1, 4) = 'der ') or (Copy(S, 1, 4) = 'die ')or (Copy(S, 1, 4) = 'das ')
      or (Copy(S, 1, 4) = 'ein ')
      then S:= Copy(S,5, length(S)-4);
    If (Copy(S, 1, 2) = 's''')
      then S:= Copy(S,3, length(S)-2);

    For ZL:= length(S) downto 1 do
      begin
        If (Copy(S, Zl, 1) = ' ') or (Copy(S, Zl, 1) = '''')
          or (Copy(S, Zl, 1) = '.') or (Copy(S, Zl, 1) = '-')or (Copy(S, Zl, 1) = ',')
          then Delete(S, Zl, 1);             {Leerzeichen und Apostroph wegfiltern}
        If (Copy(S, Zl, 1) = 'ä') or (Copy(S, Zl, 1) = 'Ä')then
              begin Delete(S, ZL, 1); Insert('ae', S, ZL); end;
        If (Copy(S, Zl, 1) = 'ö') or (Copy(S, Zl, 1) = 'Ö')then
              begin Delete(S, ZL, 1); Insert('oe', S, ZL); end;
        If (Copy(S, Zl, 1) = 'ü') or (Copy(S, Zl, 1) = 'Ü')then
              begin Delete(S, ZL, 1); Insert('ue', S, ZL); end;
        If (Copy(S, Zl, 1) = 'ß') then begin Delete(S, ZL, 1); Insert('ss', S, ZL); end;
      end;
  end;
  SortierformatDWort:= LowerCase(S);
end;


procedure LexikonLaden(DateinameL: string);
var
  Stream: TFileStream;
  Reader: TReader;
begin
  Try
    Lexikonliste:= TList.Create;
    Stream := TFileStream.Create(FillBackSlash(ExtractFilePath(ParamStr(0)))+ DateinameL, fmOpenRead);
    Reader:= TReader.Create(Stream, 1024);
    Reader.ReadListBegin;
    while not Reader.EndOfList do
      LexikonListe.Add(TWortRekord.ReadFromStream(Reader));
    Reader.ReadListEnd;
    Reader.Free;
    Stream.Free;
  except
    ShowMessage('Das Lexikon '+DateinameL+ ' gibt es nicht!');
    Halt;
  end;
end;


procedure LexikonSpeichern(Sprache:String);
var
  Stream, DatStream: TFileStream;
  Writer: TWriter;
  s, DateinameL: string[12];
  ZL: Integer;
begin
  If Sprache = 'e' then DateinameL:= 'Lexikon.elx';
  If Sprache = 'f' then DateinameL:= 'Lexikon.flx';

  Stream := TFileStream.Create(FillBackSlash(ExtractFilePath(ParamStr(0)))+ DateinameL, fmCreate);
  Writer := TWriter.Create(Stream, 1024);
  Writer.WriteListBegin;                         	  { Listenanfangsmarke schreiben }
  For ZL:= 0  to LexikonListe.Count-1 do
  begin
      TWortRekord(LexikonListe.Items[ZL]).WriteToStream(Writer);
  end;
  Writer.WriteListEnd;	                                  { Listenendemarke schreiben }
  Writer.Free;
  Stream.Free;

  If Sprache = 'e' then s:= FormatDateTime('ddmmmyy', Now)+'.elx';
  If Sprache = 'f' then s:= FormatDateTime('ddmmmyy', Now)+'.flx';

  DatStream := TFileStream.Create(FillBackSlash(ExtractFilePath(ParamStr(0)))+ s, fmCreate);
  Writer := TWriter.Create(DatStream, 1024);
  Writer.WriteListBegin;                         	  { Listenanfangsmarke schreiben }
  For ZL:= 0  to LexikonListe.Count-1 do
  begin
      TWortRekord(LexikonListe.Items[ZL]).WriteToStream(Writer);
  end;
  Writer.WriteListEnd;	                                  { Listenendemarke schreiben }
  Writer.Free;
  DatStream.Free;
end;



procedure VorgabenLaden(VorgabenDatei: String);
var
  Reader: TReader;
  Stream: TFileStream;
begin
  Stream:= TFileStream.Create(FillBackSlash(ExtractFilePath(ParamStr(0))) +
                                                          VorgabenDatei, fmOpenRead);
  Reader := TReader.Create(Stream, 1024);
  VorgabenRekord:= TVorgabenRekord.ReadFromStream(Reader);
  Reader.Free;
  Stream.Free;
  With VorgabenRekord do
  begin
    If Sprache = 'e' then Dateiname:= 'Seite'+IntToStr(SeitArrE[1])+'.dte';
    If Sprache = 'f' then Dateiname:= 'Seite'+IntToStr(SeitArrF[1])+'.dtf';
  end;
end;


procedure VorgabenSpeichern(DatNam: String);
var
  Writer: TWriter;
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(FillBackSlash(ExtractFilePath(ParamStr(0)))+
                                                          DatNam, fmCreate);
  Writer := TWriter.Create(Stream, 1024);
  TVorgabenRekord(VorgabenRekord).WriteToStream(Writer);
  Writer.Free;
  Stream.Free;
end;



procedure Hilfebox;
begin
  messagebox
  (0, #13 + '       é -> ä'+ #13 +'       â -> >'+ #13 +'       à -> ö' + #13 +
  '       ê -> Ä'+ #13 + '       è -> ü'+ #13 + '       î -> *' + #13+ '       ï -> +'+
  #13 + '       ô -> Ö' + #13 + '       û -> Ü'+ #13 + '       ç -> ß' + #13,
  ' Französische Buchstaben:',MB_IconInformation);
end;


function  FindAWortPosition(SuchWort: String): Integer;
var
  ZL, PosZL: Integer;
begin
  SuchWort:= SortierformatAWort(Suchwort);
  {-------SuchAWortPosition----------------------------------------------}
  For ZL:= LexikonListe.Count-1 downto 0 do
  begin
    if TWortRekord(LexikonListe[ZL]).SortAWort >= Suchwort then PosZL:= ZL;
  end;
  {----------------------------------------------------------------------}
  if TWortRekord(LexikonListe[PosZL]).SortAWort = Suchwort then bAVorhanden := true;
  FindAWortPosition:= PosZL;
end;


function FindDWortPosition(Suchwort: String): Integer;
{Ergebnis: gesuchte Position ist gleich oder größer vorhandenem Wort}
          {Grenzfälle: Suchwort gleich vorhandenes Wort / Suchwort größer letztes Listenwort}
var
  Sprung: Word;
  SuchSortwort: String;
  PosZl: Integer;
begin
  SuchSortwort:= SortierformatDWort(Suchwort);
  Sprung:= (Deutschliste.Count-1) shr 1 ;
  PosZl := Sprung;
  While Sprung > 0 do
  begin
    Sprung:= Sprung shr 1;
    If SuchSortwort > TWortRekord(DeutschListe.Items[PosZl]).SortDWort
      then inc(PosZl, Sprung) else dec(PosZl, Sprung);
  end;
    While (SuchSortwort < TWortRekord(DeutschListe.Items[PosZl]).SortDWort)
           and (PosZl > 0) do dec(PosZl);
    While (SuchSortwort > TWortRekord(DeutschListe.Items[PosZl]).SortDWort)
           and (PosZl < Deutschliste.Count-1) do inc(PosZl);
  FindDWortPosition:= PosZl;
end;



procedure ErgebnisseundDateiSpeichern(SeiteNr: Integer);
var
  Dateiname1: string;
  ZL: Byte;
  Writer: TWriter;
  Stream: TFileStream;
  InfoListe: TList;
begin
  If VorgabenRekord.Sprache = 'e' then Dateiname1:= 'Seite'+IntToStr(SeiteNr)+'.dte';
  If VorgabenRekord.Sprache = 'f' then Dateiname1:= 'Seite'+IntToStr(SeiteNr)+'.dtf';
  Stream := TFileStream.Create(Dateiname1, fmCreate);
  Writer := TWriter.Create(Stream, 1024);
  Writer.WriteListBegin;

  InfoListe:= TList.Create;
  InfoListe.Add(InfoRekord);
  TInfoRekord(InfoListe.Items[0]).WriteToStream(Writer);
  For ZL:= 0 to WortListe.Count-1 do TWortRekord(WortListe.Items[ZL]).WriteToStream(Writer);

  Writer.WriteListEnd;
  Writer.Free;
  Stream.Free;
end;


procedure ErgebnisseundLeerDateiSpeichern(DatNam: String);
var
  Writer: TWriter;
  Stream: TFileStream;
  InfoListe: TList;
  PlatzhalterRekord: TWortRekord;
begin
  Stream := TFileStream.Create(DatNam, fmCreate);
  Writer := TWriter.Create(Stream, 1024);
  Writer.WriteListBegin;

  InfoListe:= TList.Create;
  InfoListe.Add(InfoRekord);
  TInfoRekord(InfoListe.Items[0]).WriteToStream(Writer);

  PlatzhalterRekord:= TWortRekord.Create;
  PlatzhalterRekord.AWort:= '';PlatzhalterRekord.DWort:= '';
  TWortRekord(PlatzhalterRekord).WriteToStream(Writer);

  Writer.WriteListEnd;
  Writer.Free;
  Stream.Free;
end;


procedure NullseiteAusZerolisteSpeichern;
var
  DateinameAZ: string;
  ZL: Byte;
  Writer: TWriter;
  Stream: TFileStream;
  InfoListe: TList;
begin
  If VorgabenRekord.Sprache = 'e' then DateinameAZ:= 'Seite0.dte';
  If VorgabenRekord.Sprache = 'f' then DateinameAZ:= 'Seite0.dtf';
  Stream := TFileStream.Create(DateinameAZ, fmCreate);
  Writer := TWriter.Create(Stream, 1024);
  Writer.WriteListBegin;

  InfoListe:= TList.Create;
  InfoListe.Add(InfoRekord);
  TInfoRekord(InfoListe.Items[0]).WriteToStream(Writer);

  For ZL:= 0 to ZeroListe.Count-1 do TWortRekord(ZeroListe.Items[ZL]).WriteToStream(Writer);
  Writer.WriteListEnd;
  Writer.Free;
  Stream.Free;
end;


procedure ErgebnisseUndDateiLaden(Dateiname: String);
var
  Reader : TReader;
  Stream : TFileStream;
  WortDaten: TWortRekord;
  ZeitWrd: TDateTime;
  Std, Min, Sek, MSek: Word;
begin
  Wortliste:= TList.Create;
  Stream:= TFileStream.Create(FillBackSlash(ExtractFilePath(ParamStr(0)))
    + Dateiname, fmOpenRead);
  Reader := TReader.Create(Stream, 1024);
{  try}
    Reader.ReadListBegin;
{  except
    on EStreamError do ShowMessage('Keine Worte in '+Dateiname);
  end;                                                          }
    InfoRekord:= TInfoRekord.ReadFromStream(Reader);
  {----------------------------------Datei laden---------------------------------}
  try
    While not Reader.EndOfList do
    begin
      WortDaten := TWortRekord.ReadFromStream(Reader);
      WortListe.Add(WortDaten);
    end;
  except
    ShowMessage('Fehler beim Laden der Wörter von Datei '+Dateiname);
  end;

  Reader.Free;
  Stream.Free;

  ZeitWrd:= Now;
  DecodeTime(ZeitWrd, Std, Min, Sek, MSek);
  StartZeitArr[1]:= Std;
  StartZeitArr[2]:= Min;
  StartZeitArr[3]:= Sek;
end;



procedure ErgebnisseLaden(Dateiname: String);
var
  Reader : TReader;
  Stream : TFileStream;
begin
  Stream:= TFileStream.Create(FillBackSlash(ExtractFilePath(ParamStr(0)))
    + Dateiname, fmOpenRead);
  Reader := TReader.Create(Stream, 1024);
  Reader.ReadListBegin;
  InfoRekord:= TInfoRekord.ReadFromStream(Reader);
  Reader.Free;
  Stream.Free;
end;

{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

procedure NullseiteLaden;
var
  DateinameZ: string;
  Reader : TReader;
  Stream : TFileStream;
  WortDaten: TWortRekord;
begin
  If VorgabenRekord.Sprache = 'e' then DateinameZ:= 'Seite0.dte';
  If VorgabenRekord.Sprache = 'f' then DateinameZ:= 'Seite0.dtf';

  ZeroListe:= TList.Create;
  Stream:= TFileStream.Create(FillBackSlash(ExtractFilePath(ParamStr(0)))
    + DateinameZ, fmOpenRead);
  Reader := TReader.Create(Stream, 1024);
  try
    Reader.ReadListBegin;
  {----------------------------------Datei laden---------------------------------}
    InfoRekord:= TInfoRekord.ReadFromStream(Reader); {wegen abgespeichertem Format}
    While not Reader.EndOfList do
    begin
      WortDaten := TWortRekord.ReadFromStream(Reader);
      ZeroListe.Add(WortDaten);
    end;
  except
    on EStreamError do ShowMessage('Keine Worte in '+DateinameZ);
  end;
  Reader.Free;
  Stream.Free;
end;


procedure NullseiteInWortlisteLaden;
var
  DateinameW: string;
  Reader : TReader;
  Stream : TFileStream;
  WortDaten: TWortRekord;
begin
  If VorgabenRekord.Sprache = 'e' then DateinameW:= 'Seite0.dte';
  If VorgabenRekord.Sprache = 'f' then DateinameW:= 'Seite0.dtf';
  WortListe:= TList.Create;
  Stream:= TFileStream.Create(FillBackSlash(ExtractFilePath(ParamStr(0)))
    + DateinameW, fmOpenRead);
  Reader := TReader.Create(Stream, 1024);
  Reader.ReadListBegin;
{----------------------------------Datei laden---------------------------------}
  InfoRekord:= TInfoRekord.ReadFromStream(Reader); {wegen abgespeichertem Format}
  try
    While not Reader.EndOfList do
    begin
      WortDaten := TWortRekord.ReadFromStream(Reader);
      WortListe.Add(WortDaten);
    end;
  except
    on EStreamError do ShowMessage('Keine Worte in '+DateinameW);
  end;
  Reader.Free;
  Stream.Free;
end;


procedure ZuArbeitArray(Nr: Integer);   //Nr = Seitenzahl
      {Wenn eine Seite geübt wird, dann kommt bei Trainingsbeginn
       die Seitennummer in das InArbeitArr "zur Zeit in Arbeit"}
var
  ZL, EintragZL: Integer;
begin
  EintragZL:= 0;

  If VorgabenRekord.Sprache = 'e' then
  begin
    For ZL:= 1 to 10 do
    begin
      If (VorgabenRekord.InArbeitArrE[ZL] <> 99) then EintragZL:= ZL;  {zählt, wieviele Einträge bereitsvorh}
      If VorgabenRekord.InArbeitArrE[ZL] = Nr then Nr:= 99;  {bingo wenn Eintrag schon vorhanden}
    end;
    if (EintragZL < 10) then VorgabenRekord.InArbeitArrE[EintragZL+1]:= Nr; {solange weniger als 10 Einträge vorhanden}
  end;

  If VorgabenRekord.Sprache = 'f' then
    begin
    For ZL:= 1 to 10 do
    begin
      If (VorgabenRekord.InArbeitArrF[ZL] <> 99) then EintragZL:= ZL;
      If VorgabenRekord.InArbeitArrF[ZL] = Nr then Nr:= 99;
    end;
    if (EintragZL < 10) then VorgabenRekord.InArbeitArrF[EintragZL+1]:= Nr; {solange weniger als 10 Einträge vorhanden}
  end;

end;


procedure AusArbeitArray(Nr: Integer); {loescht Seiteneintrag}
var
  ZL, PosZL: Integer;
begin                                  {falls bei Nullseite - warum?}
  PosZL:= 10;
  With VorgabenRekord do
  begin
    If Sprache = 'e' then
    begin
      For ZL:= 1 to 10 do If InArbeitArrE[ZL] = Nr then PosZL:= ZL;
      If PosZL = 10 then InArbeitArrE[10] := 99;
      If PosZL < 10 then for ZL:= PosZL to 9 do InArbeitArrE[ZL]:= InArbeitArrE[ZL+1];
    end;
    If Sprache = 'f' then
    begin
      For ZL:= 1 to 10 do If InArbeitArrF[ZL] = Nr then PosZL:= ZL;
      If PosZL = 10 then InArbeitArrF[10] := 99;
      If PosZL < 10 then for ZL:= PosZL to 9 do InArbeitArrF[ZL]:= InArbeitArrF[ZL+1];
    end;
  end;
end;



function DateiWert(Dateiname: String): Integer;
var
   f: file of Byte;
   size: Longint;
begin
  try
    AssignFile(f, Dateiname);
    Reset(f);
    size := FileSize(f);
    CloseFile(F);
    DateiWert := size;
  except DateiWert:= 12345; end;
end;



procedure MachLeerDateiErgebn;
var
  InfoListe: TList;
begin
  InfoListe:= TList.Create;
  InfoListe.Add(InfoRekord);
  Wortliste:= TList.Create;
  WortListe.Add(WortRekord);
end;



procedure MachDeutschListe;
var
  ZL: Word;
  Arbeitsrekord: TWortRekord;
  Gesamtzahl, Abstand, Zwischen, Loop: Word;
begin
{  Application.ProcessMessages;}

  Deutschliste:= TList.Create;
  For ZL:= 0 to LexikonListe.Count-1 do
  begin
    Arbeitsrekord:= LexikonListe.Items[ZL];
    Deutschliste.Add(Arbeitsrekord);
  end;
{......................................... und sortieren..............................}
  Gesamtzahl:= Deutschliste.Count-1;
  Abstand:= Gesamtzahl - (Gesamtzahl shr 1);
  While  Abstand > 0 do
  begin
    for Loop := 0 to (Gesamtzahl - Abstand) do
    begin
      Zwischen:= Loop;
      While (TWortRekord(Deutschliste.Items[Zwischen]).SortDWort >
          TWortRekord(Deutschliste.Items[Zwischen+Abstand]).SortDWort) do
      begin
        ArbeitsRekord:= TWortRekord(Deutschliste.Items[Zwischen]);
        Deutschliste.Items[Zwischen]:=Deutschliste.Items[Zwischen+Abstand];
        Deutschliste.Items[Zwischen+Abstand]:= ArbeitsRekord;
        if Zwischen > Abstand then dec(Zwischen, Abstand) else Zwischen:= 0;
      end;
    end;
    Abstand:= Abstand shr 1;
  end;
end;


end.
 {           Case DateiWert(Dateiname) of 200..12345: Showmessage(Dateiname+' ist ok');  //XXXXXXXXXXXXXXX
      else Nr:= 99;     //Datei nicht vorhanden oder leer                       //XXXXXXXXXXXXXXX
    end;        }

