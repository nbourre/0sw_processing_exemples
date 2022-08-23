float x = 0;
float y = 0;
float xSpeed = 5.0;
float ySpeed = 1.0;
float radius = 16;

void setup () {
  size (800, 600);
}

void draw () {
  background(0);
  x += xSpeed;
  y += ySpeed;
  
  
  if (x > width || x < 0) {
    xSpeed *= -1;
  }
  
  if (y > height || y < 0) {
    ySpeed *= -1;
  }
  
  stroke(0);
  fill (175);
  
  ellipse (x, y, radius, radius);
}
