// --- Simulation de tirs avec dispersion normale + mire qui tremble (Perlin) ---
// Contrôles:
//   + / = : augmenter la fatigue (dispersion + tremblement)
//   - / _ : diminuer la fatigue
//   Espace : tir en rafale (maintenir)
//   Clic    : tir unique
//   f       : activer/désactiver la mire qui tremble (Perlin)
//   r       : réinitialiser les impacts

// ---------------- Paramètres généraux ----------------
int shotsPerSecond = 10;      // cadence de tir (en maintenant Espace)
float dotSize = 6;            // taille des impacts
int maxShots = 2000;          // limite mémoire d'impacts

// Modèle de dispersion (normale) : sigma = base + k * fatigue
float fatigue = 20;           // 0..100
float fatigueMin = 0;
float fatigueMax = 100;
float sigmaBase = 3.0;        // écart-type minimal (pixels)
float sigmaPerFatigue = 0.6;  // +σ par point de fatigue

// ---------------- Cible ----------------
float targetCX, targetCY;     // centre fixe de la cible (bullseye)
float[] rings = {120, 90, 60, 30};

// ---------------- Mire (Perlin) ----------------
// La mire représente le point visé dynamique ; les tirs se centrent sur elle.
boolean wobbleEnabled = true;   // toggle avec 'f'

// Amplitude du tremblement (pixels) : amp = base + k * fatigue
float wobbleAmpBase = 2.0;
float wobbleAmpPerFatigue = 0.5;

// Vitesse de défilement du Perlin (unités bruit / seconde) : step = base + k * fatigue
float wobbleStepBase = 0.6;
float wobbleStepPerFatigue = 0.03;

// États internes pour le bruit Perlin
float perlinTX = 0.0, perlinTY = 1000.0; // temps/phase bruit X/Y (décalés)
float aimX, aimY;                         // position courante de la mire
int lastMs = 0;

// ---------------- Tir automatique ----------------
boolean holdingFire = false;
int fireIntervalMs;
int lastShotMs = 0;

// ---------------- Impacts ----------------
ArrayList<PVector> hits = new ArrayList<PVector>();

void setup() {
  size(900, 500);
  surface.setTitle("Tirs gaussiens + mire tremblante (Perlin) — +/- fatigue, f: toggle");
  targetCX = width * 0.7;
  targetCY = height * 0.5;

  aimX = targetCX;
  aimY = targetCY;

  fireIntervalMs = int(1000.0 / shotsPerSecond);
  lastMs = millis();
}

void draw() {
  // --- Temps écoulé (pour vitesse indépendante du framerate)
  int now = millis();
  float dt = (now - lastMs) / 1000.0;
  lastMs = now;

  background(255);

  // Panneau d'infos
  drawSidebar();

  // Cible à droite (fond + anneaux + bullseye fixe)
  drawTarget();

  // Mettre à jour la mire (Perlin) selon la fatigue
  updateWobble(dt);

  // Cercle ~95% (≈ 2σ) autour de la mire actuelle (pédagogique)
  float sigma = currentSigma();
  noFill();
  stroke(0, 140);
  strokeWeight(1.5);
  ellipse(aimX, aimY, 4 * sigma, 4 * sigma); // diamètre = 2*(2σ)

  // Afficher les impacts
  noStroke();
  fill(20, 120, 255, 150);
  for (PVector h : hits) {
    ellipse(h.x, h.y, dotSize, dotSize);
  }

  // Dessiner la mire (réticule)
  drawReticle(aimX, aimY);

  // Tir automatique si actif
  if (holdingFire && now - lastShotMs >= fireIntervalMs) {
    shootOne();
    lastShotMs = now;
  }
}

void updateWobble(float dt) {
  if (!wobbleEnabled) {
    // Si désactivé : la mire revient doucement au centre
    float relax = 8.0 * dt; // vitesse de retour
    aimX = lerp(aimX, targetCX, constrain(relax, 0, 1));
    aimY = lerp(aimY, targetCY, constrain(relax, 0, 1));
    return;
  }
  // Paramètres dépendants de la fatigue
  float amp  = wobbleAmpBase  + wobbleAmpPerFatigue  * fatigue;          // amplitude (px)
  float step = wobbleStepBase + wobbleStepPerFatigue * fatigue;          // pas Perlin (/s)

  // Avancer les phases de bruit
  perlinTX += step * dt;
  perlinTY += step * dt * 1.13;  // facteur différent pour éviter la corrélation X/Y

  // Valeurs Perlin centrées sur 0 : noise ∈ [0,1] → [-1,1]
  float nx = noise(perlinTX) * 2.0 - 1.0;
  float ny = noise(perlinTY) * 2.0 - 1.0;

  // Offsets
  float ox = nx * amp;
  float oy = ny * amp;

  // Position de mire
  aimX = targetCX + ox;
  aimY = targetCY + oy;
}

