float yOff = 0.0;
float xOff = 0.0;

float previous;
float t = 0;

float noise = noise(xOff * width, yOff * height);


float dir = 1;
float inc = 0.01;

void setup () {
  size (800, 600);
  background(204);
  
}

void draw() {
  previous = noise; 
  yOff += inc;  
  xOff += inc;
  
  noise = noise(xOff * width, yOff * height); 
  line (t - 1, previous, t, noise);
  
  if (t > width)
    t = 0;
    
  t++;
}
