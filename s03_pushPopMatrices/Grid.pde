class Grid extends GraphicObject {
  float xSpacing;
  float ySpacing;
  color lineColor;
  
  int xAxis;
  int yAxis;
  boolean drawAxis;
  
  float scale = 1.0;
  
  boolean angleAnimation = false;
  float angle = 0.0;
  float angleTo = 0.0;
  float angleTimeToGoal = 0.0;

  boolean angleAnimationDone = false;
  float angleSpeed = 0.0;
  
  AnimatedValue x;
  AnimatedValue y;
  AnimatedValue animatedAngle;
 
  Grid () {
    initDefault();    
  }
  
  void initDefault() {
    xSpacing = 20;
    ySpacing = 20;
    
    xAxis = 1;
    yAxis = 1;
    
    lineColor = 50;
    
    drawAxis = true;
    
    location = new PVector();
    
    x = new AnimatedValue();
    y = new AnimatedValue();
    animatedAngle = new AnimatedValue();
  }
  
  void setAnimation (boolean enable) {
    angleAnimation = enable;
    x.animate = enable;
    y.animate = enable;
  }
  
  void setXY (float x, float y) {
    this.x.setValue(x);
    this.y.setValue(y);
    location.x = x;
    location.y = y;
  }
  
  void setXYTo (float x, float y) {
    this.x.setGoal(x);
    this.y.setGoal(y);
  }
  
  void setXYAnimationTime(float time) {
    x.setAnimationTime(time);
    y.setAnimationTime(time);
  }
  
  // Temps requis pour atteindre l'angle final
  void setAngleTimeToGoal(float time) {
    animatedAngle.setAnimationTime(time);
    
    angleTimeToGoal = time;
    
    float angleDelta = (angleTo - angle);
 //<>//
    if (angleTimeToGoal >= 0) {
      // Calculer la vitesse angulaire en seconde
      angleSpeed = angleDelta / angleTimeToGoal;

    }
  }
  
  void setLineColor(color c) {
    lineColor = c;
  }
  
  void setDrawAxis(boolean enable) {
    drawAxis = enable;
  }
  
  void updatePosition(float dt){
    location.x = x.update(dt);
    location.y = y.update(dt);
  }
  
  void updateAngle(float dt) {
    angle = animatedAngle.update(dt);
    
    //if (angleAnimation && !angleAnimationDone) {
    //  float dAngle = angle - angleTo;
      
    //  float temp = abs(round(dAngle * 100)/100.0);
      
    //  if (temp >= PI/180.0) {
    //    // Vitesse * la fraction de seconde
    //    angle += angleSpeed * (deltaTime / 1000.0);
        
    //    // Si on fait le tour, on enlève 2pi;
    //    if (angle >= TWO_PI) {
    //      angle -= TWO_PI;
    //    }
    //  } else {
    //    // Mettre angle à l'angle final
    //    angle = angleTo;
    //    angleAnimationDone = true;
    //  }
    //}
  }
  
  void update(float deltaTime) {
    updatePosition(deltaTime);
    updateAngle(deltaTime);
  }
  
  void display() {
    int iCount = 0;
    int jCount = 0;
    
    pushMatrix();
    translate(location.x, location.y);
    rotate(angle);
    scale(scale);
    
    for (int i = 0; i < width; i+= xSpacing) {
      stroke(lineColor);
      
      if (iCount == xAxis) {
        if (drawAxis) {
          strokeWeight(3);
          stroke(color (0, 127, 0));
        }
      } else {
        strokeWeight(1);
      }
      
      line (i, 0, i, height);
      iCount++;
    }
    
    for (int j = 0; j < height; j+= ySpacing) {
      stroke(lineColor);
      
      if (jCount == yAxis) {
        if (drawAxis) {
          strokeWeight(3);
          stroke(color (0, 127, 0));
        }
      } else {
        strokeWeight(1);
      }
      
      line (0, j, width, j);
      jCount++;
    }
    
    popMatrix();
  }
  
}
