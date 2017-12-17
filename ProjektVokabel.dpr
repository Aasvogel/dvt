program ProjektVokabel;

uses
  Forms,
  URahmenfenster in 'E:\Vokabeltrainer\URahmenfenster.pas' {Rahmenfenster},
  UTrainingsfenster in 'E:\Vokabeltrainer\UTrainingsfenster.pas' {Trainingsfenster},
  UEingabefenster in 'E:\Vokabeltrainer\UEingabefenster.pas' {Eingabefenster},
  UVorgabenfenster in 'E:\Vokabeltrainer\UVorgabenfenster.pas' {Vorgabenfenster},
  ULexikon in 'E:\Vokabeltrainer\ULexikon.pas' {Lexikon},
  ULexikonD in 'E:\Vokabeltrainer\ULexikonD.pas' {LexikonD},
  UDatSuchFenster in 'E:\Vokabeltrainer\UDatSuchFenster.pas' {InDatSuchFenster},
  UDoppelwortfenster in 'E:\Vokabeltrainer\UDoppelwortfenster.pas' {Doppelwortfenster},
  UdoppelwortfensterD in 'E:\Vokabeltrainer\UdoppelwortfensterD.pas' {DoppelwortfensterD};

{$R *.res}

begin
  Application.Initialize;
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
