float MAX_HEIGHT = 250;


float step = 0.01;

float noiseVal;
float noiseScale=0.02;

int tileX = 200;
int tileY = 200;
float tileSize = 2;

float totalWidth = tileX * tileSize;
float totalHeight = tileY * tileSize;

float xOff = 0.0;
float yOff = 0.0;

float[][] height_map = new float[tileX][tileY];

void setup () {
  size (800, 600, P3D);
  generate_height_map();  
}


void draw() {
  background(0);
  lights();

  translate ((width - totalWidth), height / 2);
  rotateX (PI/8 * map (mouseY, 0, height, -PI, 0));
  rotateY (PI/8 * map (mouseX, 0, width, -PI, PI));
  
  for (int x = 0; x < tileX; x++) {
    for (int y = 0; y < tileY; y++) {
      set_color (height_map[x][y]);
      point (x, height_map[x][y] * MAX_HEIGHT, y);
    }
  }
}


void generate_height_map() {
  
  xOff = 0;
  
  for (int x = 0; x < tileX; x++) {
    yOff = 0;
    for (int y = 0; y < tileY; y++) {
      height_map[x][y] = noise (xOff, yOff);
      yOff += 0.01;
    }
    xOff+= 0.01;
  }
}

void set_color(float h ) {
  float g = 255 * h;
  
  stroke(0, g, 0);

}
