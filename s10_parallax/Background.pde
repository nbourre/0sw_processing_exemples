class Background implements IActable {
  
  PImage img;
  float scale = 1.0;
  PVector position;
  PVector velocity;
    
  boolean isParallax = false;
 
  Background (String imgPath) {
    img = loadImage(imgPath);
    initValues();
  }
  
  Background (PImage img) {
    this.img = img;
    initValues();
  }
  
  private void initValues() {
    position = new PVector();
    velocity = new PVector();
  }
  
  
  void update(int deltaTime) {
    position.add(velocity);
    position.x = position.x % width;
  }
  
  float posX;
  float posY;
  
  void display () {
    
    image (img,
      position.x, position.y, 
      img.width, img.height);

    if (isParallax) {
      if (position.x < 0) {
        image (img, (position.x + img.width), position.y, img.width, img.height);
      } else if (position.x + img.width > width) {
        image (img, (position.x - img.width), position.y, img.width, img.height);
      }
    }
  }
}
