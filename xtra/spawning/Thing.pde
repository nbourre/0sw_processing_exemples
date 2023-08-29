class Thing extends GraphicObject {
  public boolean isAlive = true;
  int w = 40;
  int h = 60;
  int mass = 1;
  int lastTime = 0;
  
  PImage drop;
  
  Thing() {
    init();
    
    location.x = width / 2;    
  }
  
  void init() {
    drop = loadImage("drop.png");
    location = new PVector(0, -w);
    velocity = new PVector();
    acceleration = new PVector();
  }
  
  void update (int time) {
    if (!isAlive) return;
    
    velocity.add(acceleration);
    
    // Cette opération permet de toujours avoir la même vitesse
    // peu importe le frameRate
    var fraction = PVector.mult(velocity, ((time - lastTime) / 1000f));
    location.add(fraction);
    
    acceleration.mult(0);
    
    if (location.y - h > height || location.y + h < 0 ||
        location.x - w > width || location.x + w < 0) {
      isAlive = false;
    }
    
    lastTime = time;
  }
  
  
  void display() {
    if (!isAlive) return;
    
    pushMatrix();
      translate (location.x, location.y);
      
      image(drop, 0, 0, w, h);
      //ellipse(0, 0, size, size);
    
    popMatrix();
  }
  
  public void applyForce (PVector _force) {
    PVector force = PVector.div(_force, mass);
    acceleration.add(force);
  }
  
  public void respawn() {
    location.x = random(0, width);
    location.y = -h;
    isAlive = true;
    velocity.y = 0;
  }
}
