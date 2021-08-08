class Cube{
 Cubelet[] cubelets;
 int dim;
   Cube(int d){
   this.dim = d;
   cubelets = new Cubelet[dim*dim*dim];
     
   int index = 0;
   for (int x = -1; x <= 1; x++) {
    for (int y = -1; y <= 1; y++) {
     for (int z = -1; z <= 1; z++) {
        PMatrix3D matrix = new PMatrix3D();
        matrix.translate(x, y, z);
        cubelets[index] = new Cubelet(matrix, x, y, z);
        index++;
      }
    }
  }
   
   }// end constructor
  
  
  //copy constructor
 Cube(Cube source){
   
   this.dim = source.dim;
   cubelets = new Cubelet[dim*dim*dim];
   for(int i = 0; i < source.cubelets.length; i++){
    this.cubelets[i] = source.cubelets[i].copy(); 
   }
   
   
 }
 
 
// test if 2 Cube instances are in the same state
boolean equals(Cube source){
  boolean equals = true;
  for(int i = 0; i < source.cubelets.length; i++){
    if(source.cubelets[i].x != this.cubelets[i].x || source.cubelets[i].y != this.cubelets[i].y || source.cubelets[i].y != this.cubelets[i].y || source.cubelets[i].y != this.cubelets[i].y){
      equals = false;
    }    
  }
    return equals;
}
  
void applyMoves(Move m){
  
}
 
 
void turnZ(int index, int dir) {
  for (int i = 0; i < cubelets.length; i++) {
    Cubelet qb = cubelets[i];
    if (qb.z == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.x, qb.y);
      qb.update(round(matrix.m02), round(matrix.m12), round(qb.z));
      qb.turnFacesZ(dir);
    }
  }
}

void turnY(int index, int dir) {
  for (int i = 0; i < cubelets.length; i++) {
    Cubelet qb = cubelets[i];
    if (qb.y == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.x, qb.z);
      qb.update(round(matrix.m02), qb.y, round(matrix.m12));
      qb.turnFacesY(dir);
    }
  }
}

void turnX(int index, int dir) {
  for (int i = 0; i < cubelets.length; i++) {
    Cubelet qb = cubelets[i];
    if (qb.x == index) {
      PMatrix2D matrix = new PMatrix2D();
      matrix.rotate(dir*HALF_PI);
      matrix.translate(qb.y, qb.z);
      qb.update(qb.x, round(matrix.m02), round(matrix.m12));
      qb.turnFacesX(dir);
    }
  }
}  


}//end class
