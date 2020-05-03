class Ear {
  int x, y, maxSize; 
  PImage ear; 
  int size = 25; 
  int defaultSize = 25;
  boolean jumped, shrinking; 

  Ear(int x, int y) {
    this.x = x; 
    this.y = y; 
    ear = loadImage("ear.png"); 
    ear.resize(size, size);
    maxSize = 50;
  }
  void update() {
    ear = loadImage("ear.png"); 
    ear.resize(size, size);
    if (jumped) {
      shrinking = false; 
      size += 5;
    }
    if (jumped && size > maxSize) {
      shrinking = true; 
      jumped = false;
    }
    if (shrinking)size-= 5; 
    if (size < defaultSize) {
      size = defaultSize; 
      shrinking = false;
    }
    //image(ear, x - size/2, y - size/2);
  }
}