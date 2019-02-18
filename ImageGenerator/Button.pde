class Button {
  int x, y;
  int w, h;
  
  String func;
  
  color c;
  
  String text;
  
  Button(int x, int y, int w, int h, String text, String func) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.text = text;
    this.func = func;
    
    this.c = color(135,206,250);
  }
  
  void updateButton() {
    if (mouseButton == LEFT) {
      if ((mouseX <= this.x + (this.w/2)) &&
          (mouseX >= this.x - (this.w/2)) &&
          (mouseY <= this.y + (this.h/2)) &&
          (mouseY >= this.y - (this.h/2))) {
        this.c = color(240,248,255);
        this.runFunc();  
        return;
      }
    }
    this.c = color(135,206,250);
  }
  
  void showButton() {
    rectMode(CENTER);
    noStroke();
    fill(this.c);
    rect(this.x, this.y, this.w, this.h, 1);
    fill(0);
    textAlign(CENTER);
    text(this.text, this.x, this.y);
  }
  
  void runFunc() {
    if (this.func == "SAVE") {
      population.bestDNA.saveDNA();
    } else if (this.func == "IMPORT") {
      population.bestScore = -1;
      population.currentDNA.importDNA();
      // load json
    }
  }
  
}
