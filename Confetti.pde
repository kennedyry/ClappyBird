class Confetti {
  float x, y, vSpeed, hSpeed; 
  int size = (int) random(5, 20); 
  color c; 
  Confetti(float posX, float posY) {
    x = posX + random(-5, 5); 
    y = posY + random(-5, 5); 
    hSpeed = random(-5, 5);
    colorMode(HSB);
    c = color(random(255), 255, 255); 
    colorMode(RGB); 
  }

  void update() {
    fill(c);
    ellipse(x, y, size, size); 
    x += hSpeed;
    y += vSpeed; 
    vSpeed += random(1);
  }
}