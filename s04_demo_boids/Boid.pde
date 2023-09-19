class Boid extends GraphicObject {
  float topSpeed = 2;
  float topSteer = 0.03;
  
  float theta = 0;
  float r = 10; // Rayon du boid
  
  float radiusSeparation = 6 * r;

  float mass = 1.0;
  
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
  
  void flock (ArrayList<Boid> boids) {
    PVector separation = separate(boids);
    
    applyForce(separation);
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
    
    if (debugMode) {
      rotate(-theta);
      displayDebugCircle(radiusSeparation, color (0, 255, 0), "Separation");
    }
    
    popMatrix();  
  }
  
  void displayDebugCircle(float radius, color c, String title) {
    noFill();
    stroke(c);
    strokeWeight(2);
    
    if (title != null && title != "") {
      float sz = textWidth(title);
      text(title, -sz / 2, -radius + 10);
    }
    
    ellipse(0, 0, radius * 2, radius * 2);
  }
  
  PVector separate (ArrayList<Boid> boids) {
    PVector steer = new PVector(0, 0, 0);
    
    int count = 0;
    
    for (Boid other : boids) {
      float d = PVector.dist(location, other.location);
      
      if (d > 0 && d < radiusSeparation) {
        PVector diff = PVector.sub(location, other.location);
        
        diff.normalize(); // Ramène à une longueur de 1
        
        // Division par la distance pour pondérer.
        // Plus qu'il est loin, moins qu'il a d'effet
        diff.div(d); 
        
        // Force de braquage
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

  void applyForce (PVector force) {
    PVector f;
    
    if (mass != 1)
      f = PVector.div (force, mass);
    else
      f = force;
   
    this.acceleration.add(f);    
  }
  
  void setAlpha(int alpha) {
    red = red(fillColor);
    g = green(fillColor);
    b = blue(fillColor);
    
    fillColor = color (red, g, b, alpha);    
  }
  
  void setDebugMode(boolean debugMode) {
    this.debugMode = debugMode;
  }
}
