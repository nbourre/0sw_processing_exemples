class Mover extends GraphicObject {
  float mass;
  float radius;
  float coeffRestitution;
  
  boolean hasContactWithFloor = false;
  
  private float diametreFactor = 16;
  
  Mover() {
    super();
    this.mass = 1;
    updateMath();
  }
  
  Mover(float m, float x, float y) {
    super(new PVector(x, y));
    this.mass = m;
    updateMath();
  }
  
  void updateMath() {
    radius = mass * diametreFactor / 2;
  }
  
  void setMass(float mass) {
    this.mass = mass;
    updateMath();
  }
  
  @Override
  void update(int deltaTime) {
    velocity.add(acceleration);
    location.add(velocity);
    
    acceleration.mult(0);
  }
  
  @Override
  void display() {
    stroke(0);
    fill(127, 127, 127, 127);
    ellipse(location.x, location.y, radius * 2, radius * 2);
  }
  
  void checkEdges(int width, int height) {
    if (location.x + radius > width) {
      location.x = width - radius;
      velocity.x *= -1 * coeffRestitution;
    } else if (location.x < 0) {
      velocity.x *= -1 * coeffRestitution;
      location.x = radius;
    }
    
    if (location.y + radius > height) {
      velocity.y *= -1 * coeffRestitution;
      location.y = height - radius;
      hasContactWithFloor = true;
    } else {
      hasContactWithFloor = false;
    }
    
    // Damping pour empêcher la vibration
    if (abs(velocity.y) < 0.0001) {
      velocity.y = 0;
    }
    
    if (abs(velocity.x) < 0.0001) {
      velocity.x = 0;
    }
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    this.acceleration.add(f);
  }
  
  // Utiliser pour la gravité uniquement
  // la masse n'a aucun effet dessus
  void applyGravity(PVector acc) {
    this.acceleration.add(acc);
  }
}
