class Player {
  float x, y, speed; 
  int size, maxFlapTimer, flapTimer, startingSize, maxSize;
  boolean up, jumped, shrinking; 
  PImage bUp = loadImage("birdup.png"); 
  PImage bDown = loadImage("birddown.png"); 


  Player(float x, float y) {
    this.x = x; 
    this.y = y; 
    size = 75; 
    startingSize = size;
    maxSize = (int)(size * 1.5); 
    bUp.resize(2 * size, size);
    bDown.resize(2 * size, size); 
    maxFlapTimer = 5; 
    flapTimer = maxFlapTimer;
    speed = -14; 
  }
  
  
  void update() {
    bUp = loadImage("birdup.png"); 
    bDown = loadImage("birddown.png"); 
    bUp.resize(2*size, size); 
    bDown.resize(2*size, size); 
    if (jumped) {
     shrinking = false; 
     size += 5;
    }
    if (jumped && size > maxSize) {
     shrinking = true; 
     jumped = false;
    }
    if (shrinking)size-= 5; 
    if (size < startingSize) {
     size = startingSize; 
     shrinking = false;
    }

    if (flapTimer <= 0) {
      flapTimer = maxFlapTimer; 
      up = !up;
    }
    flapTimer--; 
    if (up) image(bUp, x - size, y - size/2); 
    else image(bDown, x - size, y - size/2); 
    y += speed; 
    speed += gravity;
  }
}  