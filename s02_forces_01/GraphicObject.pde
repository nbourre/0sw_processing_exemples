abstract class GraphicObject {
  PVector location = new PVector();
  PVector velocity = new PVector();
  PVector acceleration = new PVector();
  
  color fillColor = color (255);
  color strokeColor = color (255);
  float strokeWeight = 1;
  
  
  void setLocation(float x, float y) {
    location.x = x;
    location.y = y;
  }
  
  void setVelocity(float x, float y) {
    velocity.x = x;
    velocity.y = y;
  }
  
  abstract void update(float deltaTime);
  
  abstract void display();
  
}
