Walker w;

void setup () {
  size (800, 600);
  
  w = new Walker();
  
  background (255);
}

void draw () {
  w.step();
  w.display();
    
}

void keyPressed() {
  if (key == 'r') {
    reset();
  }
}

void reset() {
  background ( 255);
  w.setXY(width / 2, height / 2);
}
