import peasy.*;

PeasyCam cam;

float speed = 0.35;
int dim = 3;
//Cubelet[] cube = new Cubelet[dim*dim*dim];
Cube cube = new Cube(3);
Controller cont = new Controller();
Solver solver;

Test t = new Test();
Move[] allMoves = new Move[] {
  new Move(0, 1, 0, 1), 
  new Move(0, 1, 0, -1), 
  new Move(0, -1, 0, 1), 
  new Move(0, -1, 0, -1), 
  new Move(1, 0, 0, 1), 
  new Move(1, 0, 0, -1), 
  new Move(-1, 0, 0, 1), 
  new Move(-1, 0, 0, -1), 
  new Move(0, 0, 1, 1), 
  new Move(0, 0, 1, -1), 
  new Move(0, 0, -1, 1), 
  new Move(0, 0, -1, -1) 
};

ArrayList<Move> sequence = new ArrayList<Move>();
int counter = 0;
boolean scramb = false;

boolean started = false;

Move currentMove;

void setup() {
  size(600, 600, P3D);
  //fullScreen(P3D);
  cam = new PeasyCam(this, 400);
 
  solver = new Solver(cube, allMoves);
}

void draw() {
  background(51); 

  cam.beginHUD();
  fill(255);
  textSize(32);
  if(scramb) text("scrambling", 100, 100);
  else text("unscrambling", 100, 100);
  cam.endHUD();

  rotateX(-0.5);
  rotateY(0.4);
  rotateZ(0.1);

  scale(50);
  if(currentMove != null){
     currentMove.update(cube);
  if (currentMove.finished()) {
    if (counter < sequence.size()-1) {
      counter++;
      currentMove = sequence.get(counter);
      currentMove.start();
    }
  }
  
  
  for (int i = 0; i < cube.cubelets.length; i++) {
    push();
    if (abs(cube.cubelets[i].z) > 0 && cube.cubelets[i].z == currentMove.z) {
      rotateZ(currentMove.angle);
    } else if (abs(cube.cubelets[i].x) > 0 && cube.cubelets[i].x == currentMove.x) {
      rotateX(currentMove.angle);
    } else if (abs(cube.cubelets[i].y) > 0 && cube.cubelets[i].y ==currentMove.y) {
      rotateY(-currentMove.angle);
    }   
    cube.cubelets[i].show();
    pop();
  }
 }
 else{
   for(int i = 0; i < cube.cubelets.length; i++){
     push();
     cube.cubelets[i].show();
     pop();
   }
 }
 
}//end draw()
