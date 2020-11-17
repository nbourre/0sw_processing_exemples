import processing.sound.*;

// Créer un tableau de sons
SoundFile[] file;

// Nombre d'échantillons
int numsounds = 5;

// Define a variable to store the randomly generated background color in
int backgroundColor[] = {255, 255, 255};

// ...
void setup() {
  size(640, 360);

  // Instancier le tableau de sons
  file = new SoundFile[numsounds];

  // Charger les fichier qui sont dans le dossier data
  for (int i = 0; i < numsounds; i++) {
    file[i] = new SoundFile(this, (i+1) + ".aif");
  }
}

void draw() {
  background(backgroundColor[0], backgroundColor[1], backgroundColor[2]);
}

void keyPressed() {
  // On utilise un booléen pour valider la touche appuyée
  boolean validKey = true;

  switch(key) {
  case 'a':
    file[0].play(0.5, 1.0);
    break;

  case 's':
    file[1].play(0.5, 1.0);
    break;

  case 'd':
    file[2].play(0.5, 1.0);
    break;

  case 'f':
    file[3].play(0.5, 1.0);
    break;

  case 'g':
    file[4].play(0.5, 1.0);
    break;

  case 'h':
    file[0].play(1.0, 1.0);
    break;

  case 'j':
    file[1].play(1.0, 1.0);
    break;

  case 'k':
    file[2].play(1.0, 1.0);
    break;

  case 'l':
    file[3].play(1.0, 1.0);
    break;

  case ';':
    file[4].play(1.0, 1.0);
    break;

  case '\'':
    file[0].play(2.0, 1.0);
    break;

  case 'q':
    file[1].play(2.0, 1.0);
    break;

  case 'w':
    file[2].play(2.0, 1.0);
    break;    

  case 'e':
    file[3].play(2.0, 1.0);
    break;

  case 'r':
    file[4].play(2.0, 1.0);
    break; 

  case 't':
    file[0].play(3.0, 1.0);
    break;

  case 'y':
    file[1].play(3.0, 1.0);
    break;

  case 'u':
    file[2].play(3.0, 1.0);
    break;    

  case 'i':
    file[3].play(3.0, 1.0);
    break;

  case 'o':
    file[4].play(3.0, 1.0);
    break;

  case 'p':
    file[0].play(4.0, 1.0);
    break;    

  case '[':
    file[1].play(4.0, 1.0);
    break;

    // Aucune clé valide
  default:
    validKey = false;
  }

  // Si une clé valide est appuyée, on change la couleur
  // du background
  if (validKey) {
    for (int i = 0; i < 3; i++) {
      backgroundColor[i] = int(random(255));
    }
  }
}
