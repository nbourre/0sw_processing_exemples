int currentTime;
int previousTime;
int deltaTime;

ArrayList<Particle> particles;

void setup() {
  size(800, 600);
  particles = new ArrayList<Particle>();

  // Ajoute 100 particules à la liste
  for (int i = 0; i < 100; i++) {
    particles.add(new Particle());
  }
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();
}

void update(int deltaTime) {
  for (Particle p : particles) {
    p.update(deltaTime);
  }
}

int previousSave;
float saveRate = 1000.0 / 15;
boolean createGif = true;

void display() {
  if (createGif) {
    if (currentTime - previousSave < saveRate)return;
    previousSave = currentTime;
    saveFrame("d:/temp/proc_frames/####.tga");
  }
  
  background(255);
  for (Particle p : particles) {
    p.display();
  }
}
