static PImage target;
static Population population;
static int bestCount, count;

static int imgW, imgH;

void setup() {
  size(400, 200);
  bestCount = 0;
  count = 0;
  
  target = loadImage("img.png");
  imgW = target.width;
  imgH = target.height;
  
  target.loadPixels();
  image(target, 0, 0);
  
  population = new Population(1000, 12);
}

void draw() {
  population.run();
  image(population.bestImg, imgW, 0);
}
