/*Ball[] balls =  { 
  new Ball(100, 400, 20), 
  new Ball(700, 400, 80) 
};*/

int nbBall=1;
float coefRestitution=0.9f;

final float h=4;//rayon de recherche
MetricTree mt = new MetricTree();


ArrayList<Ball> balls= new ArrayList<Ball>();

void setup() {
  size(1600, 1000);
  for(int i=0;i<nbBall;i++){
   balls.add(new Ball(int(500), int(0), 20));

}
}

void draw() {
   mt = new MetricTree();
  for(int i=0;i<nbBall;i++){
    mt.insert(i,width);
  }
  
  background(51);

  for (Ball b : balls) {
    b.velocity.y+=0.90;
    b.update();
    b.display();
    b.checkBoundaryCollision();
  }
  
   
 
  
}
