class Message {

  String text = "";
  PVector location;
  PFont font;
  int fontSize = 16;
  color fontColor = color (0);
  
  Message (String text) {
    this.text = text;
    
    baseInit();
  }
  
  void baseInit () {
    location = new PVector();
    font = createFont ("Arial", fontSize, true);
    textFont (font);
  }
  
  void display () {
    fill( fontColor);
    text(text, location.x, location.y);
  }
  
  void setLocation (float x, float y) {
    location.set (x, y);
  }
  
  PVector getLocation () {return location;}
  
  void setText (String text) {
    this.text = text;
  }
  
  String getText() {return text;}
  
  float getWidth() {return textWidth(text); }
}
