class Population {
  DNA bestDNA; // DNA of best iteration
  PImage bestImg; // img of best iteration
  float bestScore = -1; // score of best iteration
  
  DNA currentDNA; // DNA of current iteration
  PImage currentImg; // img of current iteration
  float currentScore; // score of current iteration
  
  PGraphics pg; // graphical context
  
  Population(int polyCount, int vertCount) {
    // creates new DNA for 1st iteration
    this.currentDNA = new DNA(polyCount, vertCount);
    
    // creates a graphical context with dimensions imgW & imgH
    this.pg = createGraphics(imgW, imgH);
  }
  
  void run() {
    // clears graphical context
    // before each iteration
    this.pg.beginDraw();
    this.pg.clear();
    this.pg.endDraw();
    
    if (this.bestScore != -1) {
      this.currentDNA = this.bestDNA.cloneDNA();
    }
    this.mutateDNA();
    this.implementDNA();
    this.calcFitness();
    this.compareFitness();
  }
  
  void mutateDNA() {
    this.currentDNA.mutate_medium();
  }
  
  void implementDNA() {
    this.pg.beginDraw();
    this.pg.background(255);
    
    for (int i = 0; i < this.currentDNA.numOfPolygons; i++) {
      this.pg.beginShape();
      int r = this.currentDNA.r[i];
      int g = this.currentDNA.g[i];
      int b = this.currentDNA.b[i];
      int a = this.currentDNA.a[i];
      this.pg.fill(r, g, b, a);
      this.pg.noStroke();
      
      for (int j = 0; j < this.currentDNA.numOfVertices; j++) {
        int x = this.currentDNA.xpoints[i][j];
        int y = this.currentDNA.ypoints[i][j];
        this.pg.vertex(x, y);
      }
      
      this.pg.endShape(CLOSE);
    }
    
    this.pg.endDraw();
    
    this.currentImg = pg;
  }
  
  void calcFitness() {
    this.pg.loadPixels();
    
    float sum = 0;
    for (int y = 0; y < imgH; y++) {
      for (int x = 0; x < imgW; x++) {
        color rgba_ = target.pixels[x + y*imgW];
        float r_ = red(rgba_);
        float g_ = green(rgba_);
        float b_ = blue(rgba_);
        float a_ = alpha(rgba_);
        
        color rgba = pg.pixels[x + y*imgW];
        float r = red(rgba);
        float g = green(rgba);
        float b = blue(rgba);
        float a = alpha(rgba);
        
        float rdiff = abs(r_ - r);
        float gdiff = abs(g_ - g);
        float bdiff = abs(b_ - b);
        float adiff = abs(a_ - a);
        
        sum += (rdiff + gdiff + bdiff + adiff);
      }
    }
    
    this.currentScore = 100 * (1 - (sum/(imgW*imgH*3*255)));
    
    this.pg.beginDraw();
    this.pg.textSize(12);
    this.pg.fill(0);
    this.pg.text(str(this.currentScore), 5, 15);
    this.pg.endDraw();
    
    this.currentImg = this.pg;
  }
  
  void compareFitness() {    
    if (this.currentScore >= this.bestScore) {
      this.bestDNA = this.currentDNA.cloneDNA();
      this.bestImg = this.currentImg;
      this.bestScore = this.currentScore;
      
      if (bestCount == 100) {
        bestCount = 0;
        this.pg.save("../images/best_" + count + ".png");
        count += 1;
      } else {
        bestCount += 1;
      }
    }
    
    this.currentScore = -1;
  }
}
