// Rename ShapeTemplate to whatever needed
class ShapeTemplate extends GraphicObject {
  
  
  ShapeTemplate () {
    instanciate();
  }
  
  ShapeTemplate (float x, float y) {
    instanciate();
    location.x = x;
    location.y = y;
    
  }
  
  
  
  void instanciate() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    
  }
  
  
  

  void update(float deltaTime) {
    velocity.add(acceleration);
    location.add (velocity);
    
    acceleration.mult(0);
  }
  
  void display() {
    pushMatrix();
      translate(location.x, location.y);

      // Code diplay stuff here

      fill(fillColor);


              
    popMatrix();

  }
  

}
