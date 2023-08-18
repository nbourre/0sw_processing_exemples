class Line extends GraphicObject {
  PVector start;
  PVector end;
  
  PVector normalEnd;
  PVector normalBegin;
  
  Line () {
    start = new PVector();
    end = new PVector();
    normalEnd = new PVector();
    normalBegin = new PVector();
  }
  
  void update(float deltaTime) {
  }
  
  void display() {
    pushMatrix();
    stroke (strokeColor);
    strokeWeight (strokeWeight);
    
    line (start.x, start.y, end.x, end.y);
    
    //ellipse (normalEnd.x + normalBegin.x, normalEnd.y + normalBegin.y, 25, 25);
    popMatrix();
  }
  
  void setStart (float x, float y) {
    start.x = x;
    start.y = y;
    
    updateNormal();
  }
  
  void setEnd (float x, float y) {
    end.x = x;
    end.y = y;
    
    updateNormal();
  }
  
  void updateNormal() {
    // Normal est au-dessus si start est à gauche et end à droite
    normalEnd.x = (end.y - start.y);
    normalEnd.y = start.x - end.x;
    
    normalEnd.normalize();
    
    normalBegin.x = (start.x + end.x) / 2;
    normalBegin.y = (start.y + end.y) / 2;
  }
  
  PVector getNormalEnd() {
    return normalEnd;
  }
  
  PVector getNormalBegin() {
    return normalBegin;
  }
  
  
}
