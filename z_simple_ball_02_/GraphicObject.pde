abstract class GraphicObject {

  PVector location = new PVector();
  PVector velocity = new PVector();
  abstract void update(int deltaTime);
  abstract void display();
}
