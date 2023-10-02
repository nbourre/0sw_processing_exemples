class Canon extends GraphicObject {

  float shootingAngle = QUARTER_PI;
  float angleIncrement = PI/60;
  float angleMax = 1.41; // sqrt 2

  float w = 32;
  float h = 16;
  
  PVector shootingVector = new PVector();
  PVector canonTip = new PVector();
  
  Canon() {
    super();

    location.x = width / 2;
    location.y = height - h;
  }
  
  PVector getCanonTip() {
    move(0);
    return canonTip;
  }
  
  PVector getShootingVector() {
    return shootingVector;
  }
  
  void move (float direction) {
    if (direction > 0) {
      shootingAngle += shootingAngle < angleMax  ? angleIncrement * direction : 0;
    } else {
      shootingAngle += shootingAngle > -angleMax ? angleIncrement * direction : 0;
    }
    
    // X et Y sont inverses
    shootingVector.y = -cos(shootingAngle);
    shootingVector.x = sin(shootingAngle);
    shootingVector.normalize();
    
    // Calcul du bout du canon
    canonTip.x = location.x + shootingVector.x * w;
    canonTip.y = location.y + shootingVector.y * w - 3;
    
  }

  void display() {
    pushMatrix();
      translate (location.x - w / 2, location.y);
  
      // Placer le canon
      pushMatrix();
        translate (w / 2 , -h / 2 + 6);
    
        
        rotate (shootingAngle);
        
        translate (-3, -2 * h);
        rect (0, 0, 6, w);
        
      popMatrix();
  
      ellipse (w / 2, 0, w, w);
      rect (0, 0, w, h);

    popMatrix();
   
  }
}
