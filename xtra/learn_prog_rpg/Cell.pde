class Cell {
  int x;
  int y;
  int w;
  int h;
  
  
  color fillColor;
  
  PImage overlay;
  int imgWidth = 10;
  int imgHeight = 10;
  int imgX = 0;
  int imgY = 0;
  
  Cell (int _x, int _y) {
    init (_x, _y, 50, 50);
  }
  
  Cell (int _x, int _y, int _w, int _h) {
    init (_x, _y, _w, _h);
  }
  
  void init(int _x, int _y, int _w, int _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    
    fillColor = 255;
  }
  
  void setFillColor (color c) {
    fillColor = c;
  }
  
  void setOverlayImage(PImage img) {
    overlay = img;
    imgWidth = overlay.width / ((overlay.width / w) + 2);
    imgHeight = overlay.height / ((overlay.height / h) + 2);
    imgX = (w - imgWidth) / 2;
    imgY = (h - imgHeight) / 2;
    print(imgWidth);
  }
  
  PImage getOverlayImage() {
    return overlay;
  }
  
  color getFillColor() {
    return fillColor;
  }
  
  void display () {
    pushMatrix();
    translate (x, y);
    
      fill (fillColor);
      strokeWeight(2);
      rect (0, 0, w, h);
      
      if (overlay != null) {
        image(overlay, imgX, imgY, imgWidth, imgHeight);
      }
    popMatrix();
  }  
}
