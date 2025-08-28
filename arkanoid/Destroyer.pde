class Destroyer extends Ball implements ICollidable { 
  float vitesse = 5.0;
  ArrayList<ICollidable> collidables;
  
  Destroyer (int _x, int _y) {
    super(_x, _y);
    initValues();
  }
  
  void initValues() {
    collidables = new ArrayList<ICollidable>();
    velocity = new PVector();
    velocity.x = round(random(0, 1)) == 1? 1 : -1;
    velocity.y = -1;
    velocity.normalize();
    velocity.mult(vitesse);
  }
  
  void update(int delta) {
    checkEdges();
    
    for (ICollidable other : collidables) {
      if (hasCollision(other)) {
        
      }
    }
    
    location.add(velocity);
    
    super.update(delta);
  }
  
  void checkEdges() {
    if (right() > width || left() < 0) {
      velocity.x *= -1;
    }
    
    if (top() < 0 || bottom() > height) {
      velocity.y *= -1;
    }
  }
  
  boolean hasCollision(ICollidable other) {
    if (other == null) return false;
    
    return other.getBottom() > getTop() && other.getTop() < getBottom()
        && other.getLeft() < getRight() && other.getRight() > getLeft();
  }
  
  void setCollision(boolean xColl, boolean yColl) {
    if (xColl) {
      velocity.x *= -1;
    }
    
    if (yColl) {
      velocity.y *= -1;
    }
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
