class Boid extends GraphicObject {
  float topSpeed = 5;
  float topSteer = 0.03;
  
  float mass = 1;
  
  float theta = 0;
  float r = 10; // Rayon du boid
  
  float radiusSeparation = 10 * r;
  float radiusAlignment = 20 * r;

  float weightSeparation = 1.5;
  float weightAlignment = 1;
  
  PVector steer;
  PVector sum;

  boolean debug = false;
  String debugMessage = "";
  int msgCount = 0;
  
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
    PVector alignment = align(boids);
    
    separation.mult(weightSeparation);
    alignment.mult(weightSeparation);

    applyForce(separation);
    applyForce(alignment);
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
    
    if (debug) {
      renderDebug();
    }
  }
  
  PVector separate (ArrayList<Boid> boids) {
    if (steer == null) {
      steer = new PVector(0, 0, 0);
    }
    else {
      steer.setMag(0);
    }
    
    int count = 0;
    
    for (Boid other : boids) {
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

  PVector align (ArrayList<Boid> boids) {

    if (sum == null) {
      sum = new PVector();      
    } else {
      sum.mult(0);

    }

    int count = 0;

    for (Boid other : boids) {
      float d = PVector.dist(this.location, other.location);

      if (d > 0 && d < radiusAlignment) {
        sum.add(other.velocity);
        count++;
      }
    }

    if (count > 0) {
      sum.div((float)count);
      sum.setMag(topSpeed);


      PVector steer = PVector.sub(sum, this.velocity);
      steer.limit(topSteer);

      return steer;
    } else {
      return new PVector();
    }
      
    
  }
  
  void applyForce (PVector force) {
    PVector f;
    
    if (mass != 1)
      f = PVector.div (force, mass);
    else
      f = force;
   
    this.acceleration.add(f);    
  }
  
  void renderDebug() {
    pushMatrix();
      noFill();
      translate(location.x, location.y);
      
      strokeWeight(1);
      stroke (255, 0, 0);
      ellipse (0, 0, radiusSeparation * 2, radiusSeparation * 2);

      stroke (0, 255, 0);
      ellipse (0, 0, radiusAlignment * 2, radiusAlignment * 2);
      
    popMatrix();


    if (msgCount % 60 == 0) {
      msgCount = 0;
      if (debugMessage != "") {
        println(debugMessage);
        debugMessage = "";
      }
    }

    msgCount++;
    
  }
}
