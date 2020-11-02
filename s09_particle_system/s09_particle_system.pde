int currentTime;
int previousTime;
int deltaTime;

ArrayList<Particle> particles;
int nbParticles = 100;

void setup () {
  size (640, 480);
  
  currentTime = millis();
  previousTime = currentTime;
  
  particles = new ArrayList<Particle>();
  
  for (int i = 0; i < nbParticles; i++) {
    particles.add (new Particle(new PVector (width / 2, 10 )));
  }
}



void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();
}

/***
  The calculations should go here
*/
void update(int delta) {
  for (Particle p : particles) {
   p.update(delta);
  }
}

/***
  The rendering should go here
*/
void display () {
  background (25);
  
  for (Particle p : particles) {
    p.display();
    
    if (p.isDead()) {
      p.reset();
    }
  }
}
