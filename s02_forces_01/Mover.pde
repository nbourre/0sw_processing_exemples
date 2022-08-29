class Mover extends GraphicObject {
  float w = 25;
  float h = 25;
  
  void checkEdges() {
    if (location.x < 0 || location.x > width) {
      velocity.x = -velocity.x;
    }
    
    if (location.y < 0 || location.y > height) {
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
    
    ellipse(0, 0, w, h);
    
    popMatrix();
  }
  
}
