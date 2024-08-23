import java.util.Random;

class PVector {
  
  float x;
  float y;
  
  PVector (float x_, float y_) {
    this.x = x_;
    this.y = y_;
  }
  
  PVector (PVector v) {
    this.x = v.x;
    this.y = v.y;
  }
  
  void add (PVector v) {
    this.y += v.y;
    this.x += v.x;
  }
  
  void sub (PVector v) {
    this.y -= v.y;
    this.x -= v.x;
  }
  
  void mult (float n) {
    this.x *= n;
    this.y *= n;
  }
  
  void div (float n) {
    this.x /= n;
    this.y /= n;
  }
  
  float mag() {
    return (float)Math.sqrt(x*x + y*y);
  }
  
  void normalize() {
    float m = mag();
    
    if (m != 0) {
      div (m);
    }
  }
  
  // Limiter la magnitude d'un vecteur
  // Par exemple la vitesse
  void limit (float max) {
    if (this.mag() > max) {
      this.normalize();
      this.mult (max);
    }
  }
  
  void toZero() {
    this.x = 0;
    this.y = 0;
  }
  
  PVector get () {
    PVector copy = new PVector (this.x, this.y);
    
    return copy;
  }
  
  static PVector add (PVector v1, PVector v2) {
    PVector v3 = new PVector (v1.x + v2.x, v1.y + v2.y);
    return v3;
  }
  
  static PVector sub (PVector v1, PVector v2) {
    PVector v3 = new PVector (v1.x - v2.x, v1.y - v2.y);
    return v3;
  }
  
  static PVector mult (PVector v, float m) {
    return new PVector (v.x * m, v.y * m);
  }
  
  static PVector div (PVector v, float d) {
    if ( d != 0)
      return new PVector (v.x / d, v.y / d);
    else
      return null;
  }
  
  static PVector random2D () {
    Random rnd = new Random();
    
    PVector result = new PVector (rnd.nextInt(100), rnd.nextInt(100));
    
    result.normalize();
    return result;
    
  }
  
 
}

