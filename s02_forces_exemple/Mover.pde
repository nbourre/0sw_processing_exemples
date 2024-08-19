class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
   
  float topSpeed;
  float mass = 1;
  float coeffRestitution = 1;
  float radius;
  float diametre;
  
  boolean hasContactWithFloor = false;
  
  private float diametreFactor = 16;
  
  
  
  Mover () {
    
    this.location = new PVector (random (width), random (height));    
    this.velocity = new PVector (0, 0);
    this.acceleration = new PVector (0 , 0);
    
    updateMath();
  }  
  
  Mover (PVector loc, PVector vel) {
    this.location = loc;
    this.velocity = vel;
    this.acceleration = new PVector (0 , 0);
    
    this.topSpeed = 100;
    
    updateMath();
  }
  
  Mover (float m, float x, float y) {
    mass = m;
    location = new PVector (x, y);
    
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    
    updateMath();
  }
  
  Mover (float x, float y) {
    mass = 1;
    location = new PVector (x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector (0, 0);
    
    updateMath();
  }
  
  void updateMath() {
    diametre = mass * diametreFactor;
    radius = diametre / 2;
  }
  
  void setMass(float mass) {
    this.mass = mass;
    updateMath();
  }
  
  void update () {
    velocity.add (acceleration);
    location.add (velocity);

    acceleration.mult (0);
  }
  
  void display () {
    stroke (0);
    fill (127, 127, 127, 127);
    
    if (location.y > -diametre) {
      ellipse (location.x, location.y, diametre, diametre); // Dimension à l'échelle de la masse
    }
    else {
      fill (200, 0, 0);
      rect (location.x, 0, diametre, -location.y / 10);
    }
  }
  
  void checkEdges() {
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
    }
    else
      hasContactWithFloor = false;
    
    // Damping pour empêcher la vibration
    if (Math.abs(velocity.y) < 0.0001) {
      velocity.y = 0;
    }
    
    if (Math.abs(velocity.x) < 0.0001) {
      velocity.x = 0;
    }
  }
  
  
  void applyForce (PVector force) {
    PVector f = PVector.div (force, mass);
   
    this.acceleration.add(f);
  }
  
  // Utiliser pour la gravity uniquement
  // la masse n'a aucun effet dessus
  void applyGravity (PVector acc) {
    this.acceleration.add (acc);
  }
  
  Rectangle getRectangle() {
    Rectangle r = new Rectangle(location.x - radius, location.y - radius, diametre, diametre);
    
    return r;
  }
}
