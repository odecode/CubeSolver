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
  
  

  void start() {
    animating = true;
    finished = false;
    this.angle = 0;
  }

  boolean finished() {
    return finished;
  }

  void update() {
    if (animating) {
      angle += dir * speed;
      if (abs(angle) > HALF_PI) {
        angle = 0;
        animating = false;
        finished = true;
        if (abs(z) > 0) {
          cube.turnZ(z, dir);
        } else if (abs(x) > 0) {
          cube.turnX(x, dir);
        } else if (abs(y) > 0) {
          cube.turnY(y, dir);
        }
      }
    }
  }
}
