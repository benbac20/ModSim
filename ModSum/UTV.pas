unit UTV;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Gauges, jpeg;


type
 TSymbole = ( Btn_1, Btn_2, Btn_3, Btn_Store, Btn_Back, Btn_Menu, Btn_Vol_Plus,
  Btn_Vol_Moin) ;

  TEtat = (Affichage_Ecran, Affichage_Menu, Affichage_Image, Affichage_Recherche,
            Reglage_Luminosite, Reglage_Contraste, Reglage_Couleur);

  TfrmTV = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    Shape1: TShape;
    Btn1: TShape;
    Btn2: TShape;
    Btn3: TShape;
    Btn4: TShape;
    Btn5: TShape;
    Btn6: TShape;
    Btn7: TShape;
    Btn8: TShape;
    Btn9: TShape;
    Btn0: TShape;
    BtnBack: TShape;
    BtnStore: TShape;
    Btn_Ch_Mois: TImage;
    Btn_Ch_Plus: TImage;
    Image_Vol_Plus: TImage;
    Image_Vol_Moin: TImage;
    BtnMenu: TShape;
    Shape16: TShape;
    Ecran: TShape;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label_Ch_Moin: TLabel;
    Label_Vol_Moin: TLabel;
    Label_Menu: TLabel;
    Label_Vol_Plus: TLabel;
    Label_Ch_Plus: TLabel;
    Gauge: TGauge;
    Label_Ecran: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Label_Vol_PlusClick(Sender: TObject);
    procedure Label_Vol_MoinClick(Sender: TObject);
    procedure BtnMenuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Btn1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Btn2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Btn3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtnBackMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BtnStoreMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  procedure Transition(Symbole : TSymbole);
    procedure Btn4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
      procedure AffichageImage(Sender: TObject);
  end;

var
  frmTV: TfrmTV;

implementation

{$R *.dfm}

var
  Etat : TEtat;
  Luminosite, Contraste, Couleur, Recherche : integer;

// Affichgae d'une image aléatoirement
procedure TfrmTV.AffichageImage(Sender: TObject);
begin
  if Etat = Affichage_Ecran then
    begin
     Image1.Visible := true;
     image1.Picture.LoadFromFile('images\image' +
     IntToStr(Round(Random(20)+1))+ '.bmp');
     end;
end;

procedure Pro_Affichage_Ecran;
begin
  Etat := Affichage_Ecran;
  frmTV.Label_Ecran.Caption := 'Ecran';
  frmTV.Gauge.Visible := false;
end;

procedure Pro_Affichage_Menu(Option: integer = 0);
begin
  Etat := Affichage_Menu;
  frmTV.Label_Ecran.Caption := '   Menu   ' + #10 + #10
                             + '(1) Image ' + #10
                             + '(2) Recherche';
  frmTV.Gauge.Visible := false;
  if Option = 1 then Recherche := frmTV.Gauge.Progress;
end;

procedure Pro_Affichage_Image(Option: integer = 0);
begin
  Etat := Affichage_Image;
  frmTV.Label_Ecran.Caption := '     Image     ' + #10 + #10
                             + '(1) Luminosité ' + #10
                             + '(2) Contraste ' + #10
                             + '(3) Couleur ';
  frmTV.Gauge.Visible := false;
  case Option of
    1: Luminosite := frmTV.Gauge.Progress;
    2: Contraste := frmTV.Gauge.Progress;
    3: Couleur := frmTV.Gauge.Progress;
  end;
end;

procedure Pro_Recherche(Sens: integer = 0);
begin
  frmTV.image1.Visible := true;
  Etat := Affichage_Recherche;
  with frmTV do
  case Sens of
   0:
    begin
      Label_Ecran.Caption := 'Recherche';
      Gauge.Progress := Recherche;
      Gauge.Visible := true;
    end;
   1,-1: Gauge.AddProgress(Sens);
  end;
  with frmTV do
    image1.Picture.LoadFromFile('images\image' + IntToStr(Gauge.Progress mod 20) + '.bmp');
end;

procedure Pro_Reglage_Luminosite(Sens: integer = 0);
begin
  Etat := Reglage_Luminosite;
  case Sens of
   0:
    begin
      frmTV.Label_Ecran.Caption := 'Luminosité';
      frmTV.Gauge.Progress := Luminosite;
      frmTV.Gauge.Visible := true;
    end;
   1,-1: frmTV.Gauge.AddProgress(Sens);
  end;
