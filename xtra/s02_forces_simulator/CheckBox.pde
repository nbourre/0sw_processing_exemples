class CheckBox extends GraphicObject<PApplet> {
  float x, y, size;
  String label;
  boolean checked = true;
  boolean wasPressed = false;

  CheckBox(PApplet app, float x, float y, float size, String label) {
    super(app);
    this.x = x;
    this.y = y;
    this.size = size;
    this.label = label;
  }

  boolean over() {
    return app.mouseX >= x && app.mouseX <= x + size &&
           app.mouseY >= y && app.mouseY <= y + size;
  }

  @Override
  void update(int deltaTime) {
    if (app.mousePressed && !wasPressed && over()) {
      checked = !checked;
    }
    wasPressed = app.mousePressed;
  }

  @Override
  void display() {
    app.stroke(0);
    app.fill(checked ? 0 : 255);
    app.rect(x, y, size, size);
    if (checked) {
      app.stroke(255);
      app.line(x, y, x + size, y + size);
      app.line(x, y + size, x + size, y);
    }
    app.fill(0);
    app.textAlign(LEFT, CENTER);
    app.text(label, x + size + 4, y + size / 2);
  }
}
