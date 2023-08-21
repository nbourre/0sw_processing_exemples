// Retourne un nombre avec une moyenne de 0 et un écart-type de 1.
// La règle générale de la courbe normale (ou gaussienne)
// ±1 écart-type : 68% de la population
// ±2 écart-type : 95% de la population
// ±3 écart-type : 99.7% de la population

int[] randomCounts;

void setup () {
  size (800, 320);
  randomCounts = new int[50];
  
}

void draw () {
  
  background (255);
  
  float num = randomGaussian();
  float sd = 5; // Standard deviation | Écart-type
  float mean = randomCounts.length / 2; // Moyenne
  
  int index = int (sd * num + mean);
  randomCounts[index]++;
  
  stroke (0);
  fill (175);
  int w = width / randomCounts.length;
  
  for (int x = 0; x < randomCounts.length; x++) {
    rect (x * w, height - randomCounts[x], w - 1, randomCounts[x]);
  }  
}
