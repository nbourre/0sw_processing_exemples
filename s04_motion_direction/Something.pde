class Something extends GraphicObject {
  float angularVelocity = 0.0;
  float angularAcceleration = 0.0;
  
  float angle = 0.0;  
  
  float w = 20;
  float h = 10;
  
  
  Something() {
    initValues();
  }
  
  void initValues() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    
    
  }
  
  void update(float deltaTime) {
    velocity.add(acceleration);
    location.add(velocity);
    
    acceleration.mult(0);
    
    angle = atan2(velocity.y, velocity.x); 
  }
  
  void display() {
    pushMatrix();
      rectMode(CENTER);
      translate (location.x, location.y);
      rotate (angle);
      
      fill(fillColor);
      noStroke();
      
      rect (0, 0, w, h);
    popMatrix();
  }
}
