/*Ball[] balls =  { 
  new Ball(100, 400, 20), 
  new Ball(700, 400, 80) 
};*/

int nbBall=1;
float coefRestitution=0.9f;
float masse=10.f;
float gravity=9.81;
float dT=0.1f;
final float h=4;//rayon de recherche
MetricTree mt = new MetricTree();


int ID_pingPongBall=0;
int ID_tennisBall=1;
int ID_BasketBall=2;

int currentId=0;

int rectPingX=1500,rectPingY=50;
int rectBasketX=1500,rectBasketY=350;
int rectTennisX=1500,rectTennisY=200;

int rectSizeX=100,rectSizeY=40;
boolean rectTennisOver,rectBasketOver,rectPingOver;

ArrayList<Ball> balls= new ArrayList<Ball>();
float [] params=new float [6];
void setup() {
  size(1600, 1000);
   balls.add(new Ball(int(500), int(0), 5));
   balls.add(new Ball(int(500), int(0), 10));
   balls.add(new Ball(int(500), int(0), 20));
   
   params[0]=0.5; // masse KG ou G de ping
   params[1]=1.f; // frottement de ping
   params[2]=1.f;
   params[3]=1.f;
   params[4]=5.f;
   params[5]=1.f;


}

void draw() {
   mt = new MetricTree();
  for(int i=0;i<nbBall;i++){
    mt.insert(i,width);
  }
  background(51);
  textSize(30);
  if(rectTennisOver)
    currentId=ID_tennisBall;
  if(rectPingOver)
    currentId=ID_pingPongBall;
    if(rectBasketOver)
    currentId=ID_BasketBall;
    stroke(255);
    fill(255);
    rect(rectTennisX, rectTennisY, rectSizeX, rectSizeY);
    rect(rectPingX, rectPingY, rectSizeX, rectSizeY);
    rect(rectBasketX, rectBasketY, rectSizeX, rectSizeY);

    fill(0);
    text("Tennis",rectTennisX+rectSizeY*0.4,rectTennisY+rectSizeY*0.6);
    text("Basket",rectBasketX+rectSizeY*0.4,rectBasketY+rectSizeY*0.6);
    text("Ping",rectPingX+rectSizeY*0.4,rectPingY+rectSizeY*0.6);

    fill(255);

    text("Gravity: "+gravity,30,60);
    text("Coef de restitution: "+coefRestitution,30,90);
    text("Masse: "+params[currentId*2],30,120);
    text("Frottement: "+params[currentId*2+1],30,150);

    balls.get(currentId).velocity.y+=gravity*dT;
    balls.get(currentId).update();
    balls.get(currentId).display();
    balls.get(currentId).checkBoundaryCollision();
  
  
   
 
  
}
boolean overRect(int x, int y, int w, int h)  {
  if (mouseX >= x && mouseX <= x+w && 
      mouseY >= y && mouseY <= y+h) {
    return true;
  } else {
    return false;
  }
}

void mousePressed(){
  if(overRect(rectTennisX, rectTennisY, rectSizeX, rectSizeY) ){
    rectTennisOver=true;
    rectBasketOver=false;
    rectPingOver=false;
  }
   if(overRect(rectPingX, rectPingY, rectSizeX, rectSizeY) ){
    rectTennisOver=false;
    rectBasketOver=false;
    rectPingOver=true;
  }
   if(overRect(rectBasketX, rectBasketY, rectSizeX, rectSizeY) ){
    rectTennisOver=false;
    rectBasketOver=true;
    rectPingOver=false;
  }
    
      PVector dist=new PVector(mouseX-balls.get(currentId).position.x,mouseY-balls.get(currentId).position.y);
      dist.x/=params[currentId*2];
      dist.y/=params[currentId*2];
      balls.get(currentId).velocity.x+=dist.x;
      balls.get(currentId).velocity.y+=dist.y;

      balls.get(currentId).velocity.x*=dT;
      balls.get(currentId).velocity.y*=dT;

  
}
