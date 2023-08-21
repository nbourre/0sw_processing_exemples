int[] randomCounts;

void setup () {
  size (800, 320);
  randomCounts = new int[20];
  delay (1000);
}

void draw () {
  background (255);
  
  int index = int (random (randomCounts.length));
  randomCounts[index]++;
  
  stroke (0);
  fill (175);
  int w = width / randomCounts.length;
  
  for (int x = 0; x < randomCounts.length; x++) {
    rect (x * w, height - randomCounts[x], w - 1, randomCounts[x]);
  }  
}
