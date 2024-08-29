class Emitter {
  PVector position;
  int particleRate;
  int lastParticleTime;
  int maxParticles;
  ArrayList<Particle> particles;
  boolean isDirty = false;
  PImage texture;

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
  
  void setTexture(PImage img) {
    texture = img;
    isDirty = true;
  }

  void update(int deltaTime) {
    if (millis() - lastParticleTime > particleRate && particles.size() < maxParticles) {
      lastParticleTime = millis();
      var p = new Particle(position.copy());
      
      if (texture != null) {
        p.setTexture(texture);
      }
      particles.add(p);
    }

    for (Particle p : particles) {
      if (isDirty) {
        p.setXY(position.x, position.y);
        
        if (texture != null) {
          p.setTexture(texture);
        }
      }
      p.update(deltaTime);
    }
    
    isDirty = false;
  }

  void display() {
    blendMode(ADD);
    
    for (Particle p : particles) {
      p.display();
    }
    
  }
  
  void applyForce(PVector f) {
    
    for (Particle p : particles) {
      p.applyForce(f);
    }
    
  }
}
