import java.util.Collections;
import java.util.Arrays;
import java.util.List;

class Solver{
  Cube cube;
  Test test = new Test();
  Move[] allowedMoves;
  List<Move> allMovesList;
  ArrayList<Move> solution;
  
  Solver(Cube c, Move[] m){
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
  


}//end class
