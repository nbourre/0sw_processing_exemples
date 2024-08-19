int currentTime;
int previousTime;
int deltaTime;

Arrow arrow;
String msgA;
String msgB;

void setup () {
  size (800, 600, P2D);
  currentTime = millis();
  previousTime = millis();
  
  arrow = new Arrow();
  arrow.location.x = width / 2;
  arrow.location.y = height / 2;
  arrow.angularVelocity = TWO_PI / 360.0;
  arrow.scale = 2.0;


}
void draw () {
  timeManagement();
  update(deltaTime);
  display();
}

void update(int delta) {
  // Mettre les calculs ici
  arrow.update(delta);

}

void display () {
  // Mettre le code d'affichage ici
  background(0);
  
  arrow.display();
  
  msgA = String.format("%.2f", arrow.angle) + " rad";
  msgB = String.format("%.0f", degrees(arrow.angle)) + " °";
  textAlign(RIGHT);
  text(msgA, width - 50, 20);
  text(msgB, width - 50, 40);
  

}

void timeManagement (){
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
}
