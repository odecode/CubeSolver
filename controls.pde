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
    //solver.solveBFS();
  }
  // applyMove(key);
  
  else if(key == 'p'){
    solving = !solving;
    solver = new Solver();
    sequence.clear(); //<>//
    
  }
  
  else if(key == '2'){
  scramb = true;
    sequence = cont.scramble(2);
    currentMove = sequence.get(0);
    //println(currentMove);
    currentMove.start();
    counter = 0;
    boolean solved = t.isSolved(cube);
    print(solved);
  }
  
  else if(key == '3'){
  scramb = true;
    sequence = cont.scramble(3);
    currentMove = sequence.get(0);
    //println(currentMove);
    currentMove.start();
    counter = 0;
    boolean solved = t.isSolved(cube);
    print(solved);
  }
  
  else if(key == '4'){
  scramb = true;
    sequence = cont.scramble(4);
    currentMove = sequence.get(0);
    //println(currentMove);
    currentMove.start();
    counter = 0;
    boolean solved = t.isSolved(cube);
    print(solved);
  }
  
  else if(key == '5'){
  scramb = true;
    sequence = cont.scramble(5);
    currentMove = sequence.get(0);
    //println(currentMove);
    currentMove.start();
    counter = 0;
    boolean solved = t.isSolved(cube);
    print(solved);
  }
  
    else if(key == '6'){
  scramb = true;
    sequence = cont.scramble(6);
    currentMove = sequence.get(0);
    //println(currentMove);
    currentMove.start();
    counter = 0;
    boolean solved = t.isSolved(cube);
    print(solved);
  }
  else if(key == 'x'){
    Solver.Tree t = solver.initializeTree(cube);
    t.generateChildren(t.root,cube);
    ArrayList<Solver.Node> leaves = new ArrayList<Solver.Node>();
    leaves = t.getLeaves(t.root,leaves);
    for(Solver.Node n : leaves){
     println(n.leaf); 
    }
    println(leaves.size());
  }
  

}
