ArrayList<Stickman> stickmen;

void setup(){
  size(800, 600);
  
  stickmen = new ArrayList<Stickman>();
  
  int halfWidth = width / 2;
  int marginX = 25;
  
  for (int i = 0; i < 25; i++) {
    Stickman sLeft = new Stickman();
    sLeft.setLocation(random (marginX, halfWidth - marginX), random (marginX, height - 100));
    sLeft.scale = random (0.25, 1.25);
    
    stickmen.add(sLeft);
    
    Stickman sRight = new Stickman();
    sRight.setLocation(random (halfWidth + marginX, width - marginX), random (marginX, height - 100));
    sRight.scale = (randomGaussian() * 0.15 + 1);
    stickmen.add(sRight);
  }
  
}

void draw(){
  background(255);
  
  stroke(230);
  line (width/2, 0, width/2, height);
  
  for (Stickman s : stickmen) {
    s.update (0);
    
    s.display();
  }
}
