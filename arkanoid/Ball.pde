class Ball extends GraphicObject {
  
  int radius = 10;
  
  
  Ball (int _x, int _y) {
    location = new PVector(_x, _y);

  }
  
  
  void update(int delta) {
    
  }
  
  void display() 
  {
    pushMatrix();
      translate(location.x, location.y);
      fill(fillColor);
      ellipse(0, 0, radius, radius);
    popMatrix();
  }
  
  float top() {
    return location.y - radius;
  }
  
  float bottom() {
    return location.y + radius;
  }
  
  float left() {
    return location.x - radius;
  }
  
  float right() {
    return location.x + radius;
  }
  
  
}
