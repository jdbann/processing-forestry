class WorldEntity {
  World world;
  int x, y;
  Node currentNode;
  
  WorldEntity(World initWorld) {
    world = initWorld;
    while (true) {
      x = int(random(world.w));
      y = int(random(world.h));
      if (world.graph.findNode(x, y).occupant == null) {
        break;
      }
    }
  }
  
  void tick() {
  }
}
