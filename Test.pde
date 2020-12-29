class Test{
Cube defaultCube;
  
  Test(){
    this.defaultCube = new Cube(cube.dim);
  }

String matrixToString(PMatrix3D m){
  return "[" + nf(m.m00,1,1) + " , " + nf(m.m10,1,1) + " , " + nf(m.m20,1,1) + " , " + nf(m.m30,1,1) + " ,\n" +
          " "+ nf(m.m01,1,1) + " , " + nf(m.m11,1,1) + " , " + nf(m.m21,1,1) + " , " + nf(m.m31,1,1) + " ,\n" +
          " "+ nf(m.m02,1,1) + " , " + nf(m.m12,1,1) + " , " + nf(m.m22,1,1) + " , " + nf(m.m32,1,1) + " ,\n" +
          " "+ nf(m.m03,1,1) + " , " + nf(m.m13,1,1) + " , " + nf(m.m23,1,1) + " , " + nf(m.m33,1,1) + " ]";
}

boolean isSolved(Cube cub){
    boolean b = true;
   for(int i=0; i<cub.cubelets.length;i++){
     if(!(matrixToString(cub.cubelets[i].matrix).equals(matrixToString(defaultCube.cubelets[i].matrix)))){
       b = false;
     }
   }
   return b; 
}// end isSolved()




}
