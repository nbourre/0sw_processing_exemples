Arrow[][] arrows;

int ARROW_LENGTH = 15;
int ARROW_WIDTH = 5;

int cols = 15;
int rows = 15;


void setup () {
  size (800, 600);
  initArrows (cols, rows);
}


void draw () {
   background (255);
   stroke (0);
  
   drawArrows();
}

void drawArrows() {
  int xPadding = 15;
  int yPadding = 15;
  
  int xOffset = (width - (cols * (ARROW_LENGTH + xPadding))) / 2;
  int yOffset = (height - (rows * (ARROW_LENGTH + yPadding))) / 2;
  
  
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      Arrow current = arrows[x][y];

      current.x = x * (current.len + xPadding) + xOffset;
      current.y = y * (current.len + yPadding) + yOffset;
      
      current.angle = atan2 (mouseY - current.y, mouseX - current.x);
      
      current.display();
    }
  }
}

void initArrows (int w, int h) {
  arrows = new Arrow[w][h];
  
  for (int y = 0; y < h; y++) {
    for (int x = 0; x < w; x++) {
      arrows[x][y] = new Arrow();
      arrows[x][y].len = ARROW_LENGTH;
      arrows[x][y].w = ARROW_WIDTH;
    }
  }
}