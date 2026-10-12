class Boss{
  int x,y,w,h,speed,health,lvl;
  PImage boss1;
  //char lvl;
  Boss(int x, int y, int lvl){
    this.x = x;
    this.y = y;
    this.lvl = lvl;
    w= 200;
    h = 200;
    speed = 1;
    health = 100;
//    if (lvl == 1) {
//      boss1 = loadImage("boss.png");
//    }
  }
  void display(){
    fill(255,3,3);
    ellipse(x,y,w,h);
  }
  void move(){
    x = x+speed;
  }
}
