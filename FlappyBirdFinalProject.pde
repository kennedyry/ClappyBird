import processing.sound.*;

AudioIn input; 
Amplitude amp; 
float gravity = .5; 
Player player; 
Ear ear; 
SoundFile jumpSound, pointSound, dieSound; 
int score, highScore, gameState, scoreDivider; 
ArrayList<Wall> walls = new ArrayList<Wall>(); 
ArrayList<Wall> deadWalls; 
ArrayList<Trail> trails = new ArrayList<Trail>(); 
ArrayList<Trail> deadTrails;  
ArrayList<Confetti> confettis = new ArrayList<Confetti>(); 
ArrayList<Confetti> deadConfettis; 
ArrayList<Building> buildings = new ArrayList<Building>(); 
ArrayList<Building> deadBuildings; 
ArrayList<Gate> gates = new ArrayList<Gate>(); 
ArrayList<Gate> deadGates = new ArrayList<Gate>(); 
int maxTimer = 120; 
int maxSoundTimer = 10; 
int maxBuildingTimer = 90; 

int buildingTimer = maxBuildingTimer; 
int timer = maxTimer; 
boolean lost, darkMode, jumpCooldown; 
int soundTimer = maxSoundTimer; 

PImage background; 

void setup() {
  size(1000, 600); 
  jumpSound = new SoundFile(this, "BirdJump.wav"); 
  pointSound = new SoundFile(this, "BirdPoint.wav"); 
  dieSound = new SoundFile(this, "BirdDie.wav"); 
  background = loadImage("background.jpg"); 
  background.resize(width, height); 
  reset();
  textAlign(CENTER);
  initializeSerial();
}

void draw() {
  if (gameState == 0) {
    image(background, 0, 0); 
    fill(0, 255); 
    textSize(25); 
    text("Welcome to Clappy Bird, \n Your name name is Popo the Dodo.\n Clap or make a loud noise to make Popo jump, \n Match Popo's tail color with the gate color \n in between each pair of pipes to score points.  \n Clap to begin!.", width/2, height/4);
    if (amp.analyze() > 0.4)gameState = 1;
  } else if (gameState == 1) {
    deadWalls = new ArrayList<Wall>(); 
    deadTrails = new ArrayList<Trail>(); 
    deadConfettis = new ArrayList<Confetti>(); 
    deadBuildings = new ArrayList<Building>(); 
    deadGates = new ArrayList<Gate>(); 
    drawBackGround();   
    if (score % 10 == 0 && scoreDivider != score && score != 0) {
      scoreDivider = score; 
      darkMode = !darkMode;
    }
    if (buildingTimer <= 0) {
      buildingTimer = (int)random(45, 90); 
      buildings.add(new Building());
    }
    buildingTimer--; 
    for (Building b : buildings) {
      b.update();
      if (b.x + 50 < 0) deadBuildings.add(b);
    }
    for (Building b : deadBuildings) buildings.remove(b);
    float vol = amp.analyze();  
    if (vol > 0.4 && !jumpCooldown) {
      if (lost) {
        reset(); 
        gameState = 0;
      } else {
        ear.jumped = true; 
        player.jumped = true; 
        player.speed = map(vol, 0.4, 0.8, -10, -21); 
        jumpSound.play();  
        jumpCooldown = true; 
        for (int i = 0; i < 10; i++) confettis.add(new Confetti(player.x, player.y));
      }
    }
    if (jumpCooldown) soundTimer--; 
    if (soundTimer <= 0) {
      soundTimer = maxSoundTimer; 
      jumpCooldown = false;
    }  

    if (timer <= 0) {
      timer = maxTimer; 
      float yCord = random(100, height - 150); 
      Wall w = new Wall(width + 50, -25, 50, yCord); 
      walls.add(w); 
      w = new Wall(width + 50, yCord + 250, 50, height); 
      walls.add(w);
      Gate g = new Gate(width + 50, yCord - 25, 50, 275);
      gates.add(g);
    }  
    timer--;
    for (Trail t : trails) {
      t.update(); 
      if (t.x + 10 < 0) deadTrails.add(t);
    }
    for (Trail t : deadTrails) trails.remove(t); 
    for (Confetti c : confettis) {
      c.update(); 
      if (c.y - c.size > height)deadConfettis.add(c);
    }
    for (Confetti c : deadConfettis) confettis.remove(c); 
    for (Gate g : gates) {
      g.update(); 
      g.collision(player); 
      if (g.x + g.w < 0) deadGates.add(g);
    }
    for (Gate g : deadGates) gates.remove(g); 
    player.update(); 
    /*
    ear.x = (int)(player.x + player.size/7); 
     ear.y = (int)player.y - player.size/2; 
     ear.update();
     */
    if (player.y - 100 > height) lost = true; 
    if (player.y < 0) player.y = 0; 
    trails.add(new Trail((int)player.x, (int)player.y)); 
    for (Wall w : walls) {
      w.update(); 
      w.collision(player); 
      if (w.x + 100 < 0) deadWalls.add(w);
    }
    for (Wall w : deadWalls) walls.remove(w);  
    if (score > highScore) highScore = score; 
    textSize(20); 
    fill(#FA5D03); 
    text("Score: " + score, width / 5, height / 10);
    text("Highscore: " + highScore, width / 5, height / 10 + 25);
    if (lost) text("You Lose!\n Clap to Restart", width / 2, height /2);
  }
}
void keyPressed() {
  if (gameState == 0) { 
    if (key == ' ') {
      gameState++;
    }
  }  
  if (gameState == 1) {
    if (lost) {
      reset();
      gameState = 0;
    } else if (key == ',') {
      translate(width/2, height/2); 
      rotate(radians(10));
    } else {
      jumpSound.play(); 
      ear.jumped = true; 
      player.jumped = true; 
      player.speed = -7; 
      for (int i = 0; i < 20; i++) {
        confettis.add(new Confetti(player.x, player.y));
      }
    }
  }
}

void drawBackGround() {
  noStroke(); 
  if (!darkMode)fill(#00F7F1); 
  else fill(#0C3F81); 
  rect(0, 0, width, 4 * height /5); 
  fill(#FCDC63); 
  rect(0, 4 * height / 5, width, height / 5);
  if (!darkMode)fill(#FFF305); 
  else fill(#FAFAF5); 
  ellipse(9 * width / 10, height / 10, 50, 50);
}

void reset() {
  scoreDivider = 0; 
  darkMode = false; 
  score = 0; 
  walls = new ArrayList<Wall>(); 
  trails = new ArrayList<Trail>();
  gates = new ArrayList<Gate>(); 
  ear = new Ear(-100, -100); 
  buildings = new ArrayList<Building>(); 
  player = new Player(width / 8, height / 2); 
  timer = maxTimer;
  lost = false;
  input = new AudioIn(this, 0); 
  input.start(); 
  amp = new Amplitude(this); 
  amp.input(input);
}