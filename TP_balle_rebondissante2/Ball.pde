class Ball {
  PVector position;
  PVector velocity;

  float radius, m;
  float restitutionCoef;
  Ball(float x, float y, float r_,float coef) {
    position = new PVector(x, y);
    velocity = PVector.random2D();
    velocity.mult(50);
    radius = r_;
    m = radius*.1;
    restitutionCoef=coef;
  }

  void update() {
    position.x+=velocity.x*dT +velocity.x*d/m;
    position.y+=velocity.y*dT +velocity.y*d/m;

  }

  void checkBoundaryCollision() {
    if (position.x > width-radius) {
      position.x = width-radius;
      velocity.x *= -1;
      velocity.x*=restitutionCoef;
            velocity.y*=restitutionCoef;

    } else if (position.x < radius) {
      position.x = radius;
      velocity.x *= -1;
       velocity.x*=restitutionCoef;
            velocity.y*=restitutionCoef;
    } else if (position.y > height-radius) {
      position.y = height-radius;
      velocity.y *= -1;
       velocity.x*=restitutionCoef;
       velocity.y*=restitutionCoef;
    } else if (position.y < radius) {
      position.y = radius;
      velocity.y *= -1;
       velocity.x*=restitutionCoef;
            velocity.y*=restitutionCoef;
    }
  }

  void display() {
    noStroke();
    fill(204);
    ellipse(position.x, position.y, radius*2, radius*2);
    noFill();
strokeWeight(4);
stroke(255,0,0);
    line(position.x,position.y,position.x+velocity.x,position.y+velocity.y);
  }
}
