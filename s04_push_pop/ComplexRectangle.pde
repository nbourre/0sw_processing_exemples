class ComplexRectangle extends Rectangle {
 
  ArrayList<ComplexRectangle> children;
  
  protected float angularSpeed = 0.0f;
  
  ComplexRectangle(float _x, float _y, float _w, float _h) {
    super(_x, _y, _w, _h);
    
    children = new ArrayList<ComplexRectangle>();
  }
  
  void addChild(ComplexRectangle child) {
    children.add(child);
  }
  
  void setAngularSpeed(float speed) {
    angularSpeed = speed;
  }
  
  void update(int delta) {
    super.update(delta);
    updateGeometry();
    setAngle(angle + angularSpeed);
    
    for (Rectangle r : children) {
      r.update(delta);
    }
  }
  
  void display() {
    pushMatrix();
    
    translate (left(), top());
    
    rotate (angle);
    translate (-pivot.x, -pivot.y);
    rect (0, 0, w, h);
    
    for (Rectangle r : children) {
      pushMatrix();
        r.display();
      popMatrix();
    }
    
    popMatrix();
  }
}
