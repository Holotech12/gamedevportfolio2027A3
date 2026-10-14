import gifAnimation.*;
class Projectile{
  int x, y, speed, type, angle;
  Gif plasma, eplasma;
  Projectile(int x, int y, PApplet parent, int speed, int type){
    this.x = x;
    this.y = y;
    this.speed = speed;
    if (type == 1){
      plasma = new Gif(parent, "projectile.gif");
      //angle = 0;
    } else{
      plasma = new Gif(parent, "eprojectile.gif");
      //angle = 180;
    }
    plasma.loop();
//    plasma = loadImage("projectile.png");
  }
  void display(){
    imageMode(CENTER);
    //pushMatrix(); // saves current coords
    //translate(x, y); // move origin to center
    //rotate(radians(angle));
    //rotate(radians(angle));
    image(plasma,x,y);
//    popMatrix();
  }
  void move(){
    y-=speed;
  }
  void emove() {
     y = y+speed;
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
  boolean isHitpr(Projectile t){
    float d = dist(x,y, t.x,t.y);
    if(d<30){
      return true;
    }else{return false;}
  }
}
