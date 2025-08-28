class Paddle extends Rectangle implements ICollidable {


    void inputManagement() {

        if (keyPressed) {
            if (key == 'a' || key == 'A') {
                
            }
        }
    }


  void update(int deltaTime) {
    inputManagement();
    
    super.update(deltaTime);
  }


  boolean hasCollision(ICollidable other) {
    if (other == null) return false;
    
    return other.getBottom() > getTop() && other.getTop() < getBottom()
        && other.getLeft() < getRight() && other.getRight() > getLeft();
  }


  float getTop() {
    return top();
  }

  float getBottom() {
    return bottom();
  }

  float getLeft() {
    return left();
  }

  float getRight() {
    return right();
  }

}
