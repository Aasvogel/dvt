unit UVorgabenfenster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, FileCtrl, UService;

type
  TVorgabenfenster = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    LabUebernCaption: TLabel;
    LabLoeschCaption: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    FLBLoeschen: TFileListBox;
    FLBUebernehmen: TFileListBox;
    MainMenu1: TMainMenu;
    schliessen1: TMenuItem;
    procedure schliessen1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FLBLoeschenClick(Sender: TObject);
    procedure FLBUebernehmenClick(Sender: TObject);
  private
    Dateistring: string;
    procedure FLBupdate;
  public
    { Public-Deklarationen }
  end;

var
  Vorgabenfenster: TVorgabenfenster;

implementation

{$R *.dfm}

procedure TVorgabenfenster.schliessen1Click(Sender: TObject);
begin
  close
end;

procedure TVorgabenfenster.FormActivate(Sender: TObject);
begin
  FLBUpdate;
end;


procedure TVorgabenfenster.FLBUpdate;
var
  ZL: Integer;
begin
  For ZL:= 0 to ComponentCount-1 do
    if Components[ZL] is TFileListbox then  (Components[ZL] as TFileListBox).Update;
end;


procedure TVorgabenfenster.FLBLoeschenClick(Sender: TObject);
var
  Txt: String;
  ZL, Slash: Integer;
  T: Textfile;
begin
  Txt:= FLBLoeschen.Filename; Slash:= 0;
  For ZL:= 1 to Length(Txt) do if copy(Txt, ZL, 1) = '\' then Slash:= ZL;  {= letzter Backslash}
  Dateistring:= copy(Txt, Slash+1, (Length(Txt)-Slash));
                   {extrahiert von Dateinamen die Pfadangabe}
  If Dateistring = 'Vorgaben.vrg' then Showmessage('Diese Datei darf nicht gelöscht werden')
  else begin
    AssignFile(T, Dateistring);
    Erase(T);
    FLBUpdate;
  end;
end;


procedure TVorgabenfenster.FLBUebernehmenClick(Sender: TObject);
var
  Txt: String;
  ZL, Slash: Integer;
begin
  Txt:= FLBUebernehmen.Filename; Slash:= 0;
  For ZL:= 1 to Length(Txt) do if copy(Txt, ZL, 1) = '\' then Slash:= ZL;
  Dateistring:= copy(Txt, Slash+1, (Length(Txt)-Slash));
  If Dateistring = 'Vorgaben.vrg' then Showmessage('Diese Datei ist bereits die aktuelle Datei')
  else begin
    Vorgabenladen(Dateistring); LabUebernCaption.Caption:= 'Aktuelle Vorgabe: '+Dateistring;
  end;
end;

end.
