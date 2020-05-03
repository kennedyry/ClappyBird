class Gate {
  float x, y, w, h; 
  color c; 
  int speed = 5; 
  boolean dead;

  Gate(float x, float y, float w, float h) {
    this.x = x; 
    this.y = y; 
    this.w = w; 
    this.h = h; 
    colorMode(HSB); 
    c = color(random(50), 255, 255); 
    colorMode(RGB);
  }

  void update() {
    if (!dead) {
      fill(c, 200); 
      rect(x, y, w, h);
    }
    if (!lost)x -= speed;
  }
  void collision(Player p) {
    int diff = 50;  
    if (trails.size() > 0) {
      Trail last = trails.get(trails.size()-1);
      diff = (int)abs(hue(last.c) - hue(c));
    }
    if (x + w/2 < p.x && diff < 15 && !dead) {
      pointSound.play(); 
      score++; 
      dead = true;
    }
  }
}