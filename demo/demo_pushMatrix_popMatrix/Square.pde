class Square extends GraphicObject {
  
  Square child;
  
  Square () {
    location = new PVector();
    size = new PVector (200, 200);
    
  }
  
  void createChild () {
    child = new Square();
    child.location.x = 10;
    child.location.y = 10;
    child.size.x = 20;
    child.size.y = 30;
  }
  
  int dir = 2;
  
  float angle = 0;
  
  void update (int delta) {
    if (location.x + size.x > width ||location.x  < 0) {
      dir = -dir;
    }
    
    angle += TWO_PI / 360.0;
    location.x += dir;
  }
  
  void display () {
    
    pushMatrix();
    translate (location.x, location.y);
    rotate (angle);
    stroke (255);
    noFill();
    rect (0, 0, size.x, size.y);
    
    if (child != null) {
        child.display();
    }
    
    popMatrix();
  }
}
