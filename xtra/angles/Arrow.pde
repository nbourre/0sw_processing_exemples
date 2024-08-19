class Arrow extends GraphicObject {
  
  float angle = 0.0;
  float angularVelocity = 0.0;
  float len = 20.0;
  float scale = 1;
  
  Arrow() {
    init();
  }
  
  void init() {
    acceleration = new PVector();
    velocity = new PVector();
    location = new PVector();
    
  }
  
  
  void update(int time) {
    velocity.add (acceleration);
    location.add (velocity);
    acceleration.mult(0);
    
    angle += angularVelocity;
    
    if (angle > TWO_PI || angle < -TWO_PI) {
      angle = 0;
    }
  }
  
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    scale (scale);
    
    stroke (strokeColor);
    line (0, 0, 0, -len);
    line (0, -len, len / 4, -len + len / 4);
    line (0, -len, -len / 4, -len + len / 4);
    
    popMatrix();
  }
  
}
