abstract class GraphicObject {

  PVector location;
  PVector velocity;
  PVector acceleration;
  
  PVector size;
  
  abstract void update(int deltaTime);
  abstract void display();
}
