class ParticleSystem implements IGraphicObject{
  
  ArrayList<Particle> particles;
  
  int nbParticles = 100;
  
  ParticleSystem() {
    particles = new ArrayList<Particle>();
    
    for (int i = 0; i < nbParticles; i++) {
      particles.add (new Particle(new PVector (width / 2, 50 )));
    }
  }
  
  void update (int delta) {
    for (Particle p : particles) {
      if (p.isDead()) {
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

}
