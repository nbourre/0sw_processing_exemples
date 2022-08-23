Canon c;
ArrayList<Projectile> bullets;
int maxBullets = 10;

void setup() {
  size (800, 600);
  
  c = new Canon();
  
  bullets = new ArrayList<Projectile>();
  
}

int currentTime;
int previousTime = 0;
int deltaTime;

void draw() {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  render();
}

float angle = 0;

void update (float deltaTime) {
  c.update();
  
  for ( Projectile p : bullets) {
    p.update(deltaTime);
  }

}

void render() {
  background(0);
  
  
  for ( Projectile p : bullets) {
    p.display();
  }
  
  c.display();
  
}

void keyPressed() {
  if (key == 'a') {
      c.move (-1);
  }
  if (key == 'd') {
      c.move (1);
  }
  if (key == ' ') {
    fire (c);
  }
  

}

void fire(GraphicObject m) {
  Canon c = (Canon)m;
  
  if (bullets.size() < maxBullets) {
    Projectile p = new Projectile();
    
    p.location = c.getCanonTip().copy();
    p.topSpeed = 5;
    p.velocity = c.getShootingVector().copy().mult(p.topSpeed);
   
    p.activate();
    
    bullets.add(p);
  } else {
    for ( Projectile p : bullets) {
      if (!p.isVisible) {
        p.location.x = c.getCanonTip().x;
        p.location.y = c.getCanonTip().y;
        p.velocity.x = c.getShootingVector().x;
        p.velocity.y = c.getShootingVector().y;
        p.velocity.mult(p.topSpeed);
        p.activate();
        break;
      }
    }
  }  
}
