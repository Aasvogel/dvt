program Vokabeltrainer_c;

uses
  Forms,
  URahmenfenster in 'URahmenfenster.pas' {Rahmenfenster},
  UTrainingsfenster in 'UTrainingsfenster.pas' {Trainingsfenster},
  UEingabefenster in 'UEingabefenster.pas' {Eingabefenster},
  UVorgabenfenster in 'UVorgabenfenster.pas' {Vorgabenfenster},
  ULexikon in 'ULexikon.pas' {Lexikon},
  ULexikonD in 'ULexikonD.pas' {LexikonD},
  UDatSuchFenster in 'UDatSuchFenster.pas' {InDatSuchFenster},
  UDoppelwortfenster in 'UDoppelwortfenster.pas' {Doppelwortfenster},
  UdoppelwortfensterD in 'UdoppelwortfensterD.pas' {DoppelwortfensterD},
  UService in 'UService.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Vokabeltrainer 2018';
  Application.CreateForm(TRahmenfenster, Rahmenfenster);
  Application.CreateForm(TTrainingsfenster, Trainingsfenster);
  Application.CreateForm(TEingabefenster, Eingabefenster);
  Application.CreateForm(TVorgabenfenster, Vorgabenfenster);
  Application.CreateForm(TLexikon, Lexikon);
  Application.CreateForm(TLexikonD, LexikonD);
  Application.CreateForm(TInDatSuchFenster, InDatSuchFenster);
  //  Application.CreateForm(TBildfenster, Bildfenster);
  Application.CreateForm(TDoppelwortfenster, Doppelwortfenster);
  Application.CreateForm(TDoppelwortfensterD, DoppelwortfensterD);
  Application.Run;
end.
