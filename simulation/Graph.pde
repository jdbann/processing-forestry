import java.util.*;

boolean debugGraph = false;
float stepHeight = 0.05;

class Graph {
  World world;
  ArrayList<Node> nodes;
  ArrayList<Edge> edges;
  ArrayList<Path> paths;
  PShape terrain;

  Graph(World initWorld) {
    world = initWorld;
    nodes = new ArrayList<Node>();
    edges = new ArrayList<Edge>();
    paths = new ArrayList<Path>();
    generateNodes();
    generateEdges();
    bakeTerrain();
  }
  
  void bakeTerrain() {
    terrain = createShape(GROUP);
    for(Node node : nodes) {
      terrain.addChild(node.nodeShape());
      for (PShape sideShape : node.neighbourSides()) {
        terrain.addChild(sideShape);
      }
    }
  }

  void generateNodes() {
    for (int x = 0; x < world.w; x++) {
      for (int y = 0; y < world.h; y++) {
        WorldEntity occupant = null;
        for (WorldEntity entity : world.entities) {
          if (entity instanceof Person) { 
            continue;
          }
          if (entity.x != x || entity.y != y) { 
            continue;
          }
          occupant = entity;
        }
        nodes.add(new Node(this, x, y, occupant));
      }
    }
  }

  void generateEdges() {
    for (Node node : nodes) {
      if (!node.traversable) { continue; }
      Node rightNode = null;
      Node bottomNode = null;
      for (Node rNode : nodes) {
        if (!rNode.traversable) { continue; }
        if (rNode.x == node.x + 1 && rNode.y == node.y) {
          if (abs(rNode.h - node.h) < stepHeight) {
            rightNode = rNode;
          }
        }
        if (rNode.x == node.x && rNode.y == node.y + 1) {
          if (abs(rNode.h - node.h) < stepHeight) {
            bottomNode = rNode;
          }
        }
        if (rightNode != null && bottomNode != null) {
          break;
        }
      }
      if (rightNode != null) {
        edges.add(new Edge(node, rightNode));
      }
      if (bottomNode != null) { 
        edges.add(new Edge(node, bottomNode));
      }
    }
  }

  void tick() {
    shape(terrain);
    //for (Node node : nodes) {
    //  //if (abs((mouseX - dragX) - node.x * tileSize) < 20 && abs((mouseY - dragY) - node.y * tileSize) < 20) { 
    //  //  for (Edge edge : node.edges()) {
    //  //    edge.tick();
    //  //  }
    //  //}
    //  node.tick();
    //}
    if (debugGraph) {
      for (Edge edge : edges) {
        edge.tick();
      }
    }
  }

  Node findNode(int x, int y) {
    for (Node node : nodes) {
      if (node.x == x && node.y == y) { 
        return node;
      }
    }
    return null;
  }
}

class NodePriority implements Comparable<NodePriority> {
  Node node;
  int priority;

  NodePriority(Node nodeTemp, int priorityTemp) {
    node = nodeTemp;
    priority = priorityTemp;
  }

  public int compareTo(NodePriority n0) {
    return priority - n0.priority;
  }
}
