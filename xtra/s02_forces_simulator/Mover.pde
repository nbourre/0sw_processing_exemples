class Mover extends GraphicObject<PApplet> {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;

  Mover(PApplet app, float x, float y, float mass) {
    super(app);
    this.position = new PVector(x, y);
    this.velocity = new PVector();
    this.acceleration = new PVector();
    this.mass = mass;
  }

  void applyForce(PVector force) {
    PVector f = force.copy();
    f.div(mass);
    acceleration.add(f);
  }

  @Override
  void update(int deltaTime) {
    float dt = deltaTime / 1000.0f;
    velocity.add(PVector.mult(acceleration, dt));
    position.add(PVector.mult(velocity, dt));

    // simple bounce on window edges
    if (position.x < 0) {
      position.x = 0;
      velocity.x *= -1;
    } else if (position.x > app.width) {
      position.x = app.width;
      velocity.x *= -1;
    }
    if (position.y < 0) {
      position.y = 0;
      velocity.y *= -1;
    } else if (position.y > app.height) {
      position.y = app.height;
      velocity.y *= -1;
    }

    acceleration.mult(0);
  }

  @Override
  void display() {
    app.fill(200, 0, 0);
    app.noStroke();
    app.ellipse(position.x, position.y, mass * 16, mass * 16);
  }
}
