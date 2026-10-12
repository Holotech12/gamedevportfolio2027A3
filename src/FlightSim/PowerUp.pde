class PowerUp {
  //member vars
  int x, y, size, speed;
  boolean isHit;
  char type;
  PImage green;
  // constructor
  PowerUp(int x, int y) {
    this.x = x;
    this.y = y;
    size = int(random(20, 100));
    speed = int(random(1,4));
    isHit = false;
    if (random(3)> 2.0) {
      type = 'h';
      green = loadImage("healthup.png");
    } else if (random(2)>1.0){
      type = 't';
      green = loadImage("turretpu.png");
    } else{
      type = 's';
      green = loadImage("speedpu.png");
    }
    
  }
  //member methods
  void display() {
    imageMode(CENTER);
    image(green,x,y);
    //fill(100,100,255);
    //ellipse(x, y, size, size);
    //textAlign(CENTER,CENTER);
    //fill(255);
    //textSize(20);
    //text(type,x,y);
  }
  void move() {
    y = y+speed;
  }
  boolean isOffScreen(){
    if (y>height+size/2){
      return true;
    } else{
      return false;
    }
  }
  boolean isHit(Ship s){
    float d = dist(x,y, s.x,s.y);
    if(d<100){
      return true;
    }else{ return false;}
  }
}
