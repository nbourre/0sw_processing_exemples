Ball aBall;

void setup () {
  size (800, 600);
  
  aBall = new Ball();
  aBall.location.y = height / 2;
  aBall.diameter = 25;
  aBall.location.x = aBall.diameter;
}

PVector mouse = new PVector();
PVector dir = new PVector();

void draw() {
  
  mouse.x = mouseX;
  mouse.y = mouseY;
  
  if (mousePressed) {
    if (mouseButton == LEFT) {
      aBall.acceleration.x = 1;
    }
    if (mouseButton == RIGHT) {
      aBall.acceleration.x = -1;
    }
  }
  
  dir = PVector.sub(mouse, aBall.location);
  
  aBall.velocity.x = dir.x * 0.1;
  aBall.velocity.y = dir.y * 0.1;
  
  aBall.update();
  
  if (aBall.getRight() > width || aBall.getLeft() < 0) {
    aBall.velocity.x *= -1;
  }
  
  if (aBall.getBottom() > height || aBall.getTop() < 0) {
    aBall.velocity.y *= -1;
  }
  
  background (0);
  aBall.display();  
}
