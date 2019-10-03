float hScale = 100;

class Node {
  Graph graph;
  private ArrayList<Edge> edges;
  private ArrayList<Node> neighbours;
  private ArrayList<Node> traversableNeighbours;
  int x, y;
  float h;
  boolean traversable;
  WorldEntity occupant;

  Node(Graph tempGraph, int initX, int initY, WorldEntity tempOccupant) {
    graph = tempGraph;
    x = initX;
    y = initY;
    setOccupant(tempOccupant);

    noiseSeed(graph.world.seed);
    h = noise(x / graph.world.scale, y / graph.world.scale);
  }
  
  void setOccupant(WorldEntity newOccupant) {
    occupant = newOccupant;
    traversable = occupant != null ? occupant.traversable : true;
  }

  void tick() {
    fill(#667761);
    beginShape();
    vertex(x * tileSize + 0 * tileSize / 2, y * tileSize + 0 * tileSize / 2, h * hScale);
    vertex(x * tileSize + 2 * tileSize / 2, y * tileSize + 0 * tileSize / 2, h * hScale);
    vertex(x * tileSize + 2 * tileSize / 2, y * tileSize + 2 * tileSize / 2, h * hScale);
    vertex(x * tileSize + 0 * tileSize / 2, y * tileSize + 2 * tileSize / 2, h * hScale);
    endShape();
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
  
  ArrayList<Node> traversableNeighbours() {
    if (traversableNeighbours == null) {
      traversableNeighbours = new ArrayList<Node>();
      for(Node neighbour : neighbours()) {
        if (neighbour.traversable) {
          traversableNeighbours.add(neighbour);
        }
      }
    }
    return traversableNeighbours;
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
