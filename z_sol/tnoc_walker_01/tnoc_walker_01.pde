Walker w;

void setup () {
  size (480, 320);
  
  w = new Walker();
  
  background (255);
}

void draw () {
  background(127);
  w.step();
  w.display();
}
