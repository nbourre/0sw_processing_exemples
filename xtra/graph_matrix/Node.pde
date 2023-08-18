class Node extends Cell {
  // Node neighbours
  ArrayList<Node> neighbours = new ArrayList<Node>();
  
  Node (int _x, int _y) {
   
    super (_x, _y, 50, 50);
  }
}
