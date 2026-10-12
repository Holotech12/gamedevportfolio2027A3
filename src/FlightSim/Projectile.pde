import gifAnimation.*;
class Projectile{
  int x, y, speed, type;
  Gif plasma, eplasma;
  Projectile(int x, int y, PApplet parent, int speed, int type){
    this.x = x;
    this.y = y;
    this.speed = speed;
    if (type == 1){
      plasma = new Gif(parent, "projectile.gif");
    } else{
      plasma = new Gif(parent, "eprojectile.gif");
    }
    plasma.loop();
//    plasma = loadImage("projectile.png");
  }
  void display(){
    imageMode(CENTER);
    image(plasma,x,y);
  }
  void move(){
    y-=speed;
  }
  boolean isOffScreen(){
    if (y>height+50){
      return true;
    } else{
      return false;
    }
  }
  boolean isHit(Enemy r){
    float d = dist(x,y, r.x,r.y);
    if(d<30){
      return true;
    }else{ return false;}
  }
  boolean isHitp(PowerUp pu){
    float d = dist(x,y, pu.x,pu.y);
    if(d<30){
      return true;
    }else{ return false;}
  }
}
