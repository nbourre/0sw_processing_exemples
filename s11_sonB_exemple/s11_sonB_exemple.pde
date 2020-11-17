import processing.sound.*;

SoundFile shootSound, rechargeSound, moreBulletSound;

int backgroundColor[] = {255, 255, 255};

void setup() {
  size (640, 480);
  shootSound = new SoundFile(this, "shoot.mp3");
  rechargeSound = new SoundFile(this, "recharge.mp3");
  moreBulletSound = new SoundFile(this, "moreBullet.mp3");
}

void draw() {
  background(backgroundColor[0], 
    backgroundColor[1],
    backgroundColor[2] );
}

void keyPressed() {
  boolean validKey = true;

  switch (key) {
    case ' ':
      shootSound.play();
      println("Shooting");
      break;
    case 'z':
      rechargeSound.play();
      break;
    case 'x':
      moreBulletSound.play();
      break;
    default:
      validKey = false;
  }

  if (validKey) {
    backgroundColor[0] = (int)random(0, 255);
    backgroundColor[1] = (int)random(0, 255);
    backgroundColor[2] = (int)random(0, 255);
  }
}
