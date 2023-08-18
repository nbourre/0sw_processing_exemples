class Cell {
  int x;
  int y;
  int w;
  int h;
  
  color fillColor;
  
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
  
  color getFillColor() {
    return fillColor;
  }
  
  void display () {
    pushMatrix();
    translate (x, y);
    fill (fillColor);
    rect (0, 0, w, h);
    popMatrix();
  }  
}
