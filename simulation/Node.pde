class Node {
  Graph graph;
  private ArrayList<Edge> edges;
  private ArrayList<Node> neighbours;
  int x, y;

  Node(Graph tempGraph, int initX, int initY) {
    graph = tempGraph;
    x = initX;
    y = initY;
  }

  void tick() {
    fill(#0000FF);
    ellipse(x * tileSize + 3, y * tileSize + 3, 2, 2);
  }

  ArrayList<Node> neighbours() {
    if (neighbours == null) {
      neighbours = new ArrayList<Node>();
      for (Edge edge : edges()) {
        if (edge.a == this) { 
          neighbours.add(edge.b);
        }
        if (edge.b == this) { 
          neighbours.add(edge.a);
        }
      }
    }
    return neighbours;
  }

  ArrayList<Edge> edges() {
    if (edges == null) {
      edges = new ArrayList<Edge>();
      for (Edge edge : graph.edges) {
        if (edge.a == this) { 
          edges.add(edge);
        }
        if (edge.b == this) { 
          edges.add(edge);
        }
      }
    }
    return edges;
  }
}
