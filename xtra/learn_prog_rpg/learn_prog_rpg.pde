/**
Projet pour montrer comment la logique de programmation fonctionne

*/
import processing.net.*;

Matrix mat;

int matW = 5;
int matH = 5;

int displayInterval = 250;
int displayAcc = 0;
int displayLastTime = 0;
int previousTime = 0;
int currentTime = 0;

PImage trash;
int nbTrash = 3;

void setup() {
  size (800, 600);
  background(50);
  fill (200);
  
  trash = loadImage("trash_a.png");
  
  mat = new Matrix(matW, matH);
  
  initTrash();
}

void initTrash() {
  for (int i = 0; i < nbTrash; i++) {
    var cell = mat.getCell((int)random(0, matW - 1), (int)random(0, matH - 1));
    
    if (cell.getOverlayImage() != null) {
      i--;
      continue;
    }
    
    cell.setOverlayImage(trash);
  }
  
}

void draw() {
  currentTime = millis();
  float delta = currentTime - previousTime;
  previousTime = currentTime;
  
  update(delta);
  display();
}

void update(float deltaTime) {
  displayAcc += deltaTime;
  if (displayAcc >= displayInterval) {
    displayAcc = 0;
  }
}

void display() {
  pushMatrix();
    //translate (10, 10);
    //scale(0.80);
    
    mat.display();
  popMatrix();
}
