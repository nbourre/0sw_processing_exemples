class Map {
  private int _width;
  private int _height;
  
  PVector position = new PVector(); // Top-left
  
  String filename = "temp.jpg";
  boolean saved = false;
  PImage img;
  
  float [][] dem; // Data elevation model 
  
  public Map (int w, int h) {
    _width = w;
    _height = h;
    
    dem = new float[_width][_height];
  }
  
  public Map (String fn) {
    filename = fn;
    loadImg();
  }
  
  public void loadImg() {
    img = loadImage(filename);
    saved = true;
  }
  
  public void SaveImg() {
    save(filename);
    loadImg();
    saved = true;
  }
  
  public void setCell(int i, int j, float value) {
    dem[i][j] = value;
  }
  
  public void display() {
    pushMatrix();
    translate(position.x, position.y);
    
    if (saved) {
      
      image(img, 0, 0); //<>//
      
    } else {
      for ( int j = 0; j < _height; j++) {
        for (int i = 0; i < _width; i++) {
          
          //var v = map(dem[i][j], 0, 1, 0, 255);
          var v = dem[i][j];
          
          int c = color(0);
          if (v < 0.1)  c = color (0, 0, 200); // Water
          else if (v < 0.2) c = color (255,238,173); // Beach
          else if (v < 0.3) c = color (116,166,146); // Forest
          else if (v < 0.5) c = color (117,148,107); // Jungle
          else if (v < 0.7) c = color (147,196,125); // Savannah
          else if (v < 0.8) c = color (255,243,214); // Desert
          else c = color (250);
          
          stroke(c);
          point(i, j);
        }
      }
    }
    
    popMatrix();
  }
}
