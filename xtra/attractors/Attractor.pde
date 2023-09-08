class Attractor extends GraphicObject {
  
  float mass;
  
  // Force de gravité
  float g;
  
  Attractor () {
   mass = 20;
   location = new PVector (width / 2, height / 2);
   g = .4;
  }
  
  //Attractor (PVector location) {
  //  mass = 20;
  //  g = 4;
    
  //  this.location = location;
  //}
  
  //Attractor (PVector location, float mass, float gravity) {
  //  this.location = location;
  //  this.mass = mass;
  //  this.g = gravity;
  //}
  
  PVector attractionForce(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain (distance, 5.0, 25.0);
    
    force.normalize();
    float strength = (g * mass * m.mass) / (distance * distance);
    force.mult(strength);
    
    return force;
  }
  
  void update(int deltaTime) {
  }
  
  void display () {
    pushMatrix();
    
      strokeWeight(1);
      stroke (0);
      fill (127);
      
      translate (location.x, location.y);
      
      ellipse (0, 0, mass * 2, mass * 2);
    
    popMatrix();
  }
  
}
