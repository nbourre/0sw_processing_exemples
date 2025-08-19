// --- Démo Produit Scalaire : Zone de détection (Processing) ---
// Commandes : WASD ou flèches pour bouger le joueur, D pour debug ON/OFF

Player player;
Enemy enemy;
boolean debug = false;

void setup() {
  size(900, 600);
  player = new Player(new PVector(width*0.7, height*0.6));
  enemy  = new Enemy(new PVector(width*0.3, height*0.5));
  textFont(createFont("Consolas", 14));
  smooth(4);
}

void draw() {
  background(24);

  // MàJ & rendu
  player.update();
  enemy.update();

  boolean detected = enemy.detects(player.pos);

  // Dessin
  player.draw();
  enemy.draw(detected);

  // UI minimale
  fill(240);
  noStroke();
  text("Déplacement: WASD / Flèches   |   Debug: P   |   FOV: " + nf(degrees(enemy.fov), 0, 0) + "°   Portée: " + (int)enemy.range, 16, 24);
  if (detected) {
    fill(60, 220, 120);
    text("⚠ Joueur détecté !", 16, 44);
  }

  if (debug) {
    drawDebug(player, enemy, detected);
  }
}

void keyPressed() {
  if (key == 'p' || key == 'P') debug = !debug;
  player.keyPressed(keyCode, key);     // pour WASD & flèches
}
void keyReleased() {
  player.keyReleased(keyCode, key);
}

// ----------------- CLASSES -----------------

class Player {
  PVector pos;
  PVector vel = new PVector();
  float speed = 3.2;

  // gestion entrées
  boolean up, down, left, right;

  Player(PVector start) { pos = start.copy(); }

  void update() {
    vel.set(0, 0);
    if (up)    vel.y -= 1;
    if (down)  vel.y += 1;
    if (left)  vel.x -= 1;
    if (right) vel.x += 1;
    if (vel.magSq() > 0) vel.normalize().mult(speed);
    pos.add(vel);
    // limites écran
    pos.x = constrain(pos.x, 12, width-12);
    pos.y = constrain(pos.y, 12, height-12);
  }

  void draw() {
    noStroke();
    fill(255);
    circle(pos.x, pos.y, 20);
  }

  void keyPressed(int keyCode, char keyChar) {
    // flèches
    if (keyCode == UP)    up    = true;
    if (keyCode == DOWN)  down  = true;
    if (keyCode == LEFT)  left  = true;
    if (keyCode == RIGHT) right = true;
    // WASD (prise en compte clavier FR)
    if (keyChar == 'w' || keyChar == 'W') up = true;
    if (keyChar == 's' || keyChar == 'S') down = true;
    if (keyChar == 'a' || keyChar == 'A') left = true;
    if (keyChar == 'd' || keyChar == 'D') right = true; // (D sert aussi au toggle debug)
  }
  void keyReleased(int keyCode, char keyChar) {
    if (keyCode == UP)    up    = false;
    if (keyCode == DOWN)  down  = false;
    if (keyCode == LEFT)  left  = false;
    if (keyCode == RIGHT) right = false;
    if (keyChar == 'w' || keyChar == 'W') up = false;
    if (keyChar == 's' || keyChar == 'S') down = false;
    if (keyChar == 'a' || keyChar == 'A') left = false;
    if (keyChar == 'd' || keyChar == 'D') right = false;
  }
}

class Enemy {
  PVector pos;
  PVector forward = new PVector(1, 0);   // direction normalisée
  float angle = 0;                       // orientation visuelle
  float spin = 0.01;                     // vitesse de rotation automatique
  float range = 200;                     // portée de détection (pixels)
  float fov = radians(90);               // angle total du FOV
  float halfFov = fov/2f;
  float cosHalfFov = cos(halfFov);

  Enemy(PVector start) { pos = start.copy(); }

  void update() {
    // Rotation douce (patrouille)
    angle += spin;
    forward.set(cos(angle), sin(angle)); // vecteur direction toujours normalisé
  }

  boolean detects(PVector target) {
    // 1) Distance
    PVector toPlayer = PVector.sub(target, pos);
    float dist = toPlayer.mag();
    if (dist > range || dist == 0) return false;

    // 2) Angle via produit scalaire : forward·normalize(toPlayer) = cos(theta)
    toPlayer.div(dist); // normalise sans refaire mag()
    float dot = forward.dot(toPlayer);

    return dot >= cosHalfFov; // dans le cône
  }

  void draw(boolean detected) {
    // Portée (en arrière-plan, léger)
    noFill();
    stroke(255, 255, 255, 24);
    circle(pos.x, pos.y, range*2);

    // Cône de vision (deux rayons)
    if (debug) {
      stroke(120, 180);
      PVector leftDir  = vecFromAngle(angle - halfFov);
      PVector rightDir = vecFromAngle(angle + halfFov);
      line(pos.x, pos.y, pos.x + leftDir.x*range,  pos.y + leftDir.y*range);
      line(pos.x, pos.y, pos.x + rightDir.x*range, pos.y + rightDir.y*range);
    }

    // Corps (carré violet)
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    rectMode(CENTER);
    noStroke();
    fill(160, 80, 255);
    square(0, 0, 28);
    // petit trait "nez" pour l'orientation
    stroke(240);
    line(0, 0, 18, 0);
    popMatrix();

    // halo si détecte
    if (detected) {
      noFill();
      stroke(60, 220, 120);
      strokeWeight(2);
      square(pos.x, pos.y, 36);
      strokeWeight(1);
    }
  }
}

// ----------------- DEBUG VISUEL -----------------

void drawDebug(Player p, Enemy e, boolean detected) {
  // Vecteur forward (ennemi)
  drawArrow(e.pos, e.forward, 80, color(80, 180, 255)); // bleu clair

  // Vecteur vers le joueur
  PVector toPlayer = PVector.sub(p.pos, e.pos);
  float dist = toPlayer.mag();
  PVector toPlayerDir = dist > 0 ? toPlayer.copy().div(dist) : new PVector(0, 0);
  drawArrow(e.pos, toPlayerDir, min(dist, e.range), color(255, 200, 60)); // jaune

  // Infos numériques
  float dot = e.forward.dot(toPlayerDir);
  fill(255);
  noStroke();
  String info = String.format("dot=%.3f   cos(halfFov)=%.3f   dist=%.1f   %s",
    dot, e.cosHalfFov, dist, detected ? "DETECTÉ" : "—");
  text(info, 16, height-16);
}

// Petite utilitaire pour vecteur depuis angle
PVector vecFromAngle(float a) {
  return new PVector(cos(a), sin(a));
}

// Dessin d’une flèche à partir d’un point et d’une direction normalisée
void drawArrow(PVector from, PVector dirNorm, float len, int col) {
  PVector tip = PVector.add(from, PVector.mult(dirNorm, len));
  stroke(col);
  line(from.x, from.y, tip.x, tip.y);

  // tête de flèche
  pushMatrix();
  translate(tip.x, tip.y);
  float ang = atan2(dirNorm.y, dirNorm.x);
  rotate(ang);
  fill(col);
  noStroke();
  float s = 8;
  triangle(0, 0, -s,  s*0.6, -s, -s*0.6);
  popMatrix();
}
