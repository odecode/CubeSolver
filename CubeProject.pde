import peasy.*;

PeasyCam cam;

float speed = 0.35;
int dim = 3;
//Cubelet[] cube = new Cubelet[dim*dim*dim];
Cube cube = new Cube(3);
Controller cont = new Controller();
Solver solver;
SearchVis sv;
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
boolean solving = false;
boolean startedAlgorithm = false;
boolean started = false;
int layerindex;
boolean reachedSearchStage;
ArrayList<Solver.Layer> layers = new ArrayList<Solver.Layer>();
Solver.Tree tree = solver.initializeTree(cube);
Move currentMove;

void setup() {
  size(800, 800, P3D);
  //fullScreen(P3D);
  cam = new PeasyCam(this, 400);
  solver = new Solver();
  reachedSearchStage = false;
  layerindex = 0;
}

void drawCube(){
   cam.beginHUD();
  fill(255);
  textSize(32);
  cam.endHUD();

  rotateX(-0.5);
  rotateY(0.4);
  rotateZ(0.1);
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

}

void solvebruteforce(){
  solver.solveBruteForce(cube);
}

void generateLayers(){
    int maxdepth = 4;
    if(layerindex == maxdepth){reachedSearchStage=true;}
    
      if(layerindex==0){
          Solver.Layer l = tree.generateLayer(cube, tree.root);
          layers.add(l);
          sv.drawTree();   
      }
      else{
        int index = layers.size()-1;
        Solver.Layer l = tree.generateLayer(layers.get(index), cube);
        layers.add(l);
        sv.drawTree();
      }
   layerindex++;     
 }     

void searchLayers(){
  boolean solved = false;
    for(Solver.Layer layer : layers){
      if(solved){break;}
      for(Solver.Node n : layer.nodes){
        solved = tree.testCurrentNode(n);
        if(solved){
          ArrayList<Solver.Node> solutionNodes = n.getToRoot(n);
          for(int i = solutionNodes.size()-1; i>0; i--){
            sequence.add(solutionNodes.get(i).nodePair.move);
          }
         solved=true;
         break;
        }
        else{
          sv.drawCurrentPath();
        }
       }
         
    }
  solving=false;
  currentMove = sequence.get(0);
  currentMove.start();
  counter = 0;
}


void draw() {
  background(51); 
  if(solving){
    scale(0.003);
    cam.setDistance(600);
    stroke(219);
    strokeWeight(0.1);
    if(!reachedSearchStage){
      generateLayers();
    }
    else{
      searchLayers();
    }   
   }
    else{
    scale(50);
    drawCube();  
  }
}//end draw()
