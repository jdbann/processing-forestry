class Path {
  Graph graph;
  int sX, sY, dX, dY;
  Node end, start;
  ArrayList<NodePriority> frontier;
  HashMap<Node, Node> cameFrom;

  Path(Graph graphTemp, int sXTemp, int sYTemp, int dXTemp, int dYTemp) {
    graph = graphTemp;
    sX = sXTemp;
    sY = sYTemp;
    dX = dXTemp;
    dY = dYTemp;
    findPath();
  }

  void findPath() {
    frontier = new ArrayList<NodePriority>();
    end = graph.findNode(sX, sY);
    if (end == null) {
      println("DESTINATION CAN'T BE REACHED");
      return;
    }
    frontier.add(new NodePriority(end, 0));

    HashMap<Node, Integer> costSoFar = new HashMap<Node, Integer>();
    cameFrom = new HashMap<Node, Node>();

    cameFrom.put(end, null);
    costSoFar.put(end, 0);

    while (frontier.size() > 0) {
      NodePriority currentNP = frontier.get(0);
      frontier.remove(currentNP);

      Node current = currentNP.node;

      if (current.x == dX && current.y == dY) {
        start = current;
        break;
      }

      for (Node next : current.neighbours()) {
        int newCost = costSoFar.get(current) + 1;
        if (costSoFar.get(next) == null || newCost < costSoFar.get(next)) {
          costSoFar.put(next, newCost);
          int priority = newCost + int(sqrt(sq(next.x - dX) + sq(next.y - dY)));
          frontier.add(new NodePriority(next, priority));
          cameFrom.put(next, current);
        }
      }

      Collections.sort(frontier);
    }
  }
  
  Node nextStep() {
    start = cameFrom.get(start);
    return start;
  }

  void tick() {
    stroke(#FF00FF);
    Node nextNode = start;
    while (nextNode != null) {
      Node fromNode = cameFrom.get(nextNode);
      if (fromNode != null) {
        line(
          fromNode.x * tileSize + tileSize / 2, 
          fromNode.y * tileSize + tileSize / 2, 
          nextNode.x * tileSize + tileSize / 2, 
          nextNode.y * tileSize + tileSize / 2
          );
        nextNode = fromNode;
      } else {
        break;
      }
    }
  }

  int heuristic(Node node) {
    return abs(node.x - dX) + abs(node.y - dY);
  }
}
