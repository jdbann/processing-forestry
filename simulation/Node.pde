class Node {
  Graph graph;
  private ArrayList<Edge> edges;
  private ArrayList<Node> neighbours;
  int x, y;
  float h;

  Node(Graph tempGraph, int initX, int initY) {
    graph = tempGraph;
    x = initX;
    y = initY;

    noiseSeed(graph.world.seed);
    h = noise(x / graph.world.scale, y / graph.world.scale);
  }

  void tick() {
    fill(h * 255);
    rect(x * tileSize, y * tileSize, tileSize, tileSize);
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
