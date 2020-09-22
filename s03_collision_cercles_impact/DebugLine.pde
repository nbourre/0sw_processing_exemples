class DebugLine extends GraphicObject {
  
  private PVector start;
  private PVector end;
  
  float len;
  
  
  
  DebugLine(float x1, float y1, float x2, float y2) {
    instanciate();
    start.set (x1, y1);
    end.set (x2, y2);
    
    len = PVector.dist(start, end);
    
    strokeColor = color (0);
  }
  
  void instanciate() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    
    start = new PVector();
    end = new PVector();
  }
  
  void update(float deltaTime) {

  }
  
  void setStart (float x, float y) {
    start.set (x, y);
    len = PVector.dist(start, end);
  }
  
  void setEnd (float x, float y) {
    end.set (x, y);
    len = PVector.dist(start, end);
  }
  
  void display() {
    pushMatrix();
      translate(location.x, location.y);
      
      stroke (strokeColor);
      strokeWeight (strokeWeight);
      
      fill (0);
      text (nf (len, 3, 1), (end.x - start.x) / 2 + start.x, (end.y - start.y) / 2 + start.y);      
      
      line (start.x, start.y, end.x, end.y);
    popMatrix();
  }
}
