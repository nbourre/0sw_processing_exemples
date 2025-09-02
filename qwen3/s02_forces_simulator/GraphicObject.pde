abstract class GraphicObject {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  GraphicObject() {
    this.location = new PVector(0, 0);
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
  }
  
  GraphicObject(PVector loc) {
    this.location = loc;
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
  }
  
  abstract void update(int deltaTime);
  abstract void display();
}
