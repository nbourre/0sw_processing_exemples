class Block extends Rectangle {
  int w = 50;
  int h = 10;
  ICollidable collidable;
  
  Block() {
    location = new PVector(width / 2, height / 2);
    fillColor = color(0, 200, 0);
    
  }
  
  void addCollidable(ICollidable other) {
    collidable = other;
  }
  

  
  void update (int deltaTime) {

  }
  
  
  void display () {
    pushMatrix();
      translate(location.x, location.y);
      fill(fillColor);
      rect(0, 0, w, h);
    popMatrix();
  }

  
}
