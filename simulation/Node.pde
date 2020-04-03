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
    h = noise(x / graph.world.scale, y / graph.world.scale) / 8;
  }

  void setOccupant(WorldEntity newOccupant) {
    occupant = newOccupant;
    traversable = occupant != null ? occupant.traversable : true;
  }

  PShape nodeShape() {
    PShape nodeShape = createShape();
    nodeShape.setFill(color(#667761));
    nodeShape.setStroke(false);
    nodeShape.beginShape();
    nodeShape.vertex(x * tileSize + 0 * tileSize / 2, y * tileSize + 0 * tileSize / 2, h * hScale);
    nodeShape.vertex(x * tileSize + 2 * tileSize / 2, y * tileSize + 0 * tileSize / 2, h * hScale);
    nodeShape.vertex(x * tileSize + 2 * tileSize / 2, y * tileSize + 2 * tileSize / 2, h * hScale);
    nodeShape.vertex(x * tileSize + 0 * tileSize / 2, y * tileSize + 2 * tileSize / 2, h * hScale);
    nodeShape.endShape();
    return nodeShape;
  }

  ArrayList<PShape> neighbourSides() {
    ArrayList<PShape> sides = new ArrayList<PShape>();
    for (Node neighbour : neighbours()) {
      PShape sideShape = createShape();
      if (abs(h - neighbour.h) < stepHeight) {
        sideShape.setFill(color(#667761));
      } else {
        sideShape.setFill(color(192));
      }
      sideShape.setStroke(false);
      sideShape.beginShape();
      if (x < neighbour.x) {
        sideShape.vertex(x * tileSize + 2 * tileSize / 2, y * tileSize + 2 * tileSize / 2, h * hScale);
        sideShape.vertex(x * tileSize + 2 * tileSize / 2, y * tileSize + 2 * tileSize / 2, neighbour.h * hScale);
        sideShape.vertex(x * tileSize + 2 * tileSize / 2, y * tileSize + 0 * tileSize / 2, neighbour.h * hScale);
        sideShape.vertex(x * tileSize + 2 * tileSize / 2, y * tileSize + 0 * tileSize / 2, h * hScale);
      }
      if (y < neighbour.y) {
        sideShape.vertex(x * tileSize + 2 * tileSize / 2, y * tileSize + 2 * tileSize / 2, h * hScale);
        sideShape.vertex(x * tileSize + 2 * tileSize / 2, y * tileSize + 2 * tileSize / 2, neighbour.h * hScale);
        sideShape.vertex(x * tileSize + 0 * tileSize / 2, y * tileSize + 2 * tileSize / 2, neighbour.h * hScale);
        sideShape.vertex(x * tileSize + 0 * tileSize / 2, y * tileSize + 2 * tileSize / 2, h * hScale);
      }
      sideShape.endShape();
      sides.add(sideShape);
    }
    return sides;
  }

  void tick() {
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
      Node node;
      node = graph.findNode(x, y + 1);
      if (node != null) { 
        neighbours.add(node);
      }
      node = graph.findNode(x, y - 1);
      if (node != null) { 
        neighbours.add(node);
      }
      node = graph.findNode(x + 1, y);
      if (node != null) { 
        neighbours.add(node);
      }
      node = graph.findNode(x - 1, y);
      if (node != null) { 
        neighbours.add(node);
      }
    }
    return neighbours;
  }

  ArrayList<Node> traversableNeighbours() {
    if (traversableNeighbours == null) {
      traversableNeighbours = new ArrayList<Node>();
      for (Node neighbour : neighbours()) {
        if (neighbour.traversable && abs(h - neighbour.h) < stepHeight) {
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
