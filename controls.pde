void keyPressed() {
  if (key == ' ') {
    //sequence.clear();
    scramb = true;
    sequence = cont.scramble(20); //<>//
    currentMove = sequence.get(0);
    //println(currentMove);
    currentMove.start();
    counter = 0;
    boolean solved = t.isSolved(cube);
    print(solved);
   //t.printmatrix(cube);
  }
  
  else if(key == 'r'){
  scramb = false;
  sequence = cont.unscramble();
  
  currentMove = sequence.get(0);
  currentMove.start();
  counter = 0;
  boolean solved = t.isSolved(cube);
  print(solved);
  //t.printmatrix(cube);
  }
  
  else if(key == 's'){
    solver.solveBFS();
  }
  // applyMove(key);
}
