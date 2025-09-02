class WindForce extends Force {
  PVector wind;
  boolean enabled;
  int windDir;
  
  WindForce() {
    super("Vent");
    this.wind = new PVector(0.005f, 0);
    this.enabled = false;
    this.windDir = 1;
  }
  
  @Override
  PVector calculate(PVector position, PVector velocity, float mass, int deltaTime) {
    if (enabled) {
      return new PVector(0.005f * windDir, 0);
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
  
  void changeDirection() {
    windDir = windDir * (int)(Math.random() < 0.5 ? -1 : 1);
  }
}
