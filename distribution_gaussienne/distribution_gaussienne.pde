// Retourne un nombre avec une moyenne de 0 et un écart-type de 1.


int[] randomCounts;

void setup () {
  size (400, 320);
  randomCounts = new int[50];
}

void draw () {
  background (255);
  
  float num = randomGaussian();
  float sd = 5;
  float mean = randomCounts.length / 2;
  
  int index = int (sd * num + mean);
  randomCounts[index]++;
  
  stroke (0);
  fill (175);
  int w = width / randomCounts.length;
  
  for (int x = 0; x < randomCounts.length; x++) {
    rect (x * w, height - randomCounts[x], w - 1, randomCounts[x]);
  }  
}