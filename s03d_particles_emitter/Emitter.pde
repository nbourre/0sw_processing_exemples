class Emitter {
  PVector position;
  int particleRate;
  int lastParticleTime;
  int maxParticles;
  ArrayList<Particle> particles;
  boolean isDirty = false;

  Emitter(PVector l, int rate, int maxParticles) {
    position = l.copy();
    particleRate = rate;
    this.maxParticles = maxParticles;
    lastParticleTime = 0;
    particles = new ArrayList<Particle>();
  }
  
  void setXY(float x, float y) {
    position.set(x, y);
    isDirty = true;
  }

  void update(int deltaTime) {
    if (millis() - lastParticleTime > particleRate && particles.size() < maxParticles) {
      lastParticleTime = millis();
      particles.add(new Particle(new PVector()));
    }

    for (Particle p : particles) {
      if (isDirty) {
        p.setXY(position.x, position.y);
      }
      p.update(deltaTime);
    }
    
    isDirty = false;
  }

  void display() {
    
    for (Particle p : particles) {
      p.display();
    }
    
  }
}
