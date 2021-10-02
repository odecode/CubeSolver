
// class to scramble and unscramble cube
// scramble: select random Move n times
// unscramble: just reverse scrambled list
class Controller{
  ArrayList<Move> scrambleList;
  ArrayList<Move> unScrambleList;
  
  Controller(){
    this.scrambleList = new ArrayList<Move>();
    this.unScrambleList = new ArrayList<Move>();
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
    return unScrambleList; 
  }


}
