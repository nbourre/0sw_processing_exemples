int currentTime;
int previousTime;
int deltaTime;

int forestWidth = 100;
int nbPreds = 12;

ArrayList<Predator> preds;
Proie proie;

void setup() {
  size (800, 600);
  
  preds = new ArrayList<Predator>();
  
  for (int i = 0; i < nbPreds; i++) {
    var p = new Predator ((int)random (forestWidth + 50, width - (forestWidth + 50)), (int)random(50, height - 50));
    preds.add(p);
  }
  
  proie = new Proie (20, height / 2);
  
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();
}

void update(int deltaTime) {
  for (var p : preds) {
    p.update(deltaTime);
  }
  proie.update(deltaTime);
}

void display() {
  background(0);
  
  // Forêt
  fill (0, 100, 0);
  rect(0, 0, forestWidth, height);
  rect(width - forestWidth, 0, forestWidth, height);
  
  // Champ
  fill (224, 188, 25);
  rect(forestWidth, 0, width - 2 * forestWidth, height);
  
  for (var p : preds) {
    p.display();
  }
  
  proie.display();
}
