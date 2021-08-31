int currentTime;
int previousTime;
int deltaTime;

ArrayList<Background> bgLayers;

void setup () {
  currentTime = millis();
  previousTime = currentTime;
  
  fullScreen(P2D);
  loadBackgroundLayers();
}

private void loadBackgroundLayers() {
  bgLayers = new ArrayList<Background>();
  bgLayers.add( new Background("layer_08.png"));
  bgLayers.add( new Background("layer_07.png"));
  bgLayers.add( new Background("layer_06.png"));
  bgLayers.add( new Background("layer_05.png"));
  bgLayers.add( new Background("layer_04.png"));
  bgLayers.add( new Background("layer_03.png"));
  bgLayers.add( new Background("layer_02.png"));
  bgLayers.add( new Background("layer_01.png"));
  
  float speedIncrement = 0.25;
  float currentSpeed = 1;
  
  
  for (int i = 0; i < bgLayers.size(); i++) {
    Background current = bgLayers.get(i);
    
    if (i > 1) {      
      current.isParallax = true;
      current.velocity.x = currentSpeed;
      currentSpeed += speedIncrement;
    } 
    
    current.scale = 0.5;
  }
}

void draw () {
  currentTime = millis();
  deltaTime = currentTime - previousTime;
  previousTime = currentTime;
  
  update(deltaTime);
  display();
}

/***
  The calculations should go here
*/
void update(int delta) {
  if (keyPressed) {
    switch (key) {
      case 'd':
        bgLayers.get(2).velocity.x = -2;
        break;
      case 'a':
        bgLayers.get(2).velocity.x = 2;
        break;
    }
  } else {
   bgLayers.get(2).velocity.x = 0; 
  }
  
  
  for (Background bg : bgLayers) {
    bg.update(delta);
  }
}

/***
  The rendering should go here
*/
void display () {
  for (Background bg : bgLayers) {
    bg.display();
  }  
}
