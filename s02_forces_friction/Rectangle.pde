class Rectangle {
  float x, y, w, h;
  
  Rectangle(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
   
  void display() {
    rect (x, y, w, h);
  }
}
