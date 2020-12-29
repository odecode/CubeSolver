
class Controller{
  ArrayList<Move> solution;
  ArrayList<Move> scrambleList;
  ArrayList<Move> unScrambleList;
  Cube savedState;
  
  Controller(){
    this.solution = new ArrayList<Move>();
    this.scrambleList = new ArrayList<Move>();
    this.unScrambleList = new ArrayList<Move>();
  }
  
  void iscramble(int numMoves){
    for(int i = 1; i <= numMoves; i++){
      Move m = allMoves[int(random(allMoves.length))];
      sequence.add(m);
      Move n = m.copy();
      }
  }
  void iunscramble(){
    for(Move m : sequence){
     m.reverse();
     
    }
  }
  
  
  
  Cube saveState(Cube stateToSave){
   Cube savedCube = new Cube(stateToSave);
   return savedCube;
   
  }
  
  ArrayList<Move> scramble(int numMoves){
   scrambleList.clear();
   unScrambleList.clear();
    for(int i = 1; i <= numMoves; i++){
      
      Move m = allMoves[int(random(allMoves.length))];
      scrambleList.add(m);
      Move n = m.copy();
      n.reverse();
      unScrambleList.add(0,n);
    }
    return scrambleList;
  }
  
  
  ArrayList<Move> unscramble(){
    return unScrambleList;  //<>//
  }
  
  void solve(){
  
  }

}
