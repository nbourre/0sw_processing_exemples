int currentTime;
int previousTime;
int deltaTime;

int previousSave;
float saveRate = 1000.0 / 15;

Particle p;

boolean createGif = true;

void setup() {
  size (800, 600);
  p = new Particle();
  background(255);
}

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  update(deltaTime);
  display();
}

void update(int deltaTime) {
  if (p.position.y > height) {
    p.position = new PVector(width/2, height/3);
    p.velocity = new PVector(random(-1, 1), random(-2, 0));
  }
  p.update();
}

void display() {
  if (createGif) {
    if (currentTime - previousSave < saveRate)return;
    previousSave = currentTime;
  }

  p.display();

  saveImg(createGif);
}


void saveImg(boolean enable) {
  if (!enable) return;

  saveFrame("d:/temp/proc_frames/####.tga");
}
