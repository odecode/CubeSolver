class SearchVis{
  Solver solver;
  Solver.Tree svtree;
  ArrayList<Point> points;
  ArrayList<Solver.Node> nodes;
  HashMap<Solver.Node, Point> nodeToPoint;
  HashMap<Point, Solver.Node> pointToNode;
  
  SearchVis(Solver s){
    this.solver = s;
    this.points = new ArrayList<Point>();
    this.nodes = new ArrayList<Solver.Node>();
    nodeToPoint = new HashMap<Solver.Node, Point>();
    pointToNode = new HashMap<Point, Solver.Node>();
    
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
    int depth;
    Point(float xin, float yin, int clr, Point p, int depthIn){
       this.x = xin;
       this.y = yin;
       this.pointColor = clr;
       this.parent = p;
       this.depth = depthIn;
    }
    
  }
  
  
  void calculateCoordinates(Solver.Node node){
    for(Point p : points){
      if(p.parent == null){
        p.degree = 0.0;
      }
      else if(p.depth == 1){
        
      
      }
      
    }
    
    if(node.depth == 0){
      Point p =  new Point(0,0, 255, null,0);
      points.add(p);
    }
    else{
      Point p = new Point(0,0,255, null,node.depth);
      points.add(p);
    }
  
  }
  
  void addNodes(ArrayList<Solver.Node> nodesIn){
    for(Solver.Node n : nodesIn){
      Point p = new Point(0,0,255,null,n.depth);
      nodeToPoint.put(n,p);
      pointToNode.put(p,n);
      nodes.add(n);
    }
  }
  
  void calcPointParents(){
    for(Point current:points){
       Solver.Node pointsNode = pointToNode.get(current);
       pointsNode = pointsNode.parent;
       Point currentsParent = nodeToPoint.get(pointsNode);
       current.parent = currentsParent;
    }
  }
  
  ArrayList<Point> drawTree(){
    
    println("drawing tree");
    return points;
    // dist 500, width 50, middle (0,0)
    
        //<>//
  }// end drawTree
  
  ArrayList<Point> drawCurrentPath(){
    fill(152);
    circle(120,130,50);
    //println("drawing path");
    
    Point p = new Point(0,0,255,null,0);
    ArrayList<Point> pt = new ArrayList<Point>();
    pt.add(p);
    return pt;
  
  }
}
