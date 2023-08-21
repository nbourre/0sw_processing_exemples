float yoff = 0.0;
float previous;

float t = 0;
float n = noise(yoff) * height;

float dir = 1;
float inc = 0.01;

void setup () {
  size (800, 600);
  background(204);
}

float ui_x, ui_y;
float ui_x_previous;

int offsetX = 80;
int offsetY = 60;

int strokeColor = 0;

void draw() {
  
  drawAxis();
  
  previous = ui_y;
  
  n = noise(yoff);

  if (t > width) {
    t = 0;
    //inc *= 2;
    //strokeColor = (strokeColor  + 64 ) % 256;
  }
  
  t++;
  yoff = yoff + inc;
  
  ui_x = map (t, 0, width, 0, 640) + offsetX ;
  ui_x_previous = map (t - 1, 0, width, 0, 640) + offsetX;
  ui_y = map (n, 0, 1, 0, 480) + offsetY;
  
  
  
  if (previous > 0) {
    strokeWeight (1);
    
    //if (ui_x % 1 == 0) {
    //  ellipse (ui_x, ui_y, 2, 2);
    //}
    
    //if (ui_x % 20 == 0) {
    //  noFill();
    //  ellipse (ui_x, ui_y, 10, 10);
    //}
    
    stroke (strokeColor);
    line (ui_x_previous, previous, ui_x, ui_y);
  }
  
  println (n);
  
}

void drawAxis () {
  strokeWeight (3);
  stroke (0);
  line (offsetX, offsetY, offsetX, 480 + offsetY);
  line (offsetX, 480 + offsetY, offsetX + 640, offsetY + 480);
  fill (0);
  
  textSize(24);
  text("t -->", offsetX + 320, 480 + offsetY + 20);
  text("increment = " + inc, 50, 50);
}