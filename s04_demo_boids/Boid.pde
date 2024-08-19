class Boid extends GraphicObject {
  float topSpeed = 2;
  float topSteer = 0.03;
  
  float theta = 0;
  float r = 10; // Rayon du Boid
  
  float radiusSeparation = 10 * r;
  
  float red, g, b;
  
  boolean debugMode = false;
  
  Boid () {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
  }
  
  Boid (PVector loc, PVector vel) {   
    this.location = loc.copy();
    this.velocity = vel.copy();
    this.acceleration = new PVector (0 , 0);
    this.topSpeed = 100;
  }
  
  void checkEdges() {
    if (location.x < 0) {
      location.x = width - r;
    } else if (location.x + r> width) {
      location.x = 0;
    }
    
    if (location.y < 0) {
      location.y = height - r;
    } else if (location.y + r> height) {
      location.y = 0;
    }
  }
  
  void update(float deltaTime) {
    checkEdges();
    
    velocity.add (acceleration);
    velocity.limit(topSpeed);
    location.add (velocity);

    acceleration.mult (0);      
  }
  
  void display() {
    noStroke();
    fill (fillColor);
        
    theta = velocity.heading() + radians(90);
    
    pushMatrix();
    translate(location.x, location.y);
    rotate (theta);
    
    beginShape(TRIANGLES);
      vertex(0, -r * 2);
      vertex(-r, r * 2);
      vertex(r, r * 2);
    
    endShape();
    
    popMatrix();  
  }
  
  PVector separate (ArrayList<Boid> Boids) {
    PVector steer = new PVector(0, 0, 0);
    
    int count = 0;
    
    for (Boid other : Boids) {
      float d = PVector.dist(location, other.location);
      
      if (d > 0 && d < radiusSeparation) {
        PVector diff = PVector.sub(location, other.location);
        
        diff.normalize();
        diff.div(d);
        
        steer.add(diff);
        
        count++;
      }
    }
    
    if (count > 0) {
      steer.div(count);
    }
    
    if (steer.mag() > 0) {
      steer.setMag(topSpeed);
      steer.sub(velocity);
      steer.limit(topSteer);
    }
    
    return steer;
  }
  
  void SetAlpha(int alpha) {
    red = red(fillColor);
    g = green(fillColor);
    b = blue(fillColor);
    
    fillColor = color (red, g, b, alpha);    
  }
  
  
}
