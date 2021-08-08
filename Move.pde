class Move {
  float angle = 0;
  int x = 0;
  int y = 0;
  int z = 0;
  int dir; //direction clockwise/counterclockwise -1/1
  boolean animating = false;
  boolean finished = false;


  
  Move(int x, int y, int z, int dir) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.dir = dir;
  }
  
  Move copy() {
    return new Move(x, y, z, dir);
  }

  void reverse() {
    //this.dir *= -1;
    if(this.dir == 1) this.dir = -1;
    else this.dir = 1;
  }
  
boolean opposite(Move source){
  boolean opposite = false;
  if(source.x == this.x && source.y == this.y && source.z == this.z && source.dir != this.dir){
    opposite = true;
  }
  return opposite;
}  

  void start() {
    animating = true;
    finished = false;
    this.angle = 0;
  }

  boolean finished() {
    return finished;
  }

  void updateNoAnimation(Cube c){ //<>//
        if (abs(z) > 0) {
          c.turnZ(z, dir);
        } else if (abs(x) > 0) {
          c.turnX(x, dir);
        } else if (abs(y) > 0) {
          c.turnY(y, dir);
        }
    }
  


  void update(Cube c) {
    if (animating) {
      angle += dir * speed;
      if (abs(angle) > HALF_PI) {
        angle = 0;
        animating = false;
        finished = true;
        if (abs(z) > 0) {
          c.turnZ(z, dir);
        } else if (abs(x) > 0) {
          c.turnX(x, dir);
        } else if (abs(y) > 0) {
          c.turnY(y, dir);
        }
      }
    }
  }
}
