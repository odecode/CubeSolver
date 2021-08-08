import java.util.Collections;
import java.util.Arrays;
import java.util.List;

class Solver{
  int nodeNums;
  int movesTested;
  boolean solved;
  Cube cube;
  Test test = new Test();
  Move[] allowedMoves;
  List<Move> allMovesList;
  ArrayList<Move> solution;
  
  Solver(Cube c, Move[] m){
  this.solved = false;
  this.nodeNums = 0;
  this.movesTested = 0;
  this.cube = c;
  this.allowedMoves = m;
  this.solution = new ArrayList<Move>();
  this.allMovesList = Arrays.asList(allowedMoves);
  
  }
 
  ArrayList<Move> getSolution(){
   return solution; 
  }
  
  Cube saveState(Cube stateToSave){
   Cube savedCube = new Cube(stateToSave);
   return savedCube;
  }
  
 class Pair{
   Cube cube;
   Move move;
   Pair(Cube c, Move m){
     this.cube = c;
     this.move = m;
   }
 }
 
 
 class Node{
     Pair nodePair;
     int depth;
     ArrayList<Node> children;
     Node parent;
     Node(Node par, Pair inpair, int indepth){
       this.depth = indepth;
       this.parent = par;
       this.children = new ArrayList<Node>();
       this.nodePair = inpair;
     }
   
   ArrayList<Node> getChildren(){
     return this.children;
   }
   
   }
   
   
 class Tree{
   Node root;
   Tree(Pair p){
     this.root = new Node(null, p, 0);
   }
   
   
    ArrayList<Node> getChildren(Node parent){
     return parent.children;
   }
 
   ArrayList<Node> generateChildren(Node parent, int maxdepth, Cube origCube){
     println(nodeNums);
     ArrayList<Node> children = new ArrayList<Node>();
     for(Move childMove : allMoves){
      Cube parentCube = parent.nodePair.cube;
      Cube childCube = new Cube(parentCube);
      childMove.start();
      childMove.updateNoAnimation(childCube);
      boolean cubesEqual = childCube.equals(origCube);
      boolean movesOpposite = false;
      if(parent != null && parent.nodePair.move!=null){movesOpposite = childMove.opposite(parent.nodePair.move);}
      
      if(cubesEqual==false && movesOpposite==false){
      Pair childNodePair = new Pair(childCube,childMove);
     Node newnode = new Node(parent, childNodePair, parent.depth+1);
      children.add(newnode);  
      }
    }// end for
    nodeNums+=children.size();
     for(Node child:children){
        if(child.depth < maxdepth){
        child.children = generateChildren(child, maxdepth, origCube);
        }
      }
     return children;
 
   }
   
  
   
   ArrayList<Move> traverse(Node node,ArrayList<Move> sltn){
     movesTested++;
     println("entered recursive function");
     ArrayList<Node> children = node.getChildren();
     if(children != null && solved == false){
       for(Node child:children){
         if(solved == true){return sltn;}
         sltn.add(child.nodePair.move);
         if(test.isSolved(child.nodePair.cube)){
           println("found solved instance");
           solved = true;
           return sltn;
         }
         else if(solved==false){
           println("traversing deeper");
           sltn = traverse(child,sltn);
         }
       }
     }
       if(children == null && solved == false){
         println("no more children, still not solved");
         node.parent.children.remove(node);
       }
       else if(solved == true){println("returning with solution");return sltn;}
       
       println("going back up");
       int index = sltn.size()-1;
       sltn.remove(index);
       return sltn;
     
    
     //return sltn;
     }
   
   
 }// end class Tree
 
 ArrayList<Move> solveBFS(){
   
   Tree tree = generateTree();
   print(tree.root);
   nodeNums = 0;
   movesTested = 0;
   tree.root.children = tree.generateChildren(tree.root,4, this.cube);
   //this.solution = tree.traverse(tree.root, this.solution);
    tree.traverse(tree.root, this.solution);
    println("Generated "+nodeNums+" cube instances");
    println("Tested "+movesTested+" moves");
   return solution;
 }
 
 
 Tree generateTree(){
   Pair rootpair = new Pair(cube,null);
   //P = (origCube, move[null])
   //Node root = 
   Tree t = new Tree(rootpair);
   return t;  
 }
 
 void printtree(){
   Tree tree = generateTree();
   print(tree.root);
   tree.root.children = tree.generateChildren(tree.root,4,this.cube);
   print(tree.root.depth);
   //tree.root.printChildren();

 
 }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 ArrayList<Cube> generateLayer(Cube c){
   ArrayList<Cube> cubeList = new ArrayList<Cube>();
   cubeList.add(c);
   for(Move m : allowedMoves){
     Cube newCube = new Cube(c);
     m.updateNoAnimation(newCube);
     cubeList.add(newCube);
   }
   return cubeList;
 
 }
  
 //graph of cube states
 ArrayList<ArrayList<Cube>> generateGraph(Cube originalCube){
   ArrayList<ArrayList<Cube>> cubeGraph = new ArrayList<ArrayList<Cube>>();
   ArrayList<Cube> firstLayer = new ArrayList<Cube>();
   firstLayer.add(originalCube);
   cubeGraph.add(firstLayer);
   int depth = 0;
   while(depth < 6){
       ArrayList<Cube> current = cubeGraph.get(cubeGraph.size()-1);
       Cube c = new Cube(current.get(0));
       ArrayList<Cube> layer = generateLayer(c);
       cubeGraph.add(layer);
       for(int i = 1; i < layer.size(); i++){
         Cube cubeNext = layer.get(i);
         ArrayList<Cube> nextLayer = generateLayer(cubeNext);
         cubeGraph.add(nextLayer);
       }
     depth++;
   }
   
   return cubeGraph;
 }
 
 
 void solveDFS(){
   ArrayList<ArrayList<Cube>> cubeGraph = generateGraph(cube);
   ArrayList<Move> solution = new ArrayList<Move>();
   boolean solved = false; 
   int moveIndex = 0;
   while(!solved){
    for(int i = 0; i < cubeGraph.size(); i++){
      ArrayList<Cube> current = cubeGraph.get(i);
      Cube c = current.get(0);
      Move m = allMoves[moveIndex];
      solution.add(m);
      
    } 
   }
 }
 
 
 
   
   
 
   
   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 /* static <E> void permK(List<E> p, int i, int k)
{
  if(i == k)
  {
    System.out.println(p.subList(0, k));
    return;
  }

  for(int j=i; j<p.size(); j++)
  {
    Collections.swap(p, i, j);
    permK(p, i+1, k);    
    Collections.swap(p, i, j);
  }
}
*/
 /* 
  void kpermutations(List<Move> list, int i, int k){
    if(i == k){
        list = list.subList(0, k);
        //return n;
    }
    
    for(int j=i; j<list.size(); j++){
      Collections.swap(list, i, j);
      kpermutations(list, i+1, k);
      Collections.swap(list, i, j);
      //return f;
    }
    
    
  }//end kpermutations()
  */
  /*
  void solveBFS(){
    
     // Cube originalCube = saveState(cube);
      for(int i = 0; i <= 5; i++){
          kpermutations(allMovesList, 0, i);
          for(int n = 0; n < allMovesList.size(); n++){
            print(allMovesList.get(n).x+" "+allMovesList.get(n).y+" "+allMovesList.get(n).z+" "+allMovesList.get(n).dir);
            println("");
          }
      }
  
  }
  */
  


}//end class
