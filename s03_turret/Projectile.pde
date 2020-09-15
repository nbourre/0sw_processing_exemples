class Projectile extends GraphicObject {
  boolean isVisible = false;
  
  Projectile () {
    super();
  }
  
  void activate() {
    isVisible = true;
  }
  
  void setDirection(PVector v) {
    velocity = v;
  }
  
  
  void update(float deltaTime) {
    
    if (!isVisible) return;
    
    super.update();
    
    if (location.x < 0 || location.x > width || location.y < 0 || location.y > height) {
      isVisible = false;
    }
  }
  
  void display() {
    
    if (isVisible) {
      pushMatrix();
        translate (location.x, location.y);
        
        ellipse (0, 0, 3, 3);
      popMatrix();
    }
  }
}
