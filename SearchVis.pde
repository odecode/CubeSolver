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
    int pointWidth = 15;
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
  
  
  void calculateCoordinates(ArrayList<Solver.Node> nodesIn){
    float degree = 0.0;
    ArrayList<Point> pointsToCalc = new ArrayList<Point>();
    for(Solver.Node n : nodesIn){
      Point p = nodeToPoint.get(n);
      p.depth = n.depth;
      pointsToCalc.add(p);
    }
    println(pointsToCalc.size());
    for(Point p : pointsToCalc){
      if(p.depth == 0){
        p.degree = 0.0;
        this.points.add(p);
      }
      else if(p.depth == 1){
      
      int distance = 150;
      //p.degree = degree;
      p.x = distance*cos(degree);
      p.y = distance*sin(degree);
      degree += 30.0;
      p.degree = degree;
      this.points.add(p);
      }
      else if(p.depth > 1){
        int distance = 550;
        Point parent = p.parent; //<>//
        float pdeg = parent.degree;
        p.degree = parent.degree - 60.0 + degree;
        p.x = distance*cos(p.degree)+parent.x;
        p.y = distance*sin(p.degree)+parent.y;
        degree += 30;
        this.points.add(p);
      }
    }
   
  
  }
  
  void addNodes(ArrayList<Solver.Node> nodesIn){
    for(Solver.Node n : nodesIn){
      Point p = new Point(0,0,255,null,n.depth);
      nodeToPoint.put(n,p);
      println(nodeToPoint.get(n));
      pointToNode.put(p,n);
      //println("n->p size "+nodeToPoint.size()+ " p->n size "+pointToNode.size());
      
      nodes.add(n);
    }
    calcPointParents();
    calculateCoordinates(nodesIn);
  }
  
  void calcPointParents(){
    for(Solver.Node n:this.nodes){
      //println(nodeToPoint.containsKey(n));
      if(n.depth > 0){
        Solver.Node nodeparent = n.parent;
        println(nodeToPoint.containsKey(nodeparent));
        Point nodepoint = nodeToPoint.get(n);
        Point nodepointsparent = nodeToPoint.get(nodeparent);
        nodepoint.parent = nodepointsparent;
      }
    } //<>//
  }
  
  ArrayList<Point> drawTree(){
    ArrayList<Point> p = this.points; //<>// //<>//
    println("drawing tree");
    return this.points;
    // dist 500, width 50, middle (0,0)
     //<>//
        //<>//
  }// end drawTree
  
  ArrayList<Point> drawCurrentPath(Solver.Node currentNode){
    for(Point p:this.points){p.pointColor=255; p.pointWidth=15;} //<>//
    ArrayList<Point> path = new ArrayList<Point>();
    while(currentNode.depth > 0){
      Point cur = nodeToPoint.get(currentNode);
      cur.pointColor=(0);
      cur.pointWidth=50;
      path.add(cur);
      currentNode = currentNode.parent;
    }
    
    
    return path;
  
  }
}
