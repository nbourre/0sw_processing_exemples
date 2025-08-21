// Rename Asteroid to whatever needed
class Asteroid extends GraphicObject {
  float radius = 20;
  ArrayList<PVector> vertices;
  int nbVertices = 100;
  
  Asteroid () {
    instanciate();
  }
  
  Asteroid (float x, float y) {
    instanciate();
    location.x = x;
    location.y = y;
    initVertices();

  }
  
  void initVertices(){
    vertices = new ArrayList<PVector>();
    for (int i = 0; i < nbVertices; i++) {
      PVector point = new PVector();
      
      float r = map(noise(t), 0, 1, 30, 50);
      point.x = r * cos(i * incAngle * PI / 180);
      point.y = r * sin(i * incAngle  * PI / 180);
      
      t+= 0.08;
      
      
      vertices.add(point);
    }
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
    stroke(127);
    pushMatrix();
      translate(location.x, location.y);

      // Code diplay stuff here

      fill(fillColor);
      
      beginShape();
        for (PVector p : vertices) {
          
          vertex(p.x, p.y);
          
        }
      endShape(CLOSE);
      
              
    popMatrix();
   

  }
  

}
