class Wall {
  float x, y, w, h; 
  boolean added = false; 

  Wall(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h;
  }
  void update() {
    strokeWeight(5); 
    stroke(0); 
    fill(0, 255, 0); 
    rect(x, y, w, h); 
    if (!lost) x -= 5;
  }
  void collision(Player p) {
    if ((p.x > x && p.x < x + w) || (p.x + p.size/4 > x && p.x + p.size/4 < x + w)) {
      if ((p.y > y && p.y < y + h) || (p.y + p.size/2 > y && p.y + p.size/2 < y + h)) {
        if (!dieSound.isPlaying()) dieSound.play(); 
        lost = true;
      } 
    }
    if (x <= player.x/2 && y > p.y && !added){
       added = true; 
    }
  }
}