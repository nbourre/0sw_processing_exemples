class Particle extends GraphicObject {
  
  float lifespan;
  PVector startLocation;
  PImage texture;

 
  Particle() {
    location = new PVector(width/2, height/3);
    initialize();
  }

  Particle(PVector l) {
    location = l.copy();
    initialize();
  }
  
  void setTexture(PImage texture) {
    this.texture = texture; 
  }
  
  void initialize() {
    startLocation = location.copy();
    velocity = new PVector(randomGaussian() * 0.3, randomGaussian() * 0.3 - 1);
    acceleration = new PVector(0, 0.05);
    lifespan = 255;
  }

  void update(int deltaTime) {
    
    velocity.add(acceleration);
    location.add(velocity);
    
    acceleration.mult(0);
    lifespan -= 2.0;
    
    if(isDead()) reset();
  }

  void display() {
    stroke(0, lifespan);
    fill(175, lifespan);
    
    if (texture != null) {
      imageMode(CENTER);
      tint(0, 200, 0, this.lifespan);
      image(texture, location.x, location.y);
    } else {
      ellipse(location.x, location.y, 10, 10);
    }
  }
  
  void applyForce (PVector f) {
    acceleration.add(f);
  }
  
  boolean isDead() {
    return lifespan < 0.0;
  }
  
  void setXY(float x, float y) {
    startLocation.set (x, y);
  }
  
  void reset() {
    location.set (startLocation.x,  startLocation.y);
    velocity.set (randomGaussian() * 0.3, randomGaussian() * 0.3 - 1);    
    lifespan = 100;
  }
}
