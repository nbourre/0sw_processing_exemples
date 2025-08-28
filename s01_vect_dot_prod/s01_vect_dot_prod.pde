// --- Démo Produit Scalaire : Multi-ennemis + Poursuite (Processing) --- //<>//
// Contrôles:
//  - Déplacement joueur : WASD (QWERTY) ou flèches
//  - Debug ON/OFF       : P
//  - Poursuite ON/OFF   : O
//  - Ajouter ennemi     : +   (ou = sur certains claviers)
//  - Retirer ennemi     : -

Player player;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
boolean debug = false;
boolean pursueEnabled = false;

int enemyCount = 1;         // démarre à 1
final int ENEMY_MIN = 1;
final int ENEMY_MAX = 20;

void setup() {
  size(900, 600);
  player = new Player(new PVector(width*0.65, height*0.55));
  textFont(createFont("Consolas", 14));
  smooth(4);
  rebuildEnemies();
}

void draw() {
  background(24);

  // Update
  player.update();
  for (Enemy e : enemies) {
    e.update(player.pos);
  }

  // Dessin
  player.draw();
  for (Enemy e : enemies) {
    boolean detected = e.detects(player.pos);
    e.draw(detected);
    if (debug) drawEnemyDebug(e, player, detected);
  }

  // HUD
  drawHUD();
}

void keyPressed() {
  // Toggles
  if (key == 'p' || key == 'P') debug = !debug;
  if (key == 'o' || key == 'O') pursueEnabled = !pursueEnabled;

  // Multi-ennemis
  if (key == '+' || key == '=') {            // += sur certains claviers
    if (enemyCount < ENEMY_MAX) {
      enemyCount++;
      rebuildEnemies();
    }
  }
  if (key == '-') {
    if (enemyCount > ENEMY_MIN) {
      enemyCount--;
      rebuildEnemies();
    }
  }

  // Déplacement joueur (WASD + flèches)
  player.keyPressed(keyCode, key);
}
void keyReleased() {
  player.keyReleased(keyCode, key);
}

// ----------------- CLASSES -----------------

class Player {
  PVector pos;
  PVector vel = new PVector();
  float speed = 3.2;

  boolean up, down, left, right;

  Player(PVector start) {
    pos = start.copy();
  }

