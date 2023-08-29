abstract class GraphicObject {
  public PVector location;
  public PVector velocity;
  public PVector acceleration;
  
  color fillColor = color (255);
  color strokeColor = color (255);
  float strokeWeight = 1;
  
  abstract void update(int deltaTime);
  
  abstract void display();
  
}
