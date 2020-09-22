class Rectangle {
  float x, y, w, h;
  
  Rectangle(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  
  Boolean contains(Rectangle _r) {
    Boolean result = false;
    
    if (left() <= _r.left() && (right() >= _r.right()) && 
        top() <= _r.top() && (bottom() >= _r.bottom())) {
      result = true;
    }
    
    return result;
  }
  
  float left () {return x;}
  float top () {return y;}
  float right () {return x + w;}
  float bottom () {return y + h;}
  
  Boolean intersect(Rectangle _r) {
    Boolean result = false;
    
    if (!(this.left() > _r.right() ||
        this.right() < _r.left() ||
        this.top() > _r.bottom() ||
        this.bottom() < _r.top())) {
      result = true;
    }
        
    return result;
  }
   
  void display() {
    rect (x, y, w, h);
  }
}
