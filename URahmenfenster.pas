unit URahmenfenster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, UService, ULexikon;

type
  TRahmenfenster = class(TForm)
    LabTitelGrau: TLabel;
    LabTitelWeiss: TLabel;
    Label2: TLabel;
    LabUebungsseite: TLabel;
    LaUebWoAnz: TLabel;
    LabNullseite: TLabel;
    pnlLoslegen: TPanel;
    Label5: TLabel;
    Label4: TLabel;
    PanWortzahl: TPanel;
    LaWortZl: TLabel;
    EdWortzahl: TEdit;
    PanSeitenzahl: TPanel;
    LabSeite: TLabel;
    EdSeite: TEdit;
    MainMenu1: TMainMenu;
    MenSeitenwahl: TMenuItem;
    Eingeben: TMenuItem;
    Wortzahl: TMenuItem;
    Trainieren: TMenuItem;
    Exit1: TMenuItem;
    Lexikon1: TMenuItem;
    DLexikon1: TMenuItem;
    InDateienSuchen1: TMenuItem;
    Optionen1: TMenuItem;
    MenHilfe: TMenuItem;
    Spracheenglisch1: TMenuItem;
    Sprachefranzsisch1: TMenuItem;
    Vorgaben1: TMenuItem;
    DoppelwrterA2: TMenuItem;
    D1: TMenuItem;
    pnlPanelholder: TPanel;
    pnlTrainieren: TPanel;
    pnlUebungsmodus: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure TrainierenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure WortzahlClick(Sender: TObject);
    procedure PanWortzahlClick(Sender: TObject);
    procedure EdSeiteKeyPress(Sender: TObject; var Key: Char);
    procedure Seitenanzeige(Sender: TObject);
    procedure EdWortzahlKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure EingebenClick(Sender: TObject);
    procedure EdWortzahlKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenHilfeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Spracheenglisch1Click(Sender: TObject);
    procedure Sprachefranzsisch1Click(Sender: TObject);
    procedure Vorgaben1Click(Sender: TObject);
    procedure Lexikon1Click(Sender: TObject);
    procedure InDateienSuchen1Click(Sender: TObject);
    procedure DoppelwrterA1Click(Sender: TObject);
    procedure DoppelwrterD1Click(Sender: TObject);
    procedure DLexikon1Click(Sender: TObject);
    procedure pnlUebungsmodusClick(Sender: TObject);
  private
    sTitel: String;
    procedure NeueSeiteneingabe(Sender: TObject);
    procedure BeschriftungTitel;
    procedure BeschriftungSeitenNr;
    procedure Sprachenwahl;
    procedure Wortzahlwahl;
    procedure BeschriftungNullSeite;
    procedure showPanel(toshow : TPanel);
    procedure doTrain(saveMistakes : Boolean);
  public
    ZLMenge: Integer;
    procedure MachSeitenmenu;

  end;

var
  Rahmenfenster: TRahmenfenster;

implementation

uses UTrainingsfenster, UEingabefenster, UVorgabenfenster,
  ULexikonD, UDatSuchFenster, UDoppelwortfenster, UdoppelwortfensterD;

{$R *.dfm}


procedure TRahmenfenster.FormCreate(Sender: TObject);
begin
  VorgabenLaden('Vorgaben.vrg');
  NullseiteLaden;         //Wieviele Wörter in NullSeite?
  BeschriftungSeitenNr;
  bTraining:= false;      //Trainingsprozess inaktiv
  With VorgabenRekord do
  begin
    If Sprache = 'e' then begin
      LexikonLaden('Lexikon.elx'); sTitel:= ' Vokabeltrainer Englisch';
      BeschriftungTitel;
    end;
    If Sprache = 'f' then begin
      LexikonLaden('Lexikon.flx'); sTitel:= 'Vokabeltrainer Französisch';
      BeschriftungTitel;
    end;
  end;
end;


procedure TRahmenfenster.FormActivate(Sender: TObject);
begin
  BeschriftungNullSeite;
end;


procedure TRahmenfenster.Exit1Click(Sender: TObject);
begin
  close
