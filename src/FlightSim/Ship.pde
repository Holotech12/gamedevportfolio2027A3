import gifAnimation.*;
class Ship {
  //member vars
  int x, y, speed, health, turretCount;
  boolean pressed = false, moveLeft, moveRight, moveUp, moveDown;
//  PImage shipp;
  float angle;
  Gif shipanimate;
  //constructor
  Ship(int x, int y, float tempangle, PApplet parent) {
    this.x = x;
    this.y = y;
    speed = 10;
    angle = tempangle;
    turretCount = 1;
//    shipp = loadImage("plane.png");
    health = 100;
    shipanimate = new Gif(parent, "planeship.gif");
    shipanimate.loop();
  }
  void setControls(char k, int code, boolean state) {
    // Letter keys
    if (k == 'a' || k == 'A' || code == LEFT) moveLeft = state;
    if (k == 'd'|| k == 'D'|| code == RIGHT) moveRight = state;
    if (k == 'w'|| k == 'W'|| code == UP) moveUp = state;
    if (k == 's'|| k == 'S'|| code == DOWN) moveDown = state;
  }

  // update coord
  void updatePosition() {
    if (moveLeft && x >=10) {x -= speed;}// angle = 270;}
    if (moveRight && x <= 790){ x += speed;}// angle = 90;}
    if (moveUp && y>= 10){  y -= speed;}// angle = 0;}
    if (moveDown && y <= 790){  y += speed;}// angle = 180;}
  }

  void display() {
    imageMode(CENTER);
//    pushMatrix(); // saves current coords
//    translate(x, y); // move origin to center
//    rotate(radians(angle));
//    image(shipp,x,y);
    image(shipanimate, x, y);
//    popMatrix();
  }
  boolean isHit(Enemy r){
    float d = dist(x,y, r.x,r.y);
    if(d<100){
      return true;
    }else{ return false;}
  }
  boolean isHits(Projectile h){
    float d = dist(x,y, h.x,h.y);
    if(d<100){
      return true;
    }else{ return false;}
  }
}
