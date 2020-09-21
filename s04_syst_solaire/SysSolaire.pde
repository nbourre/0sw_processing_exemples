class SysSolaire extends GraphicObject{
  Astre soleil;
  Astre terre;
  Astre lune;
  Astre mars;
  
  SysSolaire() {
    initValues();
    
    soleil = new Astre();
    soleil.location.x = width/2;
    soleil.location.y = height/2;
    soleil.size = 40;
    soleil.fillColor = color (200, 200, 0);
    
    // Terre
    terre = new Astre(100, soleil.size / 2, 0.01);
    terre.fillColor = color (0, 0, 200);
    
    // Lune
    lune = new Astre(terre.size, terre.size / 2, terre.angularVelocity * 0.5);
    lune.fillColor = 200;
    
    terre.addMoon(lune);
    
    // Mars
    mars = new Astre(2*terre.location.x, terre.size / 1.7, terre.angularVelocity * 0.7);
    mars.fillColor = color(200, 0, 0); 
    
    soleil.addMoon(terre);
    soleil.addMoon(mars);
    
  }
  
  void initValues() {
    location = new PVector();
    velocity = new PVector();
    acceleration = new PVector(); 
  }  
  
  void update(float delta) {
    soleil.update(delta);
  }
  
  void display() {
    soleil.display();
  }
}
