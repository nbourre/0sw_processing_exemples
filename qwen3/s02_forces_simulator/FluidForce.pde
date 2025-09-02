class FluidForce extends Force {
  PVector location;
  PVector size;
  float density;
  boolean enabled;
  
  FluidForce() {
    super("Liquide");
    this.location = new PVector(100, 300);
    this.size = new PVector(400, 200);
    this.density = 2.0f;
    this.enabled = false;
  }
  
  @Override
  PVector calculate(PVector position, PVector velocity, float mass, int deltaTime) {
    if (enabled) {
      // Vérifier si le mover est dans le fluide
      if (position.x > location.x && 
          position.x < location.x + size.x &&
          position.y > location.y && 
          position.y < location.y + size.y) {
        
        // Calculer la force de résistance du fluide
        PVector drag = velocity.get();
        drag.mult(-1);
        drag.normalize();
        float speed = velocity.mag();
        float dragMagnitude = density * speed * speed;
        drag.mult(dragMagnitude);
        
        return drag;
      }
    }
    return new PVector(0, 0);
  }
  
  @Override
  boolean isEnabled() {
    return enabled;
  }
  
  @Override
  void setEnabled(boolean enabled) {
    this.enabled = enabled;
  }
  
  boolean contains(PVector pos) {
    return (pos.x > location.x && 
            pos.x < location.x + size.x &&
            pos.y > location.y && 
            pos.y < location.y + size.y);
  }
}
