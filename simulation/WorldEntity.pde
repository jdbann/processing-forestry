class WorldEntity {
  World world;
  int x, y;
  Node currentNode;
  
  WorldEntity(World initWorld) {
    world = initWorld;
    while (true) {
      x = int(random(world.w));
      y = int(random(world.h));
      Node node = world.graph.findNode(x, y);
      if (node.occupant == null) {
        node.occupant = this;
        currentNode = node;
        break;
      }
    }
  }
  
  void tick() {
  }
}
