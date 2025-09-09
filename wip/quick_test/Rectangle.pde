class Rectangle extends Mover {
  PVector size;
    
  Rectangle() {
    instanciate();
    
    location.x = random(0, width - size.x);
    location.y = random(0, height - size.y);
  }
  
  Rectangle(float x, float y, float w, float h) {
    instanciate();
    
    size.x = w;
    size.y = h;
    location.x = x;
    location.y = y;
  }
  
  
  void instanciate () {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    
    size = new PVector (random (1, width / 4), random( 1, height / 4));
    fillColor = color (random (256), random(256), random(256));
  }
  
  void update(int deltaTime) {
  }
  
  void display() {
    pushMatrix();
      translate(location.x, location.y);
      rotate(angle);
      
      rectMode(CENTER);
      fill(fillColor);
      rect (0, 0, size.x, size.y);
      
    popMatrix();
  }
}