void drawTarget() {
  // Fond de la zone cible
  noStroke();
  fill(250);
  rect(width*0.45, 0, width, height);

  // Cercles concentriques
  stroke(200);
  strokeWeight(1);
  noFill();
  for (float r : rings) {
    ellipse(targetCX, targetCY, 2*r, 2*r);
  }

  // Bullseye (centre fixe de la cible)
  noStroke();
  fill(255, 50, 50);
  ellipse(targetCX, targetCY, 14, 14);
}

void drawReticle(float x, float y) {
  stroke(30, 140);
  strokeWeight(2);
  // croix
  line(x - 14, y, x + 14, y);
  line(x, y - 14, x, y + 14);
  // anneau
  noFill();
  ellipse(x, y, 20, 20);
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
  text("Précision (normale) + mire tremblante (Perlin)", 20, 18);

  // Infos
  textSize(14);
  float sigma = currentSigma();
  int n = hits.size();

  String info =
    "Les erreurs de tir (dx, dy) suivent une normale\n" +
    "centrée sur la MIRE (réticule). La mire peut\n" +
    "trembler via du bruit de Perlin.\n" +
    "\n" +
    "Fatigue ↑  ⇒  σ ↑  (dispersion) et tremblement ↑\n" +
    "Fatigue ↓  ⇒  σ ↓  et tremblement ↓\n";

  text(info, 20, 58);

  // Affichage des valeurs
  textSize(15);
  text(String.format("Fatigue         : %.0f / %.0f", fatigue, fatigueMax), 20, 155);
  text(String.format("σ (pixels)      : %.1f", sigma), 20, 178);
  text(String.format("Cadence         : %d tirs/s", shotsPerSecond), 20, 201);
  text(String.format("Impacts (n)     : %d", n), 20, 224);
  text(String.format("Mire (Perlin)   : %s", wobbleEnabled ? "ACTIVE" : "désactivée"), 20, 247);

  // Barre de fatigue
  drawFatigueBar(20, 276, 300, 16);

  // Légende & contrôles
  textSize(14);
  text(
    "Contrôles :\n" +
    "  + / =   : + fatigue\n" +
    "  - / _   : - fatigue\n" +
    "  f       : activer/désactiver mire tremblante\n" +
    "  Espace  : tir en rafale (maintenir)\n" +
    "  Clic    : tir unique\n" +
    "  r       : réinitialiser les impacts",
    20, 310
  );
}

void drawFatigueBar(float x, float y, float w, float h) {
  noStroke();
  fill(230);
  rect(x, y, w, h, 8);

  float t = constrain((fatigue - fatigueMin) / (fatigueMax - fatigueMin), 0, 1);
  fill(255, 80, 80);
  rect(x, y, w * t, h, 8);

  noFill();
  stroke(0, 50);
  rect(x, y, w, h, 8);
}

float currentSigma() {
  return sigmaBase + sigmaPerFatigue * fatigue;
}

void shootOne() {
  // Dispersion normale autour de la MIRE (position actuelle)
  float sigma = currentSigma();
  float dx = (float) randomGaussian() * sigma;
  float dy = (float) randomGaussian() * sigma;

  float hx = aimX + dx;
  float hy = aimY + dy;

  hits.add(new PVector(hx, hy));
  if (hits.size() > maxShots) hits.remove(0);
}

void mousePressed() {
  shootOne();
}

void keyPressed() {
  if (key == '+' || key == '=') {
    fatigue = min(fatigueMax, fatigue + 2);
  } else if (key == '-' || key == '_') {
    fatigue = max(fatigueMin, fatigue - 2);
  } else if (key == ' ') {
    holdingFire = true;
  } else if (key == 'r' || key == 'R') {
    hits.clear();
  } else if (key == 'f' || key == 'F') {
    wobbleEnabled = !wobbleEnabled;
  }
}

void keyReleased() {
  if (key == ' ') holdingFire = false;
}
