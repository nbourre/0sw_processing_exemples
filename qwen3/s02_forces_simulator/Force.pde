abstract class Force {
  String name;
  
  Force(String name) {
    this.name = name;
  }
  
  abstract PVector calculate(PVector position, PVector velocity, float mass, int deltaTime);
  abstract boolean isEnabled();
  abstract void setEnabled(boolean enabled);
}
