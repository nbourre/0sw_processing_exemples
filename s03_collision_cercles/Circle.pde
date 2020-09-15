class Circle extends GraphicObject {
  
  private float radius;
  private float diametre;
  
  
  
  Circle () {
    instanciate();
  }
  
  Circle (float x, float y, float radius) {
    instanciate();
    location.x = x;
    location.y = y;
    
    setRadius(radius);
  }
  
  
  
  void instanciate() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    
    setRadius(10);
  }
  
  void setRadius(float radius) {
    this.radius = radius;
    diametre = 2 * radius;
  }
  
  float getRadius() {
    return radius;
  }
  

  void update(float deltaTime) {
    velocity.add(acceleration);
    location.add (velocity);
    
    acceleration.mult(0);
  }
  
  void display() {
    pushMatrix();
      translate(location.x, location.y);
      
      fill(fillColor);
      
      ellipse(0, 0, diametre, diametre);
      
      displayDebug();
    popMatrix();
    
  }
  
  // Collision simple
  // Si la somme des deux rayons est supérieure à la distance
  // des centres, il y a alors une collision
  boolean isCollidingCircle(Circle other) {
    boolean result = false;
    
    float distance = PVector.dist(this.location, other.location);
    
    if ((this.getRadius() + other.getRadius()) >= distance) {
      result = true;
    }
    
    
    return result;
  }
  
  void displayDebug() {
    if (!debug) return;
    
    fill(0);
    text ("r = " + radius, 0, 0);
  }
  
  
}
