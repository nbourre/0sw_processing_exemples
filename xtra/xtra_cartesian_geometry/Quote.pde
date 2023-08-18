class Quote {
  PVector start;
  PVector end;
  PVector offset;
  
  String text;
  
  Quote () {
    start = new PVector();
    end = new PVector();
    offset = new PVector();
    
    text = "";
  }
  
  void update(float deltaTime) {
  }
  
  void display() {
    pushMatrix();
    translate (offset.x, offset.y);
    
    strokeWeight (1);
    stroke (127);
    
    line (start.x, -5, start.x, 5);
    line (start.x, 0, end.x, 0);
    line (end.x, -5, end.x, 5);
    
    text = Float.toString(end.x - start.x);
    
    text (text, -end.y  - textWidth(text)/2, start.x * .5);
    
    popMatrix();
  }
  
  void setOffset (float x, float y) {
    offset.x = x;
    offset.y = y;
  }
  
  void setStart (float x, float y) {
    start.x = x;
    start.y = y;
  }
  
  void setEnd (float x, float y) {
    end.x = x;
    end.y = y;
  }
  
}