end;


procedure TRahmenfenster.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  Heute: String;
begin
  Vorgabenspeichern('Vorgaben.vrg');
  Heute:= FormatDateTime('ddmmmyy', Now)+'.vrg'; Vorgabenspeichern(Heute);
end;



{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

procedure TRahmenfenster.BeschriftungSeitenNr;
begin
  With VorgabenRekord do
  begin
    If Sprache = 'e' then
      begin
        Dateiname:= 'Seite'+IntToStr(SeitArrE[1])+'.dte';
        LabUebungsSeite.Caption := 'SeiteNr. '+IntToStr(SeitArrE[1]);
      end;
    If Sprache = 'f' then
      begin
       Dateiname:= 'Seite'+IntToStr(SeitArrF[1])+'.dtf';
       LabUebungsSeite.Caption := 'SeiteNr. '+IntToStr(SeitArrF[1]);
      end;
  end;
  LaUebWoAnz.Caption := IntToStr(VorgabenRekord.UebgWZl) + ' Wörter trainieren'; 
end;

procedure TRahmenfenster.EdSeiteKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 then begin        //Nur bei Eingabe "Neue Seite"
    try                         
      If VorgabenRekord.Sprache = 'f' then
        begin
          VorgabenRekord.SeitArrF[1]:= StrToInt(EdSeite.Text);
          Dateiname:= 'Seite' + EdSeite.Text +'.dtf';
        end;
      If VorgabenRekord.Sprache = 'e' then
        begin
          VorgabenRekord.SeitArrE[1]:= StrToInt(EdSeite.Text);
          Dateiname:= 'Seite' + EdSeite.Text +'.dte';
        end;
        LabUebungsSeite.Caption:= 'SeiteNr. '+EdSeite.Text;
        ErgebnisseUndDateiLaden(Dateiname);
    except
      ShowMessage('Zahl eingeben!');
      exit;
    end;
    showPanel(pnlLoslegen);
    exit;
  end;
end;


{XXXXXXXXX Seitenwahl XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

procedure TRahmenfenster.MachSeitenmenu;
var
  ZL: Integer;
  HNewItem : TMenuItem;
begin                      // Die verschiedenen Seiten in das Menu füllen:
  MenSeitenwahl.Clear;
  If VorgabenRekord.Sprache = 'e' then
  begin
    For ZL := 1 to 10 do if VorgabenRekord.InArbeitArrE[ZL] <> 99 then ZLMenge:= ZL;
    For ZL := 1 to ZLMenge do
    begin
      HNewItem         := TMenuItem.Create( nil);
      HNewItem.Caption := IntToStr(VorgabenRekord.InArbeitArrE[ZL]);
      HNewItem.Tag     := (VorgabenRekord.InArbeitArrE[ZL]);
      HNewItem.OnClick := Seitenanzeige;
      MenSeitenwahl.Add( HNewItem);
    end;
    HNewItem         := TMenuItem.Create( nil);
    HNewItem.Caption := '0';                     //Nullseite anzeigen
    HNewItem.Tag     := 0;                       //Nullseite auswählen
    HNewItem.OnClick := Seitenanzeige;
    MenSeitenwahl.Add( HNewItem);

    HNewItem         := TMenuItem.Create( nil);
    HNewItem.Caption := 'Neue Seite';
    HNewItem.OnClick := NeueSeiteneingabe;
    MenSeitenwahl.Add( HNewItem);

    HNewItem         := TMenuItem.Create(nil);    //"zuletzt eingegeben" anzeigen
    With VorgabenRekord do
    begin
      HNewItem.Caption := 'zuletzt eingegeben: '
      + IntToStr(SeitArrE[2]) +' (' +IntToStr(SeitArrE[3])
      +',' +IntToStr(SeitArrE[4]) +',' +IntToStr(SeitArrE[5]) +')';
    end;
    MenSeitenwahl.Add( HNewItem);
  end;
  
  If VorgabenRekord.Sprache = 'f' then
  begin
    For ZL := 1 to 10 do if VorgabenRekord.InArbeitArrF[ZL] <> 99 then ZLMenge:= ZL;
    For ZL := 1 to ZLMenge do
    begin
      HNewItem         := TMenuItem.Create( nil);
      HNewItem.Caption := IntToStr(VorgabenRekord.InArbeitArrF[ZL]);
      HNewItem.Tag     := (VorgabenRekord.InArbeitArrF[ZL]);
      HNewItem.OnClick := Seitenanzeige;
      MenSeitenwahl.Add( HNewItem);
    end;

    HNewItem         := TMenuItem.Create( nil);
    HNewItem.Caption := '0';                     //Nullseite anzeigen
    HNewItem.Tag     := 0;                       //Nullseite auswählen
    HNewItem.OnClick := Seitenanzeige;
    MenSeitenwahl.Add( HNewItem);

    HNewItem         := TMenuItem.Create( nil);
    HNewItem.Caption := 'Neue Seite';
    HNewItem.OnClick := NeueSeiteneingabe;
    MenSeitenwahl.Add( HNewItem);

    HNewItem         := TMenuItem.Create(nil);    //"zuletzt eingegeben" anzeigen
    With VorgabenRekord do
    begin
      HNewItem.Caption := 'zuletzt eingegeben: '
      + IntToStr(SeitArrF[2]) +' (' +IntToStr(SeitArrF[3])
      +',' +IntToStr(SeitArrF[4]) +',' +IntToStr(SeitArrF[5]) +')';
    end;
    MenSeitenwahl.Add( HNewItem);
  end;
end;



procedure TRahmenfenster.Seitenanzeige(Sender: TObject);
var
  hTag : integer;
begin
  htag := (Sender as TMenuItem).Tag;
  LabUebungsseite.Caption:= 'SeiteNr. '+IntToStr(htag);
  If VorgabenRekord.Sprache = 'e' then
    begin Dateiname:= 'Seite'+IntToStr(htag)+'.dte';     //Dateiname festlegen
    VorgabenRekord.SeitArrE[1]:= htag; end;            //Nummer in SeitArrE[1]
  If VorgabenRekord.Sprache = 'f' then                
    begin Dateiname:= 'Seite'+IntToStr(htag)+'.dtf';
    VorgabenRekord.SeitArrF[1]:= htag; end;
  ErgebnisseUndDateiLaden(Dateiname);   //XXXXXX
end;


procedure TRahmenfenster.Sprachenwahl;
begin
  BeschriftungTitel;
  NullseiteLaden;         //Wieviele Wörter in NullSeite?
  BeschriftungNullSeite;
  BeschriftungSeitenNr;
end;


procedure TRahmenfenster.NeueSeiteneingabe(Sender: TObject);
begin
  showPanel(PanSeitenzahl);
  EdSeite.SetFocus;
end;


procedure TRahmenfenster.FormShow(Sender: TObject);
begin
  MachSeitenmenu;
end;


procedure TRahmenfenster.EingebenClick(Sender: TObject);
begin
  Eingabefenster.Show;
end;


procedure TRahmenfenster.BeschriftungNullSeite;
var
  WortZhl: Integer;
begin
  If Zeroliste.Count-1 <0 then WortZhl:= 0 else WortZhl:= Zeroliste.Count-1;
  LabNullSeite.Caption:= 'NullSeite: '+IntToStr(WortZhl)+' Wörter  ';
end;

{XXXXXXXXX Wortzahl XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}

procedure TRahmenfenster.WortzahlClick(Sender: TObject);
begin
  showPanel(PanWortzahl);
  Edwortzahl.Text := IntToStr(Vorgabenrekord.UebgWZl);
  EdWortzahl.SetFocus;
end;

procedure TRahmenfenster.PanWortzahlClick(Sender: TObject);
begin
  VorgabenRekord.UebgWZl:= StrToInt(EdWortzahl.Text);
  LaUebWoAnz.Caption:= EdWortzahl.Text+ ' Wörter trainieren';
  showPanel(pnlLoslegen);
end;

procedure TRahmenfenster.pnlUebungsmodusClick(Sender: TObject);
begin
  doTrain(false);
end;

procedure TRahmenfenster.Wortzahlwahl;
begin
  showPanel(PanWortzahl);
  Edwortzahl.Text := IntToStr(Vorgabenrekord.UebgWZl);
  EdWortzahl.SetFocus;
end;


procedure TRahmenfenster.EdWortzahlKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Length(EdWortzahl.Text)>2 then ShowMessage('Ungültige Zahl');
end;


procedure TRahmenfenster.EdWortzahlKeyPress(Sender: TObject;
  var Key: Char);
begin
  If Key = #13 then begin
    try
      VorgabenRekord.UebgWZl:= StrToInt(EdWortzahl.Text);
    except
      ShowMessage('Zahl eingeben!');
    end;
    showPanel(pnlLoslegen);
    LaUebWoAnz.Caption := IntToStr(VorgabenRekord.UebgWZl) + ' Wörter trainieren';
  end;
end;

{XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}


procedure TRahmenfenster.TrainierenClick(Sender: TObject);
begin
  doTrain(true);
end;

procedure TRahmenfenster.doTrain(saveMistakes : Boolean);
begin
  Case DateiWert(Dateiname) of
    12345:  ShowmessagePos(Dateiname+'" gibt es nicht', 400, 400);
    0:      ShowmessagePos(Dateiname+'" enthält keine Wörter', 400, 400);
    1..200: ShowmessagePos(Dateiname+'" ist leer', 400, 400);
  else
    begin
      f_unbekannteSpeichern := saveMistakes;
      Trainingsfenster.Show;
    end;
  end;
end;

procedure TRahmenfenster.MenHilfeClick(Sender: TObject);
begin
  Hilfebox;
end;


procedure TRahmenfenster.Spracheenglisch1Click(Sender: TObject);
begin
  VorgabenRekord.Sprache:= 'e'; sTitel:= 'Vokabeltrainer Englisch'; Sprachenwahl;
  LexikonLaden('Lexikon.elx')
end;

procedure TRahmenfenster.Sprachefranzsisch1Click(Sender: TObject);
begin
  VorgabenRekord.Sprache:= 'f'; sTitel:= 'Vokabeltrainer Französisch'; Sprachenwahl;
  LexikonLaden('Lexikon.flx')
end;

procedure TRahmenfenster.Vorgaben1Click(Sender: TObject);
begin
  Vorgabenfenster.Show;
end;

{XXXXXXXXXXXXXXX LexikonÄndern XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX}



procedure TRahmenfenster.InDateienSuchen1Click(Sender: TObject);
begin
  InDatSuchfenster.Show;
end;


procedure TRahmenfenster.Lexikon1Click(Sender: TObject);
var
  HLexikon : TLexikon;
begin
  HLexikon := TLexikon.Create( nil);
  try
    HLexikon.ShowModal;   // dadurch wird das Formular modal
    if HLexikon.ModalResult = mrOK then   // isses modal? (Der Benutzer verlässt das
                                          //               Dialogfeld mit der Schaltfläche OK)
  finally                 // stellt sicher, dass bei Exeption die Operation abgeschlossen wird.
    FreeAndNil( HLexikon);
  end;
end; 


procedure TRahmenfenster.DoppelwrterA1Click(Sender: TObject);
begin
  Doppelwortfenster.Show;
end;


procedure TRahmenfenster.DoppelwrterD1Click(Sender: TObject);
begin
  DoppelwortfensterD.Show
end;


procedure TRahmenfenster.BeschriftungTitel;
begin
  LabTitelWeiss.Caption:= sTitel;
  LabTitelGrau.Caption:= sTitel;
end;


procedure TRahmenfenster.DLexikon1Click(Sender: TObject);
begin
  LexikonD.Show
end;

procedure TRahmenfenster.showPanel(toshow : TPanel);
begin
  pnlLoslegen.Visible := pnlLoslegen =toshow;
  PanWortzahl.Visible := PanWortzahl = toshow;
  PanSeitenzahl.Visible := PanSeitenzahl = toshow;
end;


end.
