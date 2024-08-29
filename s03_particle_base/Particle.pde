class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;

  Particle() {
    position = new PVector(width/2, height/3);
    velocity = new PVector(random(-1, 1), random(-2, 0));
    acceleration = new PVector(0, 0.05);
  }

  Particle(PVector l) {
    position = l.get();
    velocity = new PVector(random(-1, 1), random(-2, 0));
    acceleration = new PVector(0, 0.05);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    
  }

  void display() {
    stroke(0);
    fill(127);
    ellipse(position.x, position.y, 10, 10);
  }
}
