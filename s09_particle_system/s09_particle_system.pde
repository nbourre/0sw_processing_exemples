import java.util.Iterator;

int currentTime;
int previousTime;
int deltaTime;

ParticleSystem ps;



void setup () {
  size (640, 480);
  
  currentTime = millis();
  previousTime = currentTime;
  
  ps = new ParticleSystem();
}


void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();
}

void update(int delta) {
  ps.update(delta);
}

void display () {
  background (25);
  ps.display();
}
