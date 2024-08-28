class Fluid {
  Rectangle r;
  float density;
  float coefficientFriction;
  
  Fluid () {
    float quarterHeight = height / 4;
    r = new Rectangle(0, height - quarterHeight, width, quarterHeight);
    density = 0.2;
    coefficientFriction = 0.5;
  }
  
  Fluid (Rectangle _r, float _density, float _coefficientFriction) {
    r = _r;
    density = _density;
    coefficientFriction = _coefficientFriction;
  }
  
  void setRectangle (Rectangle _r) {
    r = _r;
  }
  
  void display () {
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
    result.mult(area);
    result.mult(coeffRhoMag);
   
    return result; 
  }
}
