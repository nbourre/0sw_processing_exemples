// Rename Rectangle to whatever needed
class Rectangle extends GraphicObject implements IObserver, ISubject {
  
  int w, h;
  
  Rectangle () {
    instanciate();
  }
  
  Rectangle (float x, float y) {
    instanciate();
    location.x = x;
    location.y = y;
  }
  
  void instanciate() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    
    w = 100;
    h = 50;
  }
  
  void checkEdges() {
    if (location.x < 0 || location.x + w > width) {
      velocity.x *= -1;
      NotifyObservers("blue");
    }
  }
  
  void setXY(float x, float y) {
    location.x = x;
    location.y = y;
  }
  
  void update(float deltaTime) {
    checkEdges();
    
    velocity.add(acceleration);
    location.add (velocity);
    
    acceleration.mult(0);
  }
  
  void update(String event) {
    if (event == "blue") {
      fillColor = color (random(0, 255), random(0, 255), random(0, 255));
    }
  }
  
  ArrayList<IObserver> observers;
  
  int addObserver(IObserver obs) {
    if (observers == null) {
      observers = new ArrayList<IObserver>();
    }
    
    observers.add(obs);
    
    return observers.size();
  }
  
  int removeObserver(IObserver obs) {
    observers.remove(obs);
    
    return observers.size();
  }
  
  void NotifyObservers(String event){
    observers.forEach(obs -> obs.update(event)); 
  }    
  
  void display() {
    pushMatrix();
      translate(location.x, location.y);

      // Code diplay stuff here

      fill(fillColor);
      
      rect (0, 0, w, h);

              
    popMatrix();

  }
  

}
