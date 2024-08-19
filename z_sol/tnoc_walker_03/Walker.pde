class Walker {
  int x;
  int y;
  
  // Départ du milieu de l'écran
  Walker () {
    x = width / 2;
    y = height / 2;
  }
  
  void setXY ( int _x, int _y)
  {
    x = _x;
    y = _y;
  }
  
  void display () {
    stroke (0);
    point (x, y);
  }
  
  void step () {
    float r = random(1);
    
    if ( r < 0.4) {
      x--;
    } else if (r < 0.6) {
      x++;
    } else if (r < 0.8) {
      y++;
    } else {
      y--;
    }
    
  }
}
