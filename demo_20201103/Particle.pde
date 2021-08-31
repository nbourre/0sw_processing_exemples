class Particle extends Mover {
  
  int diameter = 5;
  float lifespan;
  
  PVector initialPosition;
  
  float intensity;
  
  Particle (PVector loc) {
    location = loc.copy();
    acceleration = new PVector (0f, 0.05f);
    intensity = 1;
    velocity = new PVector (randomGaussian() * intensity, random (-2, 0) * 3);
    initialPosition = location.copy();
    
    lifespan = random (200, 255);
    
    strokeColor = 255;
    fillColor = color (200, 0, 0);
  }
  
  void update (int delta) {
    velocity.add (acceleration);
    location.add (velocity);
    
    lifespan -= 2.0;
  }
  
  void display() {
    stroke (strokeColor, lifespan);
    fill (fillColor, lifespan);
    
    pushMatrix();
    translate (location.x, location.y);
    ellipse (0, 0, diameter, diameter);
    popMatrix();
  }
  
  boolean isDead () {
    return lifespan <= 0.0;
  }
  
  void reset () {
    location.x = initialPosition.x;
    location.y = initialPosition.y;
    velocity.x = randomGaussian() * intensity;
    velocity.y = random (-2, 0);
    lifespan = random (200, 255);    
  }
}
