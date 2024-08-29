// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class Attractor extends GraphicObject {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;

  Attractor(float x, float y, float m) {
    mass = m;
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update(int deltaTime) {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    fill(127, 127);
    ellipse(position.x, position.y, mass * 16, mass * 16);
  }

  PVector attractionForce(Attractor other) {
    // Calculate direction of force
    PVector force = PVector.sub(position, other.position);
    // Distance between objects
    float distance = force.mag();
    // Limiting the distance to eliminate "extreme" results for very close or very far objects
    distance = constrain(distance, 5, 25);

    // Calculate gravitational force magnitude
    float strength = (mass * other.mass) / (distance * distance);
    // Get force vector --> magnitude * direction
    force.setMag(strength);
    return force;
  }
}
