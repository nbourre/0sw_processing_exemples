interface ICollidable {
  boolean hasCollision(ICollidable other);
  float top();  
  float bottom();
  float left();  
  float right();
}