  void update() {
    vel.set(0, 0);
    if (up)    vel.y -= 1;
    if (down)  vel.y += 1;
    if (left)  vel.x -= 1;
    if (right) vel.x += 1;
    if (vel.magSq() > 0) vel.normalize().mult(speed);
    pos.add(vel);
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
    // WASD (QWERTY)
    if (keyChar == 'w' || keyChar == 'W') up = true;
    if (keyChar == 's' || keyChar == 'S') down = true;
    if (keyChar == 'a' || keyChar == 'A') left = true;
    if (keyChar == 'd' || keyChar == 'D') right = true;
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
  PVector forward = new PVector(1, 0); // direction normalisée
  float angle = 0;                     // orientation visuelle
  float spin;                          // vitesse de rotation (aléatoire légère)
  float range;                         // portée de détection
  float fov;                           // FOV total (radians)
  float halfFov, cosHalfFov;

  // poursuite
  float chaseSpeed;                    // vitesse pendant poursuite
  float idleSpeed = 0.0;               // pas de déplacement hors poursuite (patrouille = rotation uniquement)

  Enemy(PVector start) {
    pos = start.copy();
    // paramètres légèrement variés par ennemi
    range = random(160, 240);
    fov = radians(random(70, 110)); // cônes un peu différents
    halfFov = fov/2f;
    cosHalfFov = cos(halfFov);
    //spin = random(0.006, 0.015);
    spin = PI / 360.0f;
    chaseSpeed = random(1.6, 2.6);
    angle = random(TWO_PI);
    forward.set(cos(angle), sin(angle));
  }

  void update(PVector playerPos) {
    boolean chasing = pursueEnabled && detects(playerPos);

    // rotation de patrouille seulement si pas en poursuite
    if (!chasing) {
      angle += spin;
      forward.set(cos(angle), sin(angle));
    }

    if (chasing) {
      PVector to = PVector.sub(playerPos, pos);
      float d = to.mag();
      if (d > 1) {
        to.mult(1.0/d);
        pos.add(PVector.mult(to, chaseSpeed));

        float targetAngle = atan2(to.y, to.x);
        angle = lerpAngle(angle, targetAngle, 0.15); // ta version corrigée
        forward.set(cos(angle), sin(angle));
      }
    }

    pos.x = constrain(pos.x, 14, width-14);
    pos.y = constrain(pos.y, 14, height-14);
  }


  boolean detects(PVector target) {
    // 1) Distance
    PVector toPlayer = PVector.sub(target, pos);
    float dist = toPlayer.mag();
    if (dist > range || dist == 0) return false;

    // 2) Angle via produit scalaire
    toPlayer.div(dist);               // normaliser
    float dot = forward.dot(toPlayer);
    return dot >= cosHalfFov;
  }

  void draw(boolean detected) {
    // Portée
    noFill();
    stroke(255, 255, 255, 24);
    circle(pos.x, pos.y, range*2);

    // Cône de vision (en debug seulement)
    if (debug) {
      stroke(120, 180);
      PVector leftDir  = vecFromAngle(angle - halfFov);
      PVector rightDir = vecFromAngle(angle + halfFov);
      line(pos.x, pos.y, pos.x + leftDir.x*range, pos.y + leftDir.y*range);
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
      // "nez"
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

// ----------------- OUTILS / DEBUG -----------------

void rebuildEnemies() {
  enemies.clear();
  // Répartir les ennemis sur un anneau autour du centre
  PVector center = new PVector(width*0.35, height*0.5);
  float radius = min(width, height) * 0.25;
  for (int i = 0; i < enemyCount; i++) {
    float t = TWO_PI * (i / max(1.0, (float)enemyCount));
    PVector p = new PVector(center.x + cos(t)*radius + random(-40, 40),
      center.y + sin(t)*radius + random(-40, 40));
    enemies.add(new Enemy(p));
  }
}

void drawHUD() {
  fill(240);
  noStroke();
  text(
    "WASD/Flèches: bouger | P: debug | O: poursuite [" + (pursueEnabled ? "ON" : "OFF") + "]" +
    " | +/-: ennemis=" + enemyCount + " | FOV variable, Portée variable",
    16, 24
    );
}

void drawEnemyDebug(Enemy e, Player p, boolean detected) {
  // forward (ennemi)
  drawArrow(e.pos, e.forward, 80, color(80, 180, 255));
  // vers le joueur
  PVector toPlayer = PVector.sub(p.pos, e.pos);
  float dist = toPlayer.mag();
  PVector toPlayerDir = (dist > 0) ? toPlayer.copy().div(dist) : new PVector(0, 0);
  drawArrow(e.pos, toPlayerDir, min(dist, e.range), color(255, 200, 60));

  // valeurs numériques (en bas à droite)
  float dot = e.forward.dot(toPlayerDir);
  String info = String.format("dot=%.3f  cos(halfFov)=%.3f  dist=%.1f  %s",
    dot, e.cosHalfFov, dist, detected ? "DETECTÉ" : "—");
  fill(255);
  text(info, width-380, height-16);
}

PVector vecFromAngle(float a) {
  return new PVector(cos(a), sin(a));
}

void drawArrow(PVector from, PVector dirNorm, float len, int col) {
  PVector tip = PVector.add(from, PVector.mult(dirNorm, len));
  stroke(col);
  line(from.x, from.y, tip.x, tip.y);

  pushMatrix();
  translate(tip.x, tip.y);
  float ang = atan2(dirNorm.y, dirNorm.x);
  rotate(ang);
  fill(col);
  noStroke();
  float s = 8;
  triangle(0, 0, -s, s*0.6, -s, -s*0.6);
  popMatrix();
}

// interpolation angulaire douce
float lerpAngle(float a, float b, float t) {
  //float diff = (b - a + PI) % TWO_PI - PI;
  float diff = atan2(sin(b - a), cos(b - a));
  return a + diff * t;
}
