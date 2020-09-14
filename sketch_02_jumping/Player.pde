// Rename ShapeTemplate to whatever needed
class Player extends GraphicObject {
  
  int w, h; 
  
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
    location.add (velocity);
    
    acceleration.mult(0);
  }
  
  void display() {
    pushMatrix();
      translate(location.x, location.y);

      rect (0, 0, w, h);

      fill(fillColor);

    popMatrix();
  }
  

}
