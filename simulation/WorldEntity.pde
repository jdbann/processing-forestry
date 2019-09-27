class WorldEntity {
  World world;
  int x, y;
  Node currentNode;
  
  WorldEntity(World initWorld) {
    world = initWorld;
    while (true) {
      x = int(random(world.w));
      y = int(random(world.h));
      currentNode = world.graph.findNode(x, y);
      if (currentNode.occupant == null) {
        currentNode.occupant = this;
        break;
      }
    }
  }
  
  void tick() {
  }
}
