class ParticleSystem implements IGraphicObject{
  
  ArrayList<Particle> particles;
  
  int nbParticles = 100;
  
  boolean resetAfterDead = false; 
  
  ParticleSystem() {
    particles = new ArrayList<Particle>();
    
    for (int i = 0; i < nbParticles; i++) {
      particles.add (new Particle(new PVector (width / 2, height / 2 )));
    }
  }
  
  void applyForce (PVector force) {
    for (Particle p : particles) {
      if (!p.isDead()) {
        p.applyForce (force);
      }
    }
  }
  
  void update (int delta) {
    if (isAllDead()) {
      resetAll();
    }
    
    for (Particle p : particles) {
      if (p.isDead()) {
        
        if (resetAfterDead)
          p.reset();
      }
      
     p.update(delta);
    }
  }
  
  void display() {
    for (Particle p : particles) {
      p.display();
    }
  }
  
  void setInitialSpeed(PVector velocity) {
    for (Particle p : particles) {
      
    }    
  }
  
  void resetAll() {
    for (Particle p : particles) {
      p.reset();
    }
  }
  
  boolean isAllDead() {
    boolean result = true;
    
    for (Particle p : particles) {
      result = result && p.isDead();
      if (!result) {
        break;
      }
    }
    
    return result; //<>//
  }

}
