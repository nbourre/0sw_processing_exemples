float yoff = 0.0;
float previous;

float t = 0;
float n = noise(yoff) * height;

float dir = 1;
float inc = 0.01;



float ui_x, ui_y;
float ui_x_previous;

int offsetX = 80;
int offsetY = 60;

int strokeColor = 0;
int bgColor = 204;

int yAxisHeight = 480;
int yLineLblOffset = 20;

Boolean teachingMode = false;

void setup () {
  size (800, 600);
  background(bgColor);
}

void draw() {
  
  drawAxis();
  
  previous = ui_y;
  
  n = noise(yoff);

  if (t > width) {
    t = 0;
    yLineLblOffset += 20;
    //inc *= 2;
    //strokeColor = (strokeColor  + 64 ) % 256;
  }
  
  t++;
  yoff = yoff + inc;
  
  ui_x = map (t, 0, width, 0, 640) + offsetX ;
  ui_x_previous = map (t - 1, 0, width, 0, 640) + offsetX;
  ui_y = map (n, 0, 1, 0, yAxisHeight) + offsetY;
  
  
  
  if (previous > 0) {
    
    strokeWeight (1);
    stroke (strokeColor);
    line (ui_x_previous, previous, ui_x, ui_y);
    
    if (teachingMode) {
      if (((int)(yoff * 100)) % 100 == 0) {
        stroke(bgColor - 30);
        line (ui_x, offsetY, ui_x, offsetY + yAxisHeight);
        textAlign(RIGHT);
        textSize(18);
        text(round(yoff * 10) / 10f, ui_x - 10, offsetY + yLineLblOffset);
      }
      
      stroke(0);
      
      if (ui_x % 1 == 0) {
        ellipse (ui_x, ui_y, 2, 2);
      }
      
      if (ui_x % 20 == 0) {
        noFill();
        ellipse (ui_x, ui_y, 10, 10);
      }
      

    }
    

  }
  
  println ((int)(yoff * 100));
  
}

void keyPressed() {
  switch (key) {
    case ' ' :
      teachingMode = !teachingMode;
      break;
  }
}

void drawAxis () {
  strokeWeight (3);
  stroke (0);
  // Axe Y
  line (offsetX, offsetY, offsetX, yAxisHeight + offsetY);
  
  // Axe X
  line (offsetX, yAxisHeight + offsetY, offsetX + 640, offsetY + yAxisHeight);
  fill (0);
  
  textSize(24);
  textAlign(LEFT);
  text("t -->", offsetX + 320, yAxisHeight + offsetY + 20);
  text("increment = " + inc, 50, 50);
}
