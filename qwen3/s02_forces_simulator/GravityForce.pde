class GravityForce extends Force {
  PVector gravity;
  boolean enabled;
  
  GravityForce() {
    super("Gravité");
    this.gravity = new PVector(0, 0.1);
    this.enabled = false;
  }
  
  @Override
  PVector calculate(PVector position, PVector velocity, float mass, int deltaTime) {
    if (enabled) {
      return gravity.get();
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
