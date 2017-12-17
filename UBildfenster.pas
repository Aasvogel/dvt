unit UBildfenster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TBildfenster = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    BildArray: Array[1..100]of string[30];
    Bildname, Bildtitel: string;
    BildZL: integer;
    procedure Bilderwahl;

    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Bildfenster: TBildfenster;
  BildNr: Integer;

implementation

{$R *.dfm}


procedure TBildfenster.Bilderwahl;
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
  Bildfenster.Caption:= BildTitel;
  If Image1.Picture.Width > Image1.Picture.Height then
  begin
{    Bildfenster.Left:= 480;
    Bildfenster.Width:= 787;
    Bildfenster.Top := 10;                        //Querformat
    Bildfenster.Height:= 590;  }
    Image1.Width:= 767;
    Image1.Height:= 550;
  end

  else begin
    Bildfenster.Left:= 670; Bildfenster.Top := 25;                        //Hochformat
    Bildfenster.Width:= 590; Image1.Width:= 570;
    Bildfenster.Height:= 787; Image1.Height:= 747
  end;
end;

procedure TBildfenster.FormShow(Sender: TObject);
begin
  Bilderwahl;
end;

end.
