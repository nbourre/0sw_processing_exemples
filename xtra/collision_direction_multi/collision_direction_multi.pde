ArrayList<Rectangle> rectangles = new ArrayList<Rectangle>();

float bouncingRectX = 150;
float bouncingRectY = 150;
float bouncingRectWidth = 20;
float bouncingRectHeight = 20;
float bouncingRectSpeedX = 2;
float bouncingRectSpeedY = 1;

float squareSide = 30;


void setup() {
  size(300, 300);

  rectangles.add(new Rectangle(0, 0, width, 20));
  rectangles.add(new Rectangle(0, width-20, width, 20));
  rectangles.add(new Rectangle(0, 0, 20, height));
  rectangles.add(new Rectangle(width-20, 0, 20, height));
  
  rectangles.add(new Rectangle(width * .35 - squareSide, height * .35 - squareSide, squareSide, squareSide));
  rectangles.add(new Rectangle(width - width * .35 , height * .35- squareSide, squareSide, squareSide));
  rectangles.add(new Rectangle(width - width * .35 , height - height * .35, squareSide, squareSide));
  rectangles.add(new Rectangle(width * .35 - squareSide, height - height * .35, squareSide, squareSide));
}

void draw() {
  background(64);

  //iterate over the obstacles
  for (int i = 0; i < rectangles.size(); i++) {
    
    //check collision for this obstacle
    Rectangle rectangle = rectangles.get(i);

    boolean passLeft = bouncingRectX + bouncingRectWidth + bouncingRectSpeedX > rectangle.x;
    boolean passRight = bouncingRectX + bouncingRectSpeedX < rectangle.x + rectangle.rectWidth;
    boolean checkTop = bouncingRectY + bouncingRectHeight > rectangle.y;
    boolean checkBottom = bouncingRectY < rectangle.y + rectangle.rectHeight;
    
    //check X movment bounce
    if (passLeft && 
       passRight && 
       checkTop && 
       checkBottom) {

      bouncingRectSpeedX *= -1;
    }

    //check Y movement bounce
    if (bouncingRectX + bouncingRectWidth> rectangle.x && 
      bouncingRectX< rectangle.x + rectangle.rectWidth && 
      bouncingRectY + bouncingRectHeight + bouncingRectSpeedY > rectangle.y && 
      bouncingRectY + bouncingRectSpeedY < rectangle.y + rectangle.rectHeight) {

      bouncingRectSpeedY *= -1;
      println(checkBottom);
    }

    //draw the obstacle rectangle
    fill(255, 0, 0);
    rect(rectangle.x, rectangle.y, rectangle.rectWidth, rectangle.rectHeight);
  }

  bouncingRectX += bouncingRectSpeedX;
  bouncingRectY += bouncingRectSpeedY;

  //draw the bouncing rectangle
  fill(0, 255, 0);
  rect(bouncingRectX, bouncingRectY, bouncingRectWidth, bouncingRectHeight);
}

class Rectangle {
  float x;
  float y;
  float rectWidth;
  float rectHeight;

  public Rectangle(float x, float y, float rectWidth, float rectHeight) {
    this.x = x;
    this.y = y;
    this.rectWidth = rectWidth;
    this.rectHeight = rectHeight;
  }
}
