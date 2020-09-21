class Astre extends GraphicObject {
  float angularVelocity = 0.0;
  float angularAcceleration = 0.0;
  
  float angle = 0.0;  
  
  float w = 20;
  float h = 10;
  
  float mass = 1.0;  
  float size = 10;
  
  Astre() {
    initValues();
  }
  
  Astre (float distance, float radius, float speed) {
    initValues();
    location.x = distance;
    size = radius;
    angularVelocity = speed;
  }
  
  void initValues() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector(); 
  }  
  
  void applyForce (PVector force) {
    PVector f;
    
    if (mass != 1)
      f = PVector.div (force, mass);
    else
      f = force;
   
    this.acceleration.add(f);
  }
  
  void checkEdges() {
    if (location.x < -size) location.x = width + size;
    if (location.y < -size) location.y = height + size;
    if (location.x > width + size) location.x = -size;
    if (location.y > height + size) location.y = -size;
  }
  
  void update(float delta) {
    velocity.add(acceleration);
    location.add(velocity);
    
    acceleration.mult(0);
    
    angularVelocity += angularAcceleration;
    angle += angularVelocity;
    
    angularAcceleration = 0.0;
    
    if (moons != null) {
      for (Astre moon : moons) {
        moon.update(delta);
      }
    }
  }
  
  void display() {
    pushMatrix();
      rotate(angle);
      translate(location.x, location.y);
      fill(fillColor);
      ellipse(0, 0, size, size);
      
      if (moons != null) {
        for (Astre moon : moons) {
          moon.display();
        }
      }
    popMatrix();
  }
  
  ArrayList<Astre> moons;
  
  void addMoon (float distance, float speed) {
    if (moons == null) {
      moons = new ArrayList<Astre>();
    }
    
    Astre moon = new Astre(distance, size / 2, speed);
    
    moons.add(moon);
  }
  
  void addMoon(Astre a) {
    if (moons == null) {
      moons = new ArrayList<Astre>();
    }
    
    moons.add(a);
  }
}
