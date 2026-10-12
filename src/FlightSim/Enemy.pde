import gifAnimation.*;
class Enemy {
  //member vars
  int x, y, w, h, health, exp, speed;
  boolean isHit, isExploding, isDead;
  PImage tob;
  Gif blowup;
  // constructor
  Enemy(int x, int y, PApplet parent) {
    this.x = x;
    this.y = y;
    speed = int(random(4,7));
    w = int(random(50, 150));
    h = int(random(50, 150));
    health = 100;
    exp = int(random(10-15));
    tob = loadImage("toby.png");
    blowup = new Gif(parent, "toby.gif");
    isHit = false;
    isExploding = false;
    isDead = false;
  }
  //member methods
  void display() {
    imageMode(CENTER);
    //blowup.resize(w,h);
    //tob.resize(w,h);
    if (isHit == true && isExploding == false) {
      blowup.stop();
      blowup.play();
      isHit = false;
      isExploding = true;
    }
    //} else {
    //  blowup.pause();
    if (isExploding) {
      image(blowup, x, y, w, h); // Draw the explosion GIF
      if (blowup.currentFrame() >= blowup.getPImages().length - 1) {
        blowup.stop();
        isExploding = false; 
        isDead = true;
      }
     }
     if (!isExploding && !isDead){
        image(tob, x, y, w, h); 
      //println("e");
      //image(blowup,x,y);
     }
  }
  
  void move() {
    if (isExploding == false){
      y = y+speed;
    }
  }
   boolean isOffScreen(){
    if (y>height+50){
      return true;
    } else{
      return false;
    }
  }
  
}
