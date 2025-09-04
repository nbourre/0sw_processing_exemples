class Circle extends GraphicObject {
  
  private float radius;
  private float diametre;
  
  private float mass = 1;
  
  boolean pause = false;
  
  
  Circle () {
    instanciate();
  }
  
  Circle (float x, float y, float radius) {
    instanciate();
    location.x = x;
    location.y = y;
    
    setRadius(radius);
  }
  
  
  
  void instanciate() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    
    setRadius(10);
  }
  
  void setRadius(float radius) {
    this.radius = radius;
    diametre = 2 * radius;
    mass = radius;
  }
  
  float getRadius() {
    return radius;
  }
  

  void update(float deltaTime) {
    if (pause) return;
    
    velocity.add(acceleration);
    location.add (velocity);
    
    acceleration.mult(0);
  }
  
  void display() {
    pushMatrix();
      translate(location.x, location.y);
      
      fill(fillColor);
      
      ellipse(0, 0, diametre, diametre);
      
      displayDebug();
    popMatrix();
    
  }
  
  // Collision simple
  // Si la somme des deux rayons est supérieure à la distance
  // des centres, il y a alors une collision
  boolean isCollidingCircle(Circle other) {
    boolean result = false;
    
    float distance = PVector.dist(this.location, other.location);
    
    if ((this.getRadius() + other.getRadius()) >= distance) {
      result = true;
    }
    
    
    return result;
  }
  
  PVector getCollisionPoint(Circle other) {
    
    if (!isCollidingCircle(other)) return null;
     
    // Version longue - pas utilisée
    //PVector vDistance = PVector.sub (other.location, this.location);      
    //float magnitude = vDistance.mag();    
    //float sumRadius = this.radius + other.radius;
    
    //// si la magnitude est plus petite que la somme des rayons, alors les cercles
    //// s'intersecte. On recule le cercle pour empecher de rester poigner dans l'autre
    //float deltaPct = (sumRadius - magnitude) / sumRadius;
    //this.location.x = this.location.x - this.velocity.x * deltaPct;
    //this.location.y = this.location.y - this.velocity.y * deltaPct;
    
    float sumRadius = this.radius + other.radius;
    // Trouver le point de collision
    float collisionPointX =
        ((this.location.x * other.radius) + (other.location.x * this.radius))
        / sumRadius;

    float collisionPointY =
        ((this.location.y * other.radius) + (other.location.y * this.radius))
        / sumRadius;

    return new PVector (collisionPointX, collisionPointY);
  }
  
  PVector getImpactVelocity(PVector collisionPoint, Circle other) {
    PVector result = null;

        // Vecteur unitaire entre le point de contact et le centre du cercle
    PVector un = collisionPoint.copy();
    un.sub (this.location);
    un.normalize();
    
    // 90° du vecteur unitaire
    PVector ut = new PVector (-un.y, un.x);
    
    // Produits croisés
    float v1n = PVector.dot(un, this.velocity);
    float v1t = PVector.dot(ut, this.velocity);
    float v2n = PVector.dot(un, other.velocity);
    //float v2t = PVector.dot(ut, other.velocity);

    // Formule
    // (b1.vitesse.x * (b1.mass - b2.mass) + (2 * b2.mass * b2.vitesse.x))
    // / (b1.mass + b2.mass)        
    v1n = (v1n * (this.mass - other.mass) + 2 * other.mass * v2n) / (this.mass + other.mass);
    
    un.mult (v1n);
    ut.mult (v1t);
    
    un.add (ut);
    
    result = un.copy();      
    
    
    return result;
  }
  
  // NOT WORKING!!
  // SRC : https://gamedevelopment.tutsplus.com/tutorials/when-worlds-collide-simulating-circle-circle-collisions--gamedev-769
  PVector getImpactVelocity(Circle other) {
    PVector result = new PVector();
    
    result.x = (this.velocity.x * (this.mass - other.mass) + (2 * other.mass * other.velocity.x)) / (this.mass + other.mass);
    result.y = (this.velocity.y * (this.mass - other.mass) + (2 * other.mass * other.velocity.y)) / (this.mass + other.mass);
    
    return result;
  }
  
  void displayDebug() {
    if (!debug) return;
    
    fill(0);
    text ("r = " + radius, 0, 0);
  }
  
  
}
