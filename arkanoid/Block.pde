class Block extends GraphicObject {
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
  

  
  void update (float delta) {
    if (hasCollision(collidable)) {
      print ("boom");
    }
  }
  
  
  void display () {
    pushMatrix();
      translate(location.x, location.y);
      fill(fillColor);
      rect(0, 0, w, h);
    popMatrix();
  }
  
  float top() {
    return location.y;
  }
  
  float bottom() {
    return location.y + h;
  }
  
  float left() {
    return location.x;
  }
  
  float right() {
    return location.x + w;
  }
  
  boolean hasCollision(ICollidable other) {
    if (other == null) return false;
    
    return other.bottom() > top() && other.top() < bottom()
        && other.left() < right() && other.right() > left();
  }
}
