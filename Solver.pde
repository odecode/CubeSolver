import java.util.Collections;
import java.util.Arrays;
import java.util.List;

class Solver{
  int nodeNums;
  int movesTested;
  boolean solved;
  Test test = new Test();
  Move[] allowedMoves;
  List<Move> allMovesList;
  ArrayList<Move> solution;
  SearchVis sv;
  Tree tree;
  boolean n = false;
  
  
  Solver(){
  this.tree = initializeTree(cube);
  this.solved = false;
  this.nodeNums = 0;
  this.movesTested = 0;
  this.solution = new ArrayList<Move>();
  this.sv = new SearchVis(this);
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
 
 
 
 /*
 Nodes in Tree. Each node represents a Cube instance,
 stored as a Pair, to preserve which Move lead to current Cube instance.
 Also stores depth if node in tree, and a list of children.
 
 */
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
   
  }// end class Node
   
   
 class Tree{
   Node root;
   int maxdepth;
   Tree(Pair p, int mdpt){
     this.root = new Node(null, p, 0);
     this.maxdepth = mdpt;
   }
   
   
    ArrayList<Node> getChildren(Node parent){
     return parent.children;
   }
 
 
   /*
   Generate Tree data structure of Cube instances.
   Procedure: Take in Node, create new list of children,
   create one new Cube for each possible move, apply move,
   append to children list, for each child create recursively
   new children. Repeat until maximum depth (amount of moves)
   is reached.   
   */
   ArrayList<Node> generateChildren(Node parent, Cube origCube){
     //println(nodeNums);
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
        if(child.depth < this.maxdepth){
          n = !n;
          sv.drawTree(this,n); 
          child.children = generateChildren(child, maxdepth, origCube);
        }
      }
     return children;
 
   }
   
  
   /* Traverses tree to search for solved Cube instance.
   Procedure: Take in (parent) node, get its children, for each child:
   if child is solved Cube instance, return path of moves that lead to it,
   else traverse recursively down the children of child. If child has no children
   and is not solved, remove one Move from potential solution and return to parent.
   
   */
   ArrayList<Move> traverse(Node node,ArrayList<Move> sltn){
     movesTested++;
     //println("entered recursive function");
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
           //println("traversing deeper");
           sltn = traverse(child,sltn);
         }
       }
     }
       if(children == null && solved == false){
         println("no more children, still not solved");
         node.parent.children.remove(node);
       }
       else if(solved == true){println("returning with solution");return sltn;}
       
       //println("going back up");
       int index = sltn.size()-1;
       sltn.remove(index);
       return sltn;
 
     }
   
   Tree getTree(){
     return this;
   }
 }// end class Tree
 
 ArrayList<Move> solveBruteForce(Cube cube){
   this.solution = new ArrayList<Move>();
    //<>//
   //print(tree.root);
   
   nodeNums = 0;
   movesTested = 0;
   tree.root.children = tree.generateChildren(tree.root, cube);
   //this.solution = tree.traverse(tree.root, this.solution);
   
    tree.traverse(tree.root, this.solution);
    println("Generated "+nodeNums+" cube instances");
    println("Tested "+movesTested+" moves");
   return solution;
 }
 
 // Creates root node of Tree data structure
 Tree initializeTree(Cube cube){
   Pair rootpair = new Pair(cube,null);
   //P = (origCube, move[null])
   //Node root = 
   Tree t = new Tree(rootpair,4);
   return t;  
 }
 
 
}//end class Solver
