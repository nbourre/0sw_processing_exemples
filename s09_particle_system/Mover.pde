abstract class Mover implements IGraphicObject {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  
  color strokeColor = 200;
  color fillColor = 200;
  
  public void applyForce(PVector force) {
    PVector f = force.copy();
    f.div(mass);
    acceleration.add(f);
  }
  
  
}
