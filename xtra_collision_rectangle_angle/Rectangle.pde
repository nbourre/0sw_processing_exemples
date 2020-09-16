class Rectangle {
  float x, y, w, h;
  private float angle = 0;
  
  PVector centre;
  PVector pivot;
  private PVector tempVec; // Used to save memory
  
  Rectangle minimumBounds;
  
  // Coin supérieur gauche premier coin
  // Ordre horaire
  PVector [] corners;
  
  Rectangle(float _x, float _y, float _w, float _h) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    
    setPivot(w / 2.0, h / 2.0);
    getCentre();
    corners = new PVector[4];
    
    for (int i = 0; i < 4; i++) {
      corners[i] = new PVector();
    }
    
    
  }
  
  Boolean contains(Rectangle _r) {
    Boolean result = false;
    
    if (x <= _r.x && ((x + w) >= (_r.x + _r.w)) && y <= _r.y && ((y + h) >= (_r.y + _r.h))) {
      result = true;
    }
    
    return result;
  }
  
  float left () {return x;}
  float top () {return y;}
  float right () {return x + w;}
  float bottom () {return y + h;}
  
  PVector getCentre() {
    if (centre == null) {
      centre = new PVector ();
    }
    
    centre.x = x + (w / 2.0);
    centre.y = y + (h / 2.0);
    
    return centre;
  }
  
  void setWH (float w, float h) {
    this.w = w;
    this.h = h;
    
    update();

  }
  
  void update() {
    setPivot (w / 2.0, h / 2.0);
    getCentre();
    updateCorners();    
  }
  
  void setAngle (float angle) {
    this.angle = angle;
    
    update();
  }
  
  void incrementAngle (float angleIncrement) {
    this.angle += angleIncrement;
    update();
  }
  
  void setPivot(float x, float y) {
    if (pivot == null) {
      pivot = new PVector();
    }
    
    pivot.x = x;
    pivot.y = y;
  }
  
  PVector getPivot() {
    return pivot;
  }
  
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
  
  Boolean intersect(float _x, float _y, float _w, float _h) {
    Boolean result = false;
    
    if (!(this.left() > _x + _w) ||
        this.right() < _x ||
        this.top() > _y + _h ||
        this.bottom() < _y) {
      result = true;
    }
        
    return result;
  }
  
  // Fonction qui permet de vérifier si un cercle
  // intersecte avec un rectangle
  // Src : https://stackoverflow.com/questions/401847/circle-rectangle-collision-detection-intersection
  Boolean intersectCircle(float radius, PVector centre) {
    Boolean result = false;
    
    
    if (!intersect (centre.x - radius, centre.y - radius, radius * 2, radius * 2)) return false;
    
    int i = 0;
    int idx1, idx0;
   
    
    while (!result && i < 4) {
    
      if (i < 3) {
        idx0 = i;
        idx1 = i + 1;
      } else {
        idx0 = i;
        idx1 = 0;
      }
      PVector p0 = corners[idx0];
      
      PVector p1 = corners[idx1];
      
      tempVec = Geometry.closestPointToLine(p0, p1, centre);

      PVector unitaire = PVector.sub (p0, p1).normalize().mult(radius); 
    
      if (Geometry.pointInSegment(PVector.add(p0, unitaire), PVector.sub(p1, unitaire), tempVec)) {
        float dist = PVector.dist(tempVec, centre);
        result = dist < radius;
      }
      
      i++;
    }
    
    return result;
  }
   
  void display() {
    pushMatrix();
    
    translate (x, y);
    
    rotate (angle);
    translate (-pivot.x, -pivot.y);
    rect (0, 0, w, h);
    
    popMatrix();
  }

  // Recalcule les coins
  void updateCorners(){
 
    float rectDiag = sqrt((w/2)*(w/2) + (h/2)*(h/2));
    float rectAngle = atan2(h/2, w/2);
    
    float cNeg = cos(-rectAngle + angle);
    float sNeg = sin(-rectAngle + angle);
    float cPos = cos(rectAngle + angle);
    float sPos = sin(rectAngle + angle);
    
    // cx1 cy1
    corners[3].x = x + -rectDiag * cNeg;
    corners[3].y = y + -rectDiag * sNeg;
    
    // cx2 cy2
    corners[2].x = x + rectDiag * cPos;
    corners[2].y = y + rectDiag * sPos;
    
    // cx3 corners[0].y3
    corners[1].x = x + rectDiag * cNeg;
    corners[1].y = y + rectDiag * sNeg;
    
    // cx4 corners[0].y4
    corners[0].x = x + -rectDiag * cPos;
    corners[0].y = y + -rectDiag * sPos;
    
    if(minimumBounds == null ){
       minimumBounds = new Rectangle (0, 1, 3, 4);
    }
    
    float right = corners[0].x;
    float left = corners[0].x;
    float top = corners[0].y;
    float bottom = corners[0].y;
    
    for (int i = 1; i < 4; i++) {
       if (corners[i].x > right) {
         right = corners[i].x;
       }
       
       if (corners[i].x < left) {
         left = corners[i].x;
       }
       
       if (corners[i].y > bottom) {
         bottom = corners[i].y;
       }
       
       if (corners[i].y < top) {
         top = corners[i].y;
       }
    }
    
    minimumBounds.x = left;
    minimumBounds.y = top;
    minimumBounds.w = right - left;
    minimumBounds.h = bottom - top;
  }
  
  String toString() {
    return "x : " + x + "\ty : " + y + "\tw : " + w + "\th : " + h;
  }
}