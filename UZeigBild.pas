unit UZeigBild;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TZeigBild = class(TForm)
    Image1: TImage;
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
  ZeigBild: TZeigBild;
  BildNr: Integer;

implementation

{$R *.dfm}

procedure TZeigBild.Bilderwahl;
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
  Image1.Picture.LoadFromFile(Bildname);
  BildTitel:= Copy(Bildname, 0, Pos('.', Bildname)-1);      //Bildname ohne Suffix
  If Image1.Picture.Width > Image1.Picture.Height then
    Image1.Left:= 569            //Querformat
  else Image1.Left:= 718;        //Hochformat
end;


end.
