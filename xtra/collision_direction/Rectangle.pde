class Rectangle extends GraphicObject {
  int w, h;
  
  Rectangle () {
    instanciate();
  }
  
  Rectangle (float x, float y, int _w, int _h) {
    instanciate();
    
    location.x = x;
    location.y = y;
    w = _w;
    h = _h;
  }
  
  void instanciate() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    
    w = 100;
    h = 50;
  }
  
  void update(int deltaTime) {
    checkEdges();
    
    velocity.add (acceleration);
    location.add (velocity);
    
    acceleration.mult(0);
  }
  
  void display() {
    pushMatrix();
      translate (location.x, location.y);
      fill(fillColor);
      rect (0, 0, w, h);
    popMatrix();
  }
  
  // Fonction facilitant la compréhension des conditions
  public int top() { return (int)location.y; }
  public int bottom() { return (int)location.y + h; }
  public int left() { return (int)location.x; }
  public int right() { return (int)location.x + w; }
    
  void checkEdges() {
    if (left() < 0 || right() > width) {
      velocity.x *= -1;
    }
    
    if (top() < 0 || bottom() > height) {
      velocity.y *= -1;
    }
  }
  
  public void checkCollisions(Rectangle other) {
    if (isBouncingX(other)) {
      velocity.x *= -1;
    }
    
    if (isBouncingY(other)) {
      velocity.y *= -1;
    }
  }
  
  // Retourne vrai s'il y a un contact en X
  public boolean isBouncingX(Rectangle other) {
    // Si je continue en X est-ce que je vais
    // avoir une collision avec l'autre
    // On doit regarder dans le futur
    boolean passLeft = right() + velocity.x > other.left();
    boolean passRight = left() + velocity.x < other.right();
    
    boolean checkTop = bottom() > other.top();
    boolean checkBottom = top() < other.bottom();
    //<>//
    return passLeft && passRight && checkBottom && checkTop;
  }
  
  // Retourne vrai s'il y a un contact en Y
  public boolean isBouncingY(Rectangle other) {

    boolean checkRight = right() > other.left();
    boolean checkLeft = left() < other.right();
    
    // Si je continue en Y est-ce que je vais
    // avoir une collision avec l'autre
    boolean passBottom = bottom() + velocity.y > other.top();
    boolean passTop = top() + velocity.y < other.bottom();
    
    return checkRight && checkLeft && passBottom && passTop;
  }
  
  
}
