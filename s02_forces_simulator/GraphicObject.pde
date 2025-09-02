abstract class GraphicObject<T extends PApplet> {
  protected T app;
  GraphicObject(T app) {
    this.app = app;
  }
  abstract void update(int deltaTime);
  abstract void display();
}
