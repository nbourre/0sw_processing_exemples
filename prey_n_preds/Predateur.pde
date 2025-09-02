class Predator extends GraphicObject {
  
  float angle = 0.0;
  float size = 10;
  
  Predator (int x, int y) {
    instantiate();
    angle = random (0, TWO_PI);
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
      rotate(angle);
      
      
      //fill (200, 127);
      //ellipse(0, 0, 100, 100);
      
      fill (200, 0, 0);
      triangle (0, -size, size, size, -size, size);
      

    
    popMatrix();
  }
}
