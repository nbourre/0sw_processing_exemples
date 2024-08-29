class Particle extends GraphicObject {
  
  float lifespan;
  PVector startLocation;
  
  Particle() {
    location = new PVector(width/2, height/3);
    initialize();
  }

  Particle(PVector l) {
    location = l.copy();
    initialize();
  }
  
  void initialize() {
    startLocation = location.copy();
    velocity = new PVector(random(-1, 1), random(-2, 0));
    acceleration = new PVector(0, 0.05);
    lifespan = 255;
  }

  void update(int deltaTime) {
    velocity.add(acceleration);
    location.add(velocity);
    lifespan -= 2.0;
    
    if(isDead()) reset();
  }

  void display() {
    stroke(0, lifespan);
    fill(175, lifespan);
    ellipse(location.x, location.y, 10, 10);
  }
  
  void applyForce (PVector f) {
    acceleration.add(f);
  }
  
  boolean isDead() {
    return lifespan < 0.0;
  }
  
  void setXY(float x, float y) {
    startLocation.set (x, y);
  }
  
  void reset() {
    location.set (startLocation.x,  startLocation.y);
    velocity.set (random(-1, 1), random(-2, 0));    
    lifespan = 255;
  }
}