end;

procedure Pro_Reglage_Contraste(Sens: integer = 0);
begin
  Etat := Reglage_Contraste;
  case Sens of
   0:
    begin
      frmTV.Label_Ecran.Caption := 'Contraste';
      frmTV.Gauge.Progress := Contraste;
      frmTV.Gauge.Visible := true;
    end;
   1,-1: frmTV.Gauge.AddProgress(Sens);
  end;
end;

procedure Pro_Reglage_Couleur(Sens: integer = 0);
begin
  Etat := Reglage_Couleur;
  case Sens of
   0:
    begin
      frmTV.Label_Ecran.Caption := 'Couleur';
      frmTV.Gauge.Progress := Couleur;
      frmTV.Gauge.Visible := true;
    end;
   1,-1: frmTV.Gauge.AddProgress(Sens);
  end;
end;

procedure TfrmTV.Transition(Symbole : TSymbole);
begin
  frmTV.image1.Visible := false;
  case Symbole of
    Btn_1:
      case Etat of
        Affichage_Menu: Pro_Affichage_Image;
        Affichage_Image: Pro_Reglage_Luminosite;
      end;
    Btn_2:
      case Etat of
        Affichage_Menu: Pro_Recherche;
        Affichage_Image: Pro_Reglage_Contraste;
      end;
    Btn_3:
      case Etat of
        Affichage_Image: Pro_Reglage_Couleur;
      end;
    Btn_Store:
      case Etat of
        Reglage_Luminosite: Pro_Affichage_Image(1);
        Reglage_Contraste: Pro_Affichage_Image(2);
        Reglage_Couleur: Pro_Affichage_Image(3);
        Affichage_Recherche: Pro_Affichage_Menu(1);
      end;
    Btn_Back:
      case Etat of
        Affichage_Menu: Pro_Affichage_Ecran;
        Affichage_Image, Affichage_Recherche: Pro_Affichage_Menu;
        Reglage_Luminosite, Reglage_Contraste, Reglage_Couleur: Pro_Affichage_Image;
      end;
    Btn_Menu:
      case Etat of
        Affichage_Ecran: Pro_Affichage_Menu;
      end;
    Btn_Vol_Plus:
      case Etat of
        Reglage_Luminosite: Pro_Reglage_Luminosite(+1);
        Reglage_Contraste: Pro_Reglage_Contraste(+1);
        Reglage_Couleur: Pro_Reglage_Couleur(+1);
        Affichage_Recherche: Pro_Recherche(+1);
      end;
    Btn_Vol_Moin:
      case Etat of
        Reglage_Luminosite: Pro_Reglage_Luminosite(-1);
        Reglage_Contraste: Pro_Reglage_Contraste(-1);
        Reglage_Couleur: Pro_Reglage_Couleur(-1);
        Affichage_Recherche: Pro_Recherche(-1);
      end;
  end;
end;

procedure TfrmTV.FormCreate(Sender: TObject);
begin
  Etat := Affichage_Ecran;
  Luminosite := 50;
  Contraste := 50;
  Couleur := 50;
  Recherche := 50;
end;

procedure TfrmTV.Label_Vol_PlusClick(Sender: TObject);
begin
    Transition(Btn_Vol_Plus);
end;

procedure TfrmTV.Label_Vol_MoinClick(Sender: TObject);
begin
    Transition(Btn_Vol_Moin);
end;

procedure TfrmTV.BtnMenuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Transition(Btn_Menu);
end;

procedure TfrmTV.Btn1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Transition(Btn_1);
  AffichageImage(Sender);
end;

procedure TfrmTV.Btn2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Transition(Btn_2);
  AffichageImage(Sender);
end;

procedure TfrmTV.Btn3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Transition(Btn_3);
  AffichageImage(Sender);
end;

procedure TfrmTV.BtnBackMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Transition(Btn_Back);
end;

procedure TfrmTV.BtnStoreMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 Transition(Btn_Store);
end;

procedure TfrmTV.FormKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '+': Transition(Btn_Vol_Plus);
    '-': Transition(Btn_Vol_Moin);
    '1': Transition(Btn_1);
    '2': Transition(Btn_2);
    '3': Transition(Btn_3);
    'm': Transition(Btn_Menu);
    'b': Transition(Btn_Back);
    's': Transition(Btn_Store);
  end;
end;


procedure TfrmTV.Btn4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  AffichageImage(Sender);
end;

end.
