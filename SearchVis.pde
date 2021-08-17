class SearchVis{
  Solver solver;
  Solver.Tree svtree;
  ArrayList<Point> points;
  ArrayList<Solver.Node> nodes;
  
  SearchVis(Solver s){
    this.solver = s;
    this.points = new ArrayList<Point>();
    this.nodes = new ArrayList<Solver.Node>();
    
  }
  
  class Point{
    Point parent;
    ArrayList<Point> children;
    //x,y = coordinates of middle point of circle
    float x;
    float y;
    float degree;
    int pointWidth = 50;
    int pointColor;
    Point(float xin, float yin, int clr, Point p){
       this.x = xin;
       this.y = yin;
       this.pointColor = clr;
       this.parent = p;
    }
    
  }
  
  
  void calculateCoordinates(Solver.Node node){
    // p.degree = 
    
    if(node.depth == 0){
      Point p =  new Point(0,0, 255, null);
      points.add(p);
    }
    else{
      Point p = new Point(0,0,255, null);
      points.add(p);
    }
  
  }
  
  void addNodes(ArrayList<Solver.Node> nodesIn){
    for(Solver.Node n : nodesIn){
      nodes.add(n);
    }
    
    
  }
  
  void drawTree(){
    for(Point p : points){
      fill(p.pointColor);
      circle(p.x, p.y, 50);
      println("drawing tree");
    }
    
    // dist 500, width 50, middle (0,0)
    
        //<>//
  }// end drawTree
  
  void drawCurrentPath(){
    fill(152);
    circle(120,130,50);
    println("drawing path");
  
  }
}
