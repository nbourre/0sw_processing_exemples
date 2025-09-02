class Proie extends GraphicObject {
  
  float angle = 0.0;
  float size = 20;
  
  Proie (int x, int y) {
    instantiate();
    location.x = x;
    location.y = y;
  }
  
  void instantiate() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
  }
  
  void update(int deltaTime) {
    velocity.add(acceleration);
    location.add(velocity);
    
    acceleration.mult(0);
  }
  
  void display(){
    pushMatrix();
      translate(location.x, location.y);
      
      
      fill (0, 0, 200);
      ellipse (0, 0, size, size);
    
    popMatrix();
  }
}
