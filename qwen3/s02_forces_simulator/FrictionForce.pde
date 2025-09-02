class FrictionForce extends Force {
  boolean enabled;
  
  FrictionForce() {
    super("Frottement");
    this.enabled = false;
  }
  
  @Override
  PVector calculate(PVector position, PVector velocity, float mass, int deltaTime) {
    if (enabled && velocity.mag() > 0.01) {
      PVector friction = velocity.get();
      friction.mult(-1);
      friction.normalize();
      friction.mult(0.05f); // Coefficient de frottement
      return friction;
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
}
