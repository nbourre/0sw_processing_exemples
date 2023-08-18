class Grid {
  PVector location;
  float xSpacing;
  float ySpacing;
  color lineColor;
  
  int xAxis;
  int yAxis;
  
  Grid () {
    initDefault();
    
  }
  
  void initDefault() {
    xSpacing = 20;
    ySpacing = 20;
    
    xAxis = 1;
    yAxis = 1;
    
    lineColor = 50;
    location = new PVector();
  }
  
  void update(float deltaTime) {
  }
  
  void display() {
    int iCount = 0;
    int jCount = 0;
    
    for (int i = 0; i < width; i+= xSpacing) {
      stroke(lineColor);
      
      if (iCount == xAxis) {
        strokeWeight(3);
        stroke(color (0, 127, 0));
      } else {
        strokeWeight(1);
      }
      
      line (i, 0, i, height);
      iCount++;
    }
    
    for (int j = 0; j < height; j+= ySpacing) {
      stroke(lineColor);
      
      if (jCount == yAxis) {
        strokeWeight(3);
        stroke(color (0, 127, 0));
      } else {
        strokeWeight(1);
      }
      
      line (0, j, width, j);
      jCount++;
    }
  }
  
}
