// Rename ShapeTemplate to whatever needed
class Player extends GraphicObject {
  
  int w, h;
  int mass = 1;
  float speedLimit = 10;
  
  float floor;

  
  Player () {
    instanciate();
  }
  
  Player (float x, float y) {
    instanciate();
    location.x = x;
    location.y = y;
  }
  
  void setWidth(int w) {
    this.w = w;
  }
  
  int getWidth() {
    return w;
  }
  
  void setHeight (int h) {
    this.h = h;
  }
  
  int getHeight() {
    return h;
  }
  
  void setXY(int x, int y) {
    location.x = x;
    location.y = y;
  }
  
  void instanciate() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    
    w = 50;
    h = 100;
  }  

  void update(float deltaTime) {
    velocity.add(acceleration);
    
    float speed = velocity.mag();
    if (speed > speedLimit) {
      velocity.limit(speedLimit);
    } else if (speed < 0.1) {
      velocity.mult(0);
    }
    
    location.add (velocity);
    
    // Plancher
    if (floor > 0) {
      if (location.y + getHeight() > floor) {
        location.y = floor - getHeight();
      }
    }
    
    acceleration.mult(0);
  }
  
  boolean onFloor() {
    return location.y + getHeight() == floor;
  }
  
  void display() {
    pushMatrix();
      translate(location.x, location.y);

      rect (0, 0, w, h);

      fill(fillColor);

    popMatrix();
  }
  
  void applyForce (PVector force) {
    PVector f = force.copy();
    f.div(mass);
    acceleration.add (f);
  }
  

}
