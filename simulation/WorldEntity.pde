class WorldEntity {
  World world;
  int x, y;
  Node currentNode;
  boolean traversable = true;

  WorldEntity(World initWorld) {
    world = initWorld;
    while (true) {
      x = int(random(world.w));
      y = int(random(world.h));
      Node node = world.graph.findNode(x, y);
      if (node.occupant == null) {
        node.setOccupant(this);
        setCurrentNode(node);
        break;
      }
    }
  }

  void setCurrentNode(Node node) {
    currentNode = node;
    x = node.x;
    y = node.y;
  }

  void tick(PGraphics pg) {
  }
}
