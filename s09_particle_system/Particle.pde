class Particle extends Mover {

  int radius = 5;
  float lifespan;
  
  PVector initialPosition;
  
  PVector initialVelocity;
  
  Particle (PVector loc) {
    location = loc.copy();
    acceleration = new PVector (0.0, 0.05);
    
    velocity = new PVector (randomGaussian() * 2, random (-2, 0));
    initialPosition = location.copy();
    lifespan = random (200, 255);    
  }
  
  void update (int delta) {
    velocity.add (acceleration);
    location.add (velocity);
    
    lifespan -= 2.0;
    
    acceleration.x = 0.0;
    acceleration.y = 0.05; 
  }
  
  void display() {
    stroke(strokeColor, lifespan);
    fill (fillColor, lifespan);
    
    pushMatrix();
    
    translate (location.x, location.y);
    ellipse (0, 0, radius, radius);
    popMatrix();
    
  }
  
  boolean isDead() {
    return lifespan < 0.0;
  }
  
  void reset() {
    location.x = initialPosition.x;
    location.y = initialPosition.y;
    
    velocity.x = randomGaussian() * 2;
    velocity.y = random (-2, 0);
  
    
    lifespan = random (200, 255);    
  }
}
