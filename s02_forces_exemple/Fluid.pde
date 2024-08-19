/**
  Classe simulant un fluide. Elle est représentée par un rectangle.
*/
class Fluid {
  Rectangle r;
  float density;
  float coefficientFriction;
  
  private color c;
  
  Fluid () {
    float quarterHeight = height / 4;
    r = new Rectangle(0, height - quarterHeight, width, quarterHeight);
    density = 0.8;
    coefficientFriction = 0.1;
    
    this.c = color (127, 127);
  }
  
  Fluid (Rectangle _r, float _density, float _coefficientFriction) {
    r = _r;
    density = _density;
    coefficientFriction = _coefficientFriction;
    
    this.c = color (127, 127);
  }
  
  void setRectangle (Rectangle _r) {
    r = _r;
  }
  
  Rectangle getRectangle () {
    return r;
  }
  
  void display () {
    
    fill (c);
    r.display();
  }
  
  /**
  Formule F = -0.5 * rho * ||v||^2 * area * friction * speed.normalise
  */
  PVector draggingForce(PVector speed, float area) {
    float speedMag = speed.mag();
    float coeffRhoMag = density * coefficientFriction * speedMag * speedMag * 0.5;
    
    PVector result = speed.get();
    result.mult(-1);
    result.normalize();
    result.mult(area);
    result.mult(coeffRhoMag);
   
    return result;
  }
  
  void setColor (color c) {
    this.c = c;
  }
  
  void setLocation (int x, int y) {
    this.r.x = x;
    this.r.y = y;
  }
}
