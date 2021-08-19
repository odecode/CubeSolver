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
int layernodeindex;
boolean reachedSearchStage;
ArrayList<Solver.Layer> layers;
Solver.Tree tree;
Move currentMove;

void setup() {
  fullScreen(P3D);
  //size(800, 800, P3D);
  //fullScreen(P3D);
  cam = new PeasyCam(this, 400);
  solver = new Solver();
  reachedSearchStage = false;
  layerindex = 0;
  layernodeindex = 0;
  layers = new ArrayList<Solver.Layer>();
  tree = solver.initializeTree(cube);
}

void drawCube(){
  strokeWeight(1);
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
    int maxdepth = 2;
    if(layerindex == maxdepth){
    reachedSearchStage=true;
    layerindex=99;
    }
    
      if(layerindex==0){
          Solver.Layer l = tree.generateLayer(cube, tree.root);
          sv = solver.sv;
          layers.add(l);
          sv.drawTree();   
      }
      else{
        int index = layers.size()-1;
        Solver.Layer l = tree.generateLayer(layers.get(index), cube);
        layers.add(l); //<>//
        ArrayList<SearchVis.Point> treePoints = sv.drawTree(); //<>//
        for(SearchVis.Point point : treePoints){
          fill(point.pointColor);
          circle(point.x, point.y, point.pointWidth);
        }
      }
   layerindex++;     
 }     

void searchLayers(){
  Solver.Layer layer = layers.get(layerindex);
  boolean solved = false;
  Solver.Node n = layer.nodes.get(layernodeindex);
      
        solved = t.isSolved(n.nodePair.cube);
        if(solved){
          println("solved");
          ArrayList<Solver.Node> solutionNodes = new ArrayList<Solver.Node>();
          while(n.depth > 0){
            //println(n);
            solutionNodes.add(n);
            if(n.parent != null){
            n = n.parent;            
            }
          }
         
          for(int i = solutionNodes.size()-1; i>=0; i--){
            sequence.add(solutionNodes.get(i).nodePair.move);
            println("sequence size: "+sequence.size());
          }
          for(Solver.Node finalNode : layers.get(0).nodes){
            if(finalNode.children.contains(n)){
              sequence.add(0,finalNode.nodePair.move);
            }
          }
          layerindex = layers.size();
        }
        else{
          ArrayList<SearchVis.Point> points = sv.drawCurrentPath(n);
          for(SearchVis.Point p : points){
            //println("for sv.point p in points");
            fill(p.pointColor);
            circle(p.x,p.y,p.pointWidth);
          }
        }
  //println(layernodeindex);     
  layernodeindex++;
  if(layernodeindex == layer.nodes.size()-1){
  layerindex++;
  layernodeindex = 0;
  //println(layerindex);
  }
  if(layerindex == layers.size()){
  println("finishing search");
  solving=false;
  currentMove = sequence.get(0);
  currentMove.start();
  counter = 0;
  }
  
}


void draw() {
  background(51); 
  if(solving){
    scale(0.15);
    //scale(0.003);
    //cam.setDistance(600);
    stroke(219);
    strokeWeight(0.1);
    if(!reachedSearchStage){
      generateLayers();
    }
    else{
      if(layerindex > 90){layerindex=0;}
      searchLayers();
    }   
   }
    else{
    scale(50);
    drawCube();  
  }
}//end draw()
