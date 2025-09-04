int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = false;

ArrayList<Circle> circles;
boolean collisionChecks[][];

int nbCircles = 2;

private DebugLine debugLine;

boolean debug = true;

void setup () {
  size (640, 480);
  currentTime = millis();
  previousTime = millis();
  
  initValues();
  
}

void initValues () {
  collisionChecks = new boolean[nbCircles][nbCircles];
  
  resetCollisionChecks();
  
  circles = new ArrayList<Circle>();
  
  Circle temp;
  temp = new Circle(width / 2, height / 2, 50);
  temp.fillColor = color (200, 200, 0);
  
  circles.add(temp);
  
  temp = new Circle();
  temp.setRadius(30);
  temp.location.set (0, height / 3 + temp.getRadius());
  
  temp.acceleration.set(5, 0.1);
  
  circles.add(temp);


}

void resetCollisionChecks() {
  for (int j = 0; j < nbCircles; j++) {
    for (int i = 0; i < nbCircles; i++) {
      if (j == i) {
        collisionChecks[j][i] = true;
      } else {
        collisionChecks[j][i] = false;
      }
    }
  }
}


void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  
  update(deltaTime);
  display();
  
  savingFrames(10000, deltaTime);  
}


PVector collisionPoint;
PVector impactVelocityA;
PVector impactVelocityB;

/***
  The calculations should go here
*/
void update(int delta) {
  
  
  for (int i = 0; i < circles.size() - 1; i++) {
    Circle a = circles.get(i);
    Circle b = circles.get(i + 1);
    
    b.update(delta);
    a.update(delta);
    

    if (!collisionChecks[i][i+1]) {
      if (b.isCollidingCircle(a)) {
        println("Colliding!");
        b.fillColor = color (200, 0, 0, 127);
        
        collisionPoint = b.getCollisionPoint(a);
        
        // Méthode avec projection de vecteur        
        impactVelocityB = b.getImpactVelocity(collisionPoint, a);
        impactVelocityA = a.getImpactVelocity(collisionPoint, b);
         //<>//
        
        b.velocity.set(impactVelocityB.x, impactVelocityB.y);
        a.velocity.set(impactVelocityA.x, impactVelocityA.y);
        
      } else {
        b.fillColor = color (0, 200, 0);
      }
      
      collisionChecks[i][i+1] = true;
      collisionChecks[i + 1][i] = true;  
    }
   
  }
  
  resetCollisionChecks();
  
  
}

/***
  The rendering should go here
*/
void display () {
  background(255);
  
  for (Circle c : circles) {
    c.display();
  }
  
  if (collisionPoint!= null) {
    fill (0);
    ellipse (collisionPoint.x, collisionPoint.y, 10, 10); 
  }

}

//Saving frames for video
//Put saveVideo to true;
int savingAcc = 0;
int nbFrames = 0;

void savingFrames(int forMS, int deltaTime) {
  
  if (!saveVideo) return;
  
  savingAcc += deltaTime;
  
  if (savingAcc < forMS) {
    saveFrame("frames/####.tiff");
	nbFrames++;
  } else {
	println("Saving frames done! " + nbFrames + " saved");
    saveVideo = false;
  }
}


void keyPressed() {
  switch (key) {
    case 'r':
      initValues();
      break;
  }
}
