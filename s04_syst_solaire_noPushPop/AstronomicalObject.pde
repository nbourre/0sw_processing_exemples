// Rename AstroObject to whatever needed
class AstroObject extends GraphicObject {
  
  float mass = 1;
  float diametre = 1; // 1 = Terre
  float radius;
    
  AstroObject () {
    instanciate();
  }
  
  AstroObject (float x, float y) {
    instanciate();
    location.x = x;
    location.y = y;
  }
  
  
  void instanciate() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    
    setDiametre(1);
  }
  
  void setDiametre(float dia) {
    diametre = dia;
    radius = dia / 2;
  }
  
  float getDiametre() {
    return diametre;
  }
  
  float getDisplayDiametre() {
    return diametre * scaleFactor;
  }

  void update(float deltaTime) {
    
  }
  
  void display() {


    fill(fillColor);
    ellipse (location.x, location.y, getDisplayDiametre(), getDisplayDiametre());

              

  }
  

}
