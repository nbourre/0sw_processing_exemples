int currentTime;
int previousTime;
int deltaTime;

boolean saveVideo = false;

float scaleFactor = 25;
final float ONE_DEG = PI/180.0;

/* Incomplet */

AstroObject earth;
AstroObject moon;

// Maintenant ajouter le Soleil...

void setup () {
  size (800, 600);
  currentTime = millis();
  previousTime = millis();
  
  earth = new AstroObject(width/2, height/2);
  earth.fillColor = color(0, 0, 200);
  
  // https://nssdc.gsfc.nasa.gov/planetary/factsheet/planet_table_ratio.html
  moon = new AstroObject(earth.location.x + (earth.getDisplayDiametre() * 9.5), earth.location.y);
  moon.fillColor = color(127);
  moon.setDiametre(0.2724); 
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;

  
  update(deltaTime);
  display();
  
  savingFrames(5, deltaTime);  
}

/***
  The calculations should go here
*/

float moonAngle = 0.0;

void update(int delta) {
  earth.update(delta);
  moon.update(delta);
  moon.location.x = earth.location.x + (cos(moonAngle) * (earth.getDisplayDiametre() * 9.5)) ;
  moon.location.y = earth.location.y + (sin(moonAngle) * (earth.getDisplayDiametre() * 9.5)) ;
  
  moonAngle += ONE_DEG;
}

/***
  The rendering should go here
*/
void display () {
  background(0);
  earth.display();
  moon.display();
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
