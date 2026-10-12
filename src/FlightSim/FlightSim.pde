// Karlyn Tran | 9-16-26 | Flight Sim
Ship ship01;
Timer timer1, puDist, pSpawn, pulLength, putLength;
Projectile laser;
Boss boss01;
boolean pdis, gameState, started;
import gifAnimation.*;
import processing.sound.*;
SoundFile lazer01, explosion, winner, loser, collect;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<PowerUp> powers = new ArrayList<PowerUp>();
ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
int score, enemyCount, rocksPassed, laserSpeed, gameLevel;
PImage bg, startscreen, overscreen, winscreen;
float bx=300, by=550, bw=200, bh=100;
void setup() {
  size(800, 800);  
  bg = loadImage("background.png");
  startscreen = loadImage("start.png");
  overscreen = loadImage("gameover.png");
  winscreen = loadImage("winn.png");
  ship01 = new Ship(width/2, height/2, 0, this);
  score = 0;
  boss01 = new Boss(0,100, gameLevel);
  timer1 = new Timer(750);
  puDist = new Timer(1500);
  pSpawn = new Timer(500);
  pulLength = new Timer(5000);
  putLength = new Timer(5000);
  laserSpeed = 5;
  gameState = true;
  gameLevel = -1;
  background(startscreen);
  rectMode(CORNER);
  fill(0);
  rect(bx, by, bw, bh);
  textAlign(CENTER);
  fill(255);
  textSize(60);
  text("Start", 400, 620);
  lazer01 = new SoundFile(this, "l1.mp3");
  winner = new SoundFile(this, "win.mp3");
  loser = new SoundFile(this, "lose.mp3");
  explosion = new SoundFile(this, "expsound.mp3");
  collect = new SoundFile(this, "powercollect.mp3");
}
void startGame() {
  timer1.start();
  puDist.start();
  pSpawn.start();
}
void reset() {
  gameState = false;
  enemies = new ArrayList<Enemy>();
  powers = new ArrayList<PowerUp>();
  projectiles = new ArrayList<Projectile>();
  timer1.start();
  puDist.start();
  pSpawn.start();
  ship01.health = 50;
  rocksPassed = 0;
  enemyCount = 0;
  score = 0;
  ship01.turretCount = 1;
  laserSpeed = 5;
  loop();
}
void mousePressed() {
  if (pSpawn.isFinished()&& (gameState == false)) {
    if (ship01.turretCount == 1){
      projectiles.add(new Projectile(ship01.x, ship01.y-50, this, laserSpeed,1));
    }
    if (ship01.turretCount == 2){
      projectiles.add(new Projectile(ship01.x-20, ship01.y-50, this, laserSpeed,1));
      projectiles.add(new Projectile(ship01.x+20, ship01.y-50, this, laserSpeed,1));
    }
    if (ship01.turretCount >= 3){
      projectiles.add(new Projectile(ship01.x-40, ship01.y-50, this, laserSpeed,1));
      projectiles.add(new Projectile(ship01.x, ship01.y-50, this, laserSpeed,1));
      projectiles.add(new Projectile(ship01.x+40, ship01.y-50, this, laserSpeed,1));
    }
    pSpawn.start();
    lazer01.play();
    
  }
  if ((mouseX >= bx && mouseX <= bx + bw && mouseY >= by && mouseY <= by + bh)&&(gameState == true)) {
    if (started == false){
      gameState = false;
      started = true;
      gameLevel ++;
      startGame();
    } else {
      reset();
    }
    
  }
}
//add infopanel()
void infoPanel() {
  fill(127, 127);
  rectMode(CORNER);
  rect(0, 0, width, 40);
  fill(255);
  textSize(35);
  textAlign(CORNER, CORNER);
  text("score: " + score, 20, 35);
  text("rock count: " + enemyCount, 200, 35);
  text("Health: " + ship01.health, 420, 35);
}
void draw() {
  if (rocksPassed >= 20 || ship01.health <= 0) {
    gameState = true;
    if (score >= 1000){
      background(winscreen);
      winner.play();
    } else{
      background(overscreen);
      loser.play();
    }
    textAlign(CENTER);
    rectMode(CENTER);
    fill(0);
    rect(bx, by, bw, bh);
    fill(255);
    textSize(60);
    text("Restart", 400, 620);
    noLoop();
  }
  if (gameState == false) {
    //noCursor();
    background(bg);
    ship01.updatePosition();
    ship01.display();
    
    for (int i = 0; i<projectiles.size(); i++) {
      //println("projectiles:" +projectiles.size());
      Projectile p = projectiles.get(i);
      if (p.isOffScreen()== true) {
        projectiles.remove(p);
      }
      p.move();
      p.display();
    }
    for (int i = 0; i<enemies.size(); i++) {
      //println("rocks:" +enemies.size());
      Enemy r = enemies.get(i);
      //add isHit()
      for (int j = 0; j<projectiles.size(); j ++) {
        Projectile p = projectiles.get(j);
        if (p.isHit(r)) {
          projectiles.remove(p);
          if (r.isExploding == false && r.isDead == false){
            explosion.play();
            r.isHit = true;
            score+=100;
            rocksPassed++;
          }
          if (r.isDead == true) {
            enemies.remove(r);
          }
        }
      }
      if (ship01.isHit(r)) {
        if (r.isExploding == false && r.isDead == false){
          explosion.play();
          r.isHit = true;
          ship01.health-=20;
          rocksPassed++;
        }
      }
      if (r.isDead == true) {
        enemies.remove(r);
      }
      if (r.isOffScreen()== true) {
        enemies.remove(r);
        rocksPassed++;
      }
      r.move();
      r.display();
    }
    for (int i = 0; i<powers.size(); i++) {
      //println("power ups:" +powers.size());
      PowerUp pu = powers.get(i);
      for (int j = 0; j<projectiles.size(); j ++) {
        Projectile p = projectiles.get(j);
        if (p.isHitp(pu)) {
          projectiles.remove(p);
          collect.play();
          powers.remove(pu);
          if (pu.type == 'h'){
            ship01.health +=30;
          }
          if (pu.type == 's'){
            pulLength.start();
            if (laserSpeed < 15){
              laserSpeed += 5;
            }
          }
          if (pu.type == 't'){
            putLength.start();
            ship01.turretCount ++;
          }
        }
      }
      if (pu.isHit(ship01)) {
        collect.play();
        powers.remove(pu);
        if (pu.type == 'h'){
          ship01.health +=50;
        }
        if (pu.type == 's'){
          pulLength.start();
          laserSpeed += 5;
        }
        if (pu.type == 't'){
          putLength.start();
          ship01.turretCount ++;
        }
      }
      if (pu.isOffScreen()== true) {
        powers.remove(pu);
      }
      pu.move();
      pu.display();
    }
    //int elapsed = (millis()-timer1.savedTime) / 1000;
    //int timeLeft = timer1.totalTime - elapsed;
    //fill(255);
    //textSize(20);
    //text(timeLeft, 700, 27);
    if (pulLength.isFinished() && laserSpeed >5){
      laserSpeed = 5;
    }
    if (putLength.isFinished() && ship01.turretCount >1){
      //println("e");
      ship01.turretCount --;
    }
    if (timer1.isFinished() == true) {
      enemies.add(new Enemy(int(random(width)), -60, this));
      timer1.start();
      enemyCount++;
    }
    if (puDist.isFinished()) {
      powers.add(new PowerUp(int(random(width)), 20));
      puDist.start();
    }
    infoPanel();
  }
}
void keyPressed() {
  ship01.setControls(key, keyCode, true);
}

void keyReleased() {
  ship01.setControls(key, keyCode, false);
}
