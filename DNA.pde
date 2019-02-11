class DNA {
  int numOfPolygons;
  int numOfVertices;
  int[][] xpoints;
  int[][] ypoints;
  int[] r, g, b;
  int[] a;
  
  // DNA contructor: accepts # polygons, # vertices
  DNA(int polyCount, int vertCount) {
    this.numOfPolygons = polyCount;
    this.numOfVertices = vertCount;
    
    this.xpoints = new int[this.numOfPolygons][this.numOfVertices];
    this.ypoints = new int[this.numOfPolygons][this.numOfVertices];
    this.r = new int[this.numOfPolygons];
    this.g = new int[this.numOfPolygons];
    this.b = new int[this.numOfPolygons];
    this.a = new int[this.numOfPolygons];
    
    // assign vertices for each polygon
    for (int i = 0; i < this.numOfPolygons; i++) {
      int[] xp = new int[this.numOfVertices];
      int[] yp = new int[this.numOfVertices];
      
      // assign point values for each vertex
      for (int j = 0; j < this.numOfVertices; j++) {
        int x = int(random(-5, imgW + 5));
        int y = int(random(-5, imgH + 5));
        
        xp[j] = x;
        yp[j] = y;
      }
      
      this.xpoints[i] = xp;
      this.ypoints[i] = yp;
      
      this.r[i] = int(random(0, 255));
      this.g[i] = int(random(0, 255));
      this.b[i] = int(random(0, 255));
      this.a[i] = int(random(0, 255));
    }
  }
  
  void mutate_medium() {
    float rand = random(0, 1);
    int randomPoly = int(random(this.numOfPolygons));
    
    if (rand < 0.5) {
      int randomRGBA = int(random(-255, 256));
      if (rand < 0.125) {
        this.r[randomPoly] += randomRGBA;
        this.r[randomPoly] = constrain(this.r[randomPoly], 0, 255);
      } else if (rand < 0.25) {
        this.g[randomPoly] += randomRGBA;
        this.g[randomPoly] = constrain(this.g[randomPoly], 0, 255);
      } else if (rand < 0.375) {
        this.b[randomPoly] += randomRGBA;
        this.b[randomPoly] = constrain(this.b[randomPoly], 0, 255);
      } else if (rand < 0.5) {
        this.a[randomPoly] += randomRGBA;
        this.a[randomPoly] = constrain(this.a[randomPoly], 0, 255);
      }
    } else {
      int randomXY = int(random(-min(imgW, imgH), min(imgW, imgH)));
      int randomPoint = int((random(this.numOfVertices)));
      if (rand < 0.75) {
        this.xpoints[randomPoly][randomPoint] += randomXY;
        this.xpoints[randomPoly][randomPoint] = constrain(this.xpoints[randomPoly][randomPoint], -5, imgW + 5);
      } else {
        this.ypoints[randomPoly][randomPoint] += randomXY;
        this.ypoints[randomPoly][randomPoint] = constrain(this.ypoints[randomPoly][randomPoint], -5, imgH + 5);
      }
    }
  }
  
  // creates a clone of DNA (not a shallow copy)
  DNA cloneDNA() {
    DNA clone = new DNA(this.numOfPolygons, this.numOfVertices);
    
    for (int i = 0; i < clone.numOfPolygons; i++) {
      for (int j = 0; j < clone.numOfVertices; j++) {
        clone.xpoints[i][j] = this.xpoints[i][j];
        clone.ypoints[i][j] = this.ypoints[i][j];
      }
      clone.r[i] = this.r[i];
      clone.g[i] = this.g[i];
      clone.b[i] = this.b[i];
      clone.a[i] = this.a[i];
    }
    
    return clone;
  }
}
