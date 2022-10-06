/*Ball[] balls =  { 
  new Ball(100, 400, 20), 
  new Ball(700, 400, 80) 
};*/

int nbBall=1;
float masse=10.f;
float gravity=9.81;
float dT=0.15f;
PVector a=new PVector(0,9.81);
final float h=4;//rayon de recherche


int ID_baseBall=0;
int ID_tennisBall=1;
int ID_BasketBall=2;

int currentId=0;

int rectBaseX=1500,rectBaseY=50;
int rectBasketX=1500,rectBasketY=350;
int rectTennisX=1500,rectTennisY=200;

int rectSizeX=100,rectSizeY=40;
boolean rectTennisOver,rectBasketOver,rectPingOver;

ArrayList<Ball> balls= new ArrayList<Ball>();
float [] params=new float [9];
void setup() {
  size(1600, 1000);
 
   
   params[0]=0.5; // masse KG ou G de ping
   params[1]=1.f; // frottement de ping
   params[2]=0.5f; // coef restitution

   params[3]=1.f;
   params[4]=1.f;
   params[5]=0.75f;

   params[6]=5.f;
   params[7]=1.f;
   params[8]=0.85f;

    balls.add(new Ball(int(500), int(0), 5,params[2]));
   balls.add(new Ball(int(500), int(0), 10,params[5]));
   balls.add(new Ball(int(500), int(0), 20,params[8]));
}

void draw() {

  background(51);
  textSize(30);
  if(rectTennisOver)
    currentId=ID_tennisBall;
  if(rectPingOver)
    currentId=ID_baseBall;
    if(rectBasketOver)
    currentId=ID_BasketBall;
    stroke(255);
    fill(255);
    rect(rectTennisX, rectTennisY, rectSizeX, rectSizeY);
    rect(rectBaseX, rectBaseY, rectSizeX, rectSizeY);
    rect(rectBasketX, rectBasketY, rectSizeX, rectSizeY);

    fill(0);
      textSize(20);

    text("Tennis",rectTennisX+rectSizeY*0.3,rectTennisY+rectSizeY*0.6);
    text("Basket",rectBasketX+rectSizeY*0.3,rectBasketY+rectSizeY*0.6);
    text("baseBall",rectBaseX+rectSizeY*0.3,rectBaseY+rectSizeY*0.6);

    fill(255);

    text("Gravity: "+gravity,30,60);
    text("Coef de restitution: "+params[currentId*3+2],30,90);
    text("Masse: "+params[currentId*3],30,120);
    text("Frottement: "+params[currentId*3+1],30,150);

    
    a.y+=gravity;
    balls.get(currentId).velocity.y+=a.y*dT;
    balls.get(currentId).velocity.x+=a.x*dT;

    balls.get(currentId).update();
    balls.get(currentId).display();
    balls.get(currentId).checkBoundaryCollision();
        a=new PVector(0,0,0);

  
   
 

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
   if(overRect(rectBaseX, rectBaseY, rectSizeX, rectSizeY) ){
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
      dist.x/=params[currentId*3];
      dist.y/=params[currentId*3];
      a.x+=dist.x;
      a.y+=dist.y;


  
}
