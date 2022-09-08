Grid grid;
GeoEllipse ell;

Line murGauche;

float currentTime;
float previousTime;
float deltaTime;

void setup(){
  size(800, 600);
  currentTime = millis();
  previousTime = currentTime;
  
  grid = new Grid();
  ell = new GeoEllipse();
  
  ell.velocity.add(-2, 0);
  
  murGauche = new Line();
  murGauche.setStart(50, 0);
  murGauche.setEnd(50, height);
  
  ell.addLimits(murGauche);
  
}

void draw(){
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update (deltaTime);
  display();
}

void update(float deltaTime) {
  ell.update(deltaTime);
}

void display () {
  background(0);
  
  grid.display();
  ell.display();
  
  murGauche.display();
}