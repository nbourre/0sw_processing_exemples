
Rectangle rectangle;
PVector circle;
float radius = 25;
float dia = 2 * radius;

boolean previousState = false;
ArrayList<PVector> points;

void setup() {
  size(800, 600);

  rectangle = new Rectangle (width / 2, height / 2, random (25, 100), random (25, 100));
  circle = new PVector();
}


color fillC;

void draw() {
  background (0);

  circle.x = mouseX;
  circle.y = mouseY;

  rectangle.incrementAngle(PI/180);

  stroke (0);
  fill (0, 0, 200);
  

  if (rectangle.intersectCircle(radius, circle)) {
    fillC = color (0, 200, 0, 127);


  } else {
    fillC = color (0, 200, 0, 255);

  }

  rectangle.display();

  fill (fillC);
  ellipse (circle.x, circle.y, dia, dia);
  
  noFill();
  stroke(75);
  rectangle.minimumBounds.display();
  

}

void keyPressed() {
  if (key == 'r') {
    rectangle.setWH(random (25, 100), random (25, 100));
  }
}

void testFonctions () {
  // Points à tester
  PVector a = new PVector(10, 2);
  PVector b = new PVector(11, 20);
  PVector c = new PVector (30, 15);
  

  float factor = 5;

  // Trouve les mx + b;
  float mx[] = Geometry.pointsToMxB(a, b);
  
  // trouve les ax+ by + c = 0; 
  float abc[] = Geometry.pointsToAxBxC(a, b);
  
  // Trouve le point le plus proche de c
  PVector nearestP = Geometry.closestPointToLine(abc[0],abc[1],abc[2],c);
  
  println ("Point sur droite : " + Geometry.pointInLine(a, b, nearestP));
  println ("Point sur segment : " + Geometry.pointInSegment(a, b, nearestP));

  background (0);
  stroke (50, 50, 50);
  
  // Grid
  for (int j = 0; j < height / factor; j+= 10) {
   line (0, j * factor, width, j * factor); 
  }
  for (int i = 0; i < width / factor; i+= 10) {
    line (i * factor, 0, i * factor, height);
  }
  
  stroke (255);
  // trace le segment
  line (a.x * factor, a.y * factor, b.x * factor, b.y * factor);
  ellipse (a.x * factor, a.y * factor, 5, 5);
  ellipse (b.x * factor, b.y * factor, 5, 5);
  
  // Trace le point à l'Extérieur
  ellipse (c.x * factor, c.y * factor, 5, 5);

  // Trace des points sur la droite
  for (float x = 0; x < 25; x+=1) {
    float y = (mx[0] * x + mx[1]);
    
    if (y > 0 && (y * factor) < height) {
      ellipse (x * factor, y * factor, 5, 5);
      text ("(" + x + ", " + y + ")", 5 + x * factor, y * factor);   
    }
  }
  
  // Trace le point le plus proche
  ellipse (nearestP.x * factor, nearestP.y * factor, 5, 5);
  

}