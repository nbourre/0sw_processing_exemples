class Mover extends GraphicObject {
  float diameter = 25;
  float radius = 13;
  
  PVector tempLoc = new PVector();
  
  void checkEdges() {
    tempLoc.x = location.x;
    tempLoc.y = location.y;
    
    tempLoc.add(velocity);
    
    if (tempLoc.x - radius < 0 || tempLoc.x + radius > width) {
      velocity.x = -velocity.x;
    }
    
    if (tempLoc.y - radius < 0 || tempLoc.y + radius > height) {
      velocity.y = -velocity.y;
    }
  }
  
  void update(float deltaTime) {
    checkEdges();
    
    velocity.add(acceleration);
    location.add(velocity);
    
    acceleration.x = 0;
    acceleration.y = 0;
  }
  
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    
    fill(fillColor);
    stroke(strokeColor);
    strokeWeight(strokeWeight);
    
    ellipse(0, 0, diameter, diameter);
    
    popMatrix();
  }
  
}
