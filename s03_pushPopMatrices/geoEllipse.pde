class GeoEllipse extends GraphicObject {
  
  float xDiametre;
  float yDiametre;
  
  Quote quoteX;
  
  String strLoc = "";
  String strVel = "";
  
  ArrayList<Line> limits;
  
  GeoEllipse () {
    initDefault();
  }
  
  void initDefault() {
    location = new PVector(width / 2, height / 2);
    velocity = new PVector();
    acceleration = new PVector();
    
    
    quoteX = new Quote();

    setSize (50, 50);
  }
  
  void update(float deltaTime) {
    velocity.add(acceleration);
    location.add(velocity);
    
    acceleration.mult (0);
    
    checkLimits();

  }
  
  void display() {
    pushMatrix();
    translate (location.x, location.y);
    
    fill (fillColor);
    stroke (strokeColor);
    strokeWeight (strokeWeight);
    ellipse(0, 0, xDiametre, yDiametre);
    
    displayQuotes();
    
    popMatrix();
  }
  
  void displayQuotes() {
    quoteX.display();
    
    strLoc = "centre = (" + Float.toString(location.x) + ", " + Float.toString(location.y) + ")";
    strVel = "velocity = (" + Float.toString(velocity.x) + ", " + Float.toString(velocity.y) + ")";
    
    text (strLoc + "\r\n" + strVel, xDiametre / 2, yDiametre / 2);
    
  }
  
  void setSize (float w, float h) {
    xDiametre = w;
    yDiametre = h;
    
    quoteX.setOffset(0, -yDiametre * 2/ 3);
    quoteX.setStart(-xDiametre / 2, 0);
    quoteX.setEnd(xDiametre / 2, 0);
  }
  
  void addLimits(Line limit) {
    if (limits == null) {
      limits = new ArrayList<Line>();
    }
    
    limits.add (limit);
  }
  
  void checkLimits() {
    if (limits == null) {
      return;
    }
    
    for (Line l : limits) {
      float dX = ((l.getNormalEnd().x + l.getNormalBegin().x) - (location.x + velocity.x));
      float dY = ((l.getNormalEnd().y + l.getNormalBegin().y) - (location.y + velocity.y));
      float dX2 = (l.getNormalBegin().x - (location.x));
      float dY2 = (l.getNormalBegin().y - (location.y));
      
      float distA = dX * dX + dY * dY;
      float distB = dX2 * dX2 + dY2 * dY2;
      
      if (distA < distB) {
        
        if (location.x - xDiametre / 2 < l.start.x) {
          velocity.sub(PVector.mult(l.getNormalEnd(), 2 * PVector.dot(velocity,l.getNormalEnd())));
        }
      }
      
    }
  }
}