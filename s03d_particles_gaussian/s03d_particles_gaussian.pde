int currentTime;
int deltaTime;
int previousTime;

int particleRate = 100;
int lastParticleTime;
int maxParticles = 100;

ArrayList<Particle> particles;

void setup() {
  size(800, 600);
  particles = new ArrayList<Particle>();
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();
}

void update(int deltaTime) {
  if (currentTime - lastParticleTime > particleRate && particles.size() < maxParticles) {
    lastParticleTime = currentTime;
    particles.add(new Particle());
  }

  for (Particle p : particles) {
    p.update(deltaTime);
  }
}

int previousSave;
float saveRate = 1000.0 / 15;
boolean createGif = false;

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
