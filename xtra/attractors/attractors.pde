int nbMovers = 25;

int lineInterval = 5000;
int linePrevious = 0;
int currentTime;
int previousTime = 0;
int deltaTime = 0;
int moverIndex = 0;

Attractor attractor;
Mover[] movers = new Mover[nbMovers];

float attractorToCorner;

void setup() {
  //fullScreen(1);
  size (640, 480);
  
  for (int i = 0; i < nbMovers; i++) {
    movers[i] = new Mover();
    movers[i].setShape(ShapeType.SQUARE);
    movers[i].velocity = new PVector(random(-0.5, 0.5),random(-0.5, 0.5)); 
  }
  
  attractor = new Attractor();
  
  attractorToCorner = PVector.sub(attractor.location, new PVector()).mag();
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();
  
}

void update(int deltaTime) {
  
  // Calcul pour chaque Mover et l'attracteur
  for (int i = 0; i < nbMovers; i++) {
    Mover current = movers[i];
    PVector f = attractor.attractionForce(current);
    
    // Calcul de la force d'attraction entre chaque Mover
    for (int j = 0; j < nbMovers; j++) {
      if (j != i) {
        PVector f2 = current.attractionForce(movers[j]);
        current.applyForce(f2);
      }      
    }
    
    current.applyForce(f);
    current.update(deltaTime);
  }
  
  // Changement de l'affichage de la ligne 
  if (currentTime - linePrevious > lineInterval) {
    linePrevious = currentTime;
    moverIndex = (moverIndex + 1) % nbMovers;
  }
}

void display() {  
  
  background (255);
  
  attractor.display();
  
  for (int i = 0; i < nbMovers; i++) {
    movers[i].display();
  }
  
  displayLine();

}

// Affiche une ligne de déboggage
void displayLine() {
  PVector loc = movers[moverIndex].location;
  float mag = PVector.sub(attractor.location, loc).mag();
  
  // Permet de contrôler l'épaisseur et la couleur de la ligne
  strokeWeight(map (mag, 0, width, .1, movers[moverIndex].radius));
  stroke (color(0, 200, 0, map (mag, 0, attractorToCorner, 20, 255)));
  line (attractor.location.x, attractor.location.y, loc.x, loc.y);
  
  strokeWeight(1);
  stroke (color(0, 0, 0, 255));
  textSize(16);
  text(" d = " + mag, (loc.x - attractor.location.x) / 2 + attractor.location.x, (loc.y - attractor.location.y) / 2 + attractor.location.y);
}
