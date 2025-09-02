Mover mover;
CheckBox cbGravity, cbWind, cbFriction, cbCenter;
int previousTime;

void setup() {
  size(800, 600);
  mover = new Mover(this, width/2, height/2, 2);
  cbGravity = new CheckBox(this, 20, 20, 20, "Gravité");
  cbWind = new CheckBox(this, 20, 50, 20, "Vent");
  cbFriction = new CheckBox(this, 20, 80, 20, "Friction");
  cbCenter = new CheckBox(this, 20, 110, 20, "Centripète");
  previousTime = millis();
  textSize(12);
}

void draw() {
  int currentTime = millis();
  int deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  background(255);

  // update UI
  cbGravity.update(deltaTime);
  cbWind.update(deltaTime);
  cbFriction.update(deltaTime);
  cbCenter.update(deltaTime);

  // apply forces
  if (cbGravity.checked) {
    PVector gravity = new PVector(0, 9.81f * mover.mass);
    mover.applyForce(gravity);
  }
  if (cbWind.checked) {
    PVector wind = new PVector(5f, 0);
    mover.applyForce(wind);
  }
  if (cbFriction.checked) {
    PVector friction = mover.velocity.copy();
    if (friction.mag() > 0) {
      friction.normalize();
      friction.mult(-0.5f);
      mover.applyForce(friction);
    }
  }
  if (cbCenter.checked) {
    PVector center = PVector.sub(new PVector(width/2, height/2), mover.position);
    center.mult(0.5f);
    mover.applyForce(center);
  }

  // update and display mover
  mover.update(deltaTime);
  mover.display();

  // display UI
  cbGravity.display();
  cbWind.display();
  cbFriction.display();
  cbCenter.display();
}
