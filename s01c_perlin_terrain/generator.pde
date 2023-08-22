class Generator {
  
  float tX = 0;
  float tY = 100;
  float k1, k2, k3;
  float kSum;
  float exp;
  
  public Generator() {
    k1 = 1;
    k2 = 0.5;
    k3 = 0.25;
    
    kSum = k1 + k2 + k3;
    
    exp = 1.0f; // > 1.0 = Vallée profonde, < 1.0 <-- vallée peu profonde
    noiseSeed(millis());
  }
  
  /// Source : https://www.redblobgames.com/maps/terrain-from-noise/
  public Map Generate(int w, int h) {
    Map result = new Map(w, h);
    
    float increment = 0.03;
    
    for (int j = 0; j < h; j++) {
      for (int i = 0; i < w; i++) {
        
        //var n = noise (tX, tY);
        var n = k1 * noise (tX, tY) + k2 * noise (2 * tX, 2 * tY) + k3 * noise (4 * tX, 4 * tY); 
        
        var elevation = n / kSum;
        elevation = (float)Math.pow(elevation, exp);
        
        result.setCell(i, j, elevation);
        tX += increment;
      }
      tY += increment;
      tX = 0;
    }
    
    result.display();
    result.SaveImg();
    
    
    return result;
  }

}
