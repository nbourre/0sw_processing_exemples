// --- Paramètres ---
int pointsPerSecond = 120;     // vitesse d'ajout (points/seconde pour CHAQUE panneau)
float dotSize = 4;             // taille des points
float alphaDot = 90;           // transparence des points (0-255)

float margin = 24;             // marges internes
float titleTop = 28;           // y du titre

// Gaussienne (panneau de droite)
float sdX = 70;                // écart-type horizontal
float sdY = 50;                // écart-type vertical

// --- Variables internes ---
float meanX, meanY;            // moyennes pour la gaussienne (droite)
float leftMinX, leftMaxX;      // bornes du panneau gauche
float leftMinY, leftMaxY;
float rightMinX, rightMaxX;    // bornes du panneau droit
float rightMinY, rightMaxY;

void setup() {
  size(1200, 600);
  frameRate(pointsPerSecond);        // 1 point par frame et par panneau
  background(255);
  textAlign(CENTER, CENTER);
  textSize(16);

  // Définir les panneaux
  float mid = width * 0.5;
  leftMinX  = margin;
  leftMaxX  = mid - margin;
  rightMinX = mid + margin;
  rightMaxX = width - margin;

  leftMinY  = titleTop + 16;
  leftMaxY  = height - margin;
  rightMinY = titleTop + 16;
  rightMaxY = height - margin;

  // Moyennes centrées dans le panneau de droite
  meanX = (rightMinX + rightMaxX) * 0.5;
  meanY = (rightMinY + rightMaxY) * 0.5;

  // Lignes guides
  stroke(230);
  line(width/2, 0, width/2, height);

  // Titres initiaux
  fill(0);
  noStroke();
  text("Distribution uniforme (X, Y)", (leftMinX + leftMaxX)/2, titleTop);
  text("Distribution normale (X, Y)",  (rightMinX + rightMaxX)/2, titleTop);
}

void draw() {
  // Redessiner titres pour qu'ils restent visibles
  fill(0);
  noStroke();
  rectMode(CORNERS);
  // Bande blanche sous les titres (anti-écrasement)
  fill(255);
  noStroke();
  rect(0, 0, width, titleTop + 12);
  fill(0);
  text("Distribution uniforme (X, Y)", (leftMinX + leftMaxX)/2, titleTop);
  text("Distribution normale (X, Y)",  (rightMinX + rightMaxX)/2, titleTop);

  // Ligne centrale
  stroke(230);
  line(width/2, 0, width/2, height);

  // --- 1) Un point uniforme (gauche) ---
  float ux = random(leftMinX, leftMaxX);
  float uy = random(leftMinY, leftMaxY);
  noStroke();
  fill(0, alphaDot);
  ellipse(ux, uy, dotSize, dotSize);

  // --- 2) Un point gaussien (droite) ---
  // Rejet si on sort du panneau (on essaie quelques fois pour respecter la forme)
  float gx = 0, gy = 0;
  boolean ok = false;
  for (int attempt = 0; attempt < 20; attempt++) {
    gx = (float)randomGaussian() * sdX + meanX;
    gy = (float)randomGaussian() * sdY + meanY;
    if (gx >= rightMinX && gx <= rightMaxX && gy >= rightMinY && gy <= rightMaxY) {
      ok = true;
      break;
    }
  }
  if (!ok) {
    // si on n'a pas réussi après 20 tentatives, on contraint (rare)
    gx = constrain(gx, rightMinX, rightMaxX);
    gy = constrain(gy, rightMinY, rightMaxY);
  }
  noStroke();
  fill(0, alphaDot);
  ellipse(gx, gy, dotSize, dotSize);
}
