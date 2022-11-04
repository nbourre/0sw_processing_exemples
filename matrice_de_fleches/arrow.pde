class Arrow {
  int len;
  int w;
  int x;
  int y;
  float angle;
  
  Arrow () {
    len = 50;
    w = 20;
    angle = x = y = 0;
  }
  
  void display () {
    pushMatrix();
      translate(x, y);
      rotate(angle);
      line (0, 0, len, 0);
      line (len, 0, len - (w / 2), -w / 2);
      line (len, 0, len - (w / 2), w / 2);
    popMatrix();
  }
}
