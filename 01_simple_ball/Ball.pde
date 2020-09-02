class Ball {
  
  private float diameter = 15;
  
  PVector location = new PVector(50, 50);
  PVector velocity = new PVector(3, 2);
  PVector acceleration = new PVector ();
  
  float velocityLimit = 10;
  
  public float getX() {
    return location.x;
  }
  
  public float getY() {
    return location.y;
  }
  
  public float getLeft() {
    return location.x - diameter / 2;
  }
  
  public float getRight() {
    return location.x + diameter / 2;
  }
  
  public float getTop() {
    return location.y - diameter / 2;
  }
  
  public float getBottom() {
    return location.y + diameter / 2;
  }
  
  void update() {
    velocity.add (acceleration);
    
    if (velocity.mag() > velocityLimit) {
      velocity.normalize();
      velocity.mult(velocityLimit);
    }
    
    location.add (velocity);
    acceleration.mult(0);
    
    
  }
  
  void display() {
    ellipse (location.x, location.y, diameter, diameter);
  }
}
