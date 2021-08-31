abstract class GraphicObject {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  color fillColor = color (255);
  color strokeColor = color (255);
  float strokeWeight = 1;
  
  abstract void update(float deltaTime);
  
  abstract void display();
  

}
