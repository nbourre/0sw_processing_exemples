void setup () {
  size (480, 320);
  background (255);
}

void draw () {
  if (mousePressed && mouseButton == LEFT) {
    int x = parseInt(randomGaussian() * 10 );
    int y = parseInt(randomGaussian() * 10 );
    
    //fill(50, 50, 50, 50);
    //noStroke();
    ellipse (mouseX + x, mouseY + y, 5, 5);
  }
}
