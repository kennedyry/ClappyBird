class Building {
  PImage cactus = loadImage("cactus.png"); 
  PShape star; 
  int x = width + 100; 
  int y, speed; 
  int choice = (int)random(0, 2);  
  //int choice = 1; 
  int size = (int)random(50, 100); 

  Building() {
    if (choice == 0) {
      y = 3 * height / 5; 
      cactus.resize(height / 10, height / 5);
      speed = 6;
    } else if (choice == 1) {
      y = (int)random(height / 10, height / 5);
      speed = (int)random(3, 10);
      if (darkMode){
         size = (int)random(15,30);  
      }
    } else {
    }
  }

  void update() {
    if (choice == 0) drawCactus();
    else if (choice == 1) {
      if (!darkMode)drawCloud(); 
      else drawStar();
    } else drawHouse(); 
    if (!lost)x -= speed;
  }
  void drawCactus() {
    image(cactus, x, y);
  }
  void drawCloud() {
    noStroke(); 
    fill(255);
    ellipse(x - size/3, y, size, size); 
    ellipse(x, y, size, 3 * size/2); 
    ellipse(x + size/3, y, size, size);
  }
  void drawHouse() {
    
  }
  void drawStar() {
    star = createShape();
    star.beginShape();
    star.fill(#E0D609); 
    //star.stroke(255);
    star.noStroke(); 
    star.strokeWeight(1);
    star.vertex(x, y - size);
    star.vertex(x + 0.28*size, y - 0.4 * size);
    star.vertex(x+.94 * size, y-.3 * size);
    star.vertex(x+.46 * size, y+.14 * size);
    star.vertex(x+.58 * size, y+.8 * size);
    star.vertex(x, y+.5 * size);
    star.vertex(x-.58 * size, y+.8 * size);
    star.vertex(x-.46 * size, y+.14 * size);
    star.vertex(x-.94 * size, y-.3 * size);
    star.vertex(x-.28 * size, y-.4 * size);
    /*
    star.vertex(x, y - 50);
     star.vertex(x + 14,y - 20);
     star.vertex(x+47, y-15);
     star.vertex(x+23, y+7);
     star.vertex(x+29, y+40);
     star.vertex(x, y+25);
     star.vertex(x-29, y+40);
     star.vertex(x-23, y+7);
     star.vertex(x-47, y-15);
     star.vertex(x-14, y-20);
     */
    star.endShape(CLOSE);
    shape(star);
  }
}