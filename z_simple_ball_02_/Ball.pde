class Ball extends GraphicObject {

  int diameter = 30;
  int radius = diameter / 2;
  
  void update(int deltaTime) {
    checkEdge();
    location.add(velocity);
    
  }
  
  void display() {
    pushMatrix();
    translate (location.x, location.y);
    ellipse (0, 0, diameter, diameter);
    popMatrix();
  }
  
  void setDiameter(int d) {
    diameter = d;
    radius = diameter / 2;
  }
  
  float getLeft () {
    return location.x - radius;
  }
  
  float getRight () {
    return location.x + radius;
  }
  
  float getTop() {
    return location.y - radius;
  }
  
  float getBottom() {
    return location.y + radius;
  }
  
  void checkEdge() {
    if (getLeft() < 0 || getRight() > width) {
      velocity.x *= -1;
    }
    
    if (getTop() < 0 || getBottom() > height) {
      velocity.y *= -1;
    }
  }
}
