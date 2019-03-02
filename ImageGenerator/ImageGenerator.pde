static PImage target;
static Population population;
static Button saveButton, importButton;
static int bestCount, count;

static int imgW, imgH;

void setup() {
  size(400, 300);
  bestCount = 0;
  count = 0;
  
  target = loadImage("img.png");
  imgW = target.width;
  imgH = target.height;
  
  target.loadPixels();
  
  population = new Population(1000, 12);
  saveButton = new Button(100, 250, 100, 50, "SAVE", "SAVE");
  importButton = new Button(300, 250, 100, 50, "IMPORT", "IMPORT");
  
}

void mousePressed() {
  importButton.updateButton();
  saveButton.updateButton();
}

void draw() {
  background(0);
  
  importButton.showButton();
  saveButton.showButton();
  
  population.run();
  
  //image(target, 0, 0);
  //image(population.bestImg, imgW, 0);
}
