class Walker {
  int x;
  int y;
  int speed = 2;
  
  Walker () {
    x = width / 2;
    y = height / 2;
  }
  
  void display () {

    ellipse (x, y, 10, 10);
  }
  
  void step () {
    int choice = int (random(4));
    
    if (choice == 0) {
      x+= speed;
    } else if (choice == 1) {
      x-= speed;
    } else if (choice == 2) {
      y+= speed;
    } else {
      y-= speed;
    }
  }
}
