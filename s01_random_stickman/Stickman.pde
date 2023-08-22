class Stickman {
  PVector location;
  
  float armAngle = 0;
  PVector armLocation = new PVector(0, 50);
  float scale = 1;
  
  Stickman () {
    location = new PVector();
  }
  
  void update(float deltaTime) {
    armAngle = atan2 (mouseY - (location.y + armLocation.y), mouseX - (location.x + armLocation.x));
  }
  
  void display() {
    pushMatrix();
      translate (location.x, location.y);
      scale(scale);
      stroke(0);
      noFill();
      ellipse (0, 0, 50, 50);
      line (0, 25, 0, 100);
      
      line (0, 100, -25, 200);
      line (0, 100, 25, 200);
      
      pushMatrix();
        translate(armLocation.x, armLocation.y);
        rotate (armAngle);
        line (0, 0, 50, 0);
      popMatrix();
      
      
      line (0, 50, -25, 100);
            
    popMatrix();
  }
  
  void setLocation(float x, float y) {
    location.x = x;
    location.y = y;
  }
  
}
