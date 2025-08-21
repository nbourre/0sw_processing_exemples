// --- Simulation de tirs avec dispersion normale contrôlée par la "fatigue"
// Contrôles:
//   + / = : augmenter la fatigue (dispersion)
//   - / _ : diminuer la fatigue
//   Espace : tir en rafale (maintenir)
//   Clic : tir unique
//   r : réinitialiser les impacts

// ---------------- Paramètres ----------------
int shotsPerSecond = 10;      // cadence de tir (en maintenant Espace)
float dotSize = 6;            // taille des impacts
int maxShots = 2000;          // limite mémoire d'impacts

// Modèle de dispersion : sigma = base + k * fatigue
float fatigue = 20;           // 0 à 100 (par défaut)
float fatigueMin = 0;
float fatigueMax = 100;
float sigmaBase = 3.0;        // écart-type minimal (pixels)
float sigmaPerFatigue = 0.6;  // contribution par point de fatigue (pixels/pt)

// Cible
float aimX, aimY;             // centre visé (bullseye)
float[] rings = {120, 90, 60, 30}; // rayons des anneaux (pixels)

// Tir automatique
boolean holdingFire = false;
int fireIntervalMs;
int lastShotMs = 0;

// Impacts
ArrayList<PVector> hits = new ArrayList<PVector>();

void setup() {
  size(900, 500);
  aimX = width * 0.7;
  aimY = height * 0.5;
  fireIntervalMs = int(1000.0 / shotsPerSecond);
  surface.setTitle("Dispersion normale des tirs — fatigue contrôlée (+/-)");
}

void draw() {
  background(255);

  // Zone d’explication à gauche
  drawSidebar();

  // Cible à droite
  drawTarget();

  // Cercle ~95% (≈ 2σ) : aide visuelle
  float sigma = currentSigma();
  noFill();
  stroke(0, 140);
  strokeWeight(1.5);
  ellipse(aimX, aimY, 4 * sigma, 4 * sigma); // diamètre = 2 * (2σ)

  // Impacts
  noStroke();
  fill(20, 120, 255, 150);
  for (PVector h : hits) {
    ellipse(h.x, h.y, dotSize, dotSize);
  }

  // Tir automatique si Espace maintenu
  if (holdingFire) {
    int now = millis();
    if (now - lastShotMs >= fireIntervalMs) {
      shootOne();
      lastShotMs = now;
    }
  }
}

void drawTarget() {
  // Fond cible
  noStroke();
  fill(250);
  rect(width*0.45, 0, width, height);

  // Cercles concentriques
  stroke(200);
  strokeWeight(1);
  for (float r : rings) {
    noFill();
    ellipse(aimX, aimY, 2*r, 2*r);
  }

  // Bullseye
  fill(255, 50, 50);
  noStroke();
  ellipse(aimX, aimY, 14, 14);
}

void drawSidebar() {
  // Panneau gauche
  noStroke();
  fill(245);
  rect(0, 0, width*0.45, height);

  // Titre
  fill(0);
  textAlign(LEFT, TOP);
  textSize(20);
  text("Précision des tirs — loi normale", 20, 18);

  // Infos
  textSize(14);
  float sigma = currentSigma();
  int n = hits.size();

  String info =
    "Idée : les erreurs de visée (X, Y) suivent\n" +
    "une distribution normale autour du centre.\n" +
    "\n" +
    "Fatigue ↑  ⇒  écart-type (σ) ↑  ⇒  dispersion ↑\n" +
    "Fatigue ↓  ⇒  écart-type (σ) ↓  ⇒  dispersion ↓\n";

  text(info, 20, 58);

  // Affichage des valeurs
  textSize(15);
  text(String.format("Fatigue       : %.0f / %.0f", fatigue, fatigueMax), 20, 155);
  text(String.format("σ (pixels)    : %.1f", sigma), 20, 178);
  text(String.format("Cadence       : %d tirs/s", shotsPerSecond), 20, 201);
  text(String.format("Impacts (n)   : %d", n), 20, 224);

  // Barre de fatigue
  drawFatigueBar(20, 258, 300, 16);

  // Légende & contrôles
  textSize(14);
  text(
    "Contrôles :\n" +
    "  + / =   : augmenter la fatigue\n" +
    "  - / _   : diminuer la fatigue\n" +
    "  Espace  : tirer en rafale (maintenir)\n" +
    "  Clic    : tir unique\n" +
    "  r       : réinitialiser les impacts",
    20, 292
  );
}

void drawFatigueBar(float x, float y, float w, float h) {
  // fond
  noStroke();
  fill(230);
  rect(x, y, w, h, 8);

  // valeur
  float t = constrain((fatigue - fatigueMin) / (fatigueMax - fatigueMin), 0, 1);
  // dégradé simple via alpha en superposant
  fill(255, 80, 80);
  rect(x, y, w * t, h, 8);

  // cadre
  noFill();
  stroke(0, 50);
  rect(x, y, w, h, 8);
}

float currentSigma() {
  return sigmaBase + sigmaPerFatigue * fatigue;
}

void shootOne() {
  // Erreurs normales indépendantes en X et Y
  float sigma = currentSigma();
  float dx = (float) randomGaussian() * sigma;
  float dy = (float) randomGaussian() * sigma;

  // Impact sur la cible
  float hx = aimX + dx;
  float hy = aimY + dy;

  hits.add(new PVector(hx, hy));
  if (hits.size() > maxShots) {
    hits.remove(0);
  }
}

void mousePressed() {
  shootOne();
}

void keyPressed() {
  // Certaines dispositions clavier: '+' peut être Shift+'='
  if (key == '+' || key == '=') {
    fatigue = min(fatigueMax, fatigue + 2);
  } else if (key == '-' || key == '_') {
    fatigue = max(fatigueMin, fatigue - 2);
  } else if (key == ' ') {
    holdingFire = true;
  } else if (key == 'r' || key == 'R') {
    hits.clear();
  }
}

void keyReleased() {
  if (key == ' ') {
    holdingFire = false;
  }
}
