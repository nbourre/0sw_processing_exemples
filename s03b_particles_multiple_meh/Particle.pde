class Particle extends GraphicObject {
  PVector velocity;
  PVector acceleration;
  float lifespan;
  
  Particle() {
    location = new PVector(width/2, height/3);
    initialize();
  }

  Particle(PVector l) {
    location = l.copy();
    initialize();
  }
  
  void initialize() {
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
  
  void reset() {
    location.set (width/2,  height/3);
    velocity.set (random(-1, 1), random(-2, 0));    
    lifespan = 255;
  }
}
