class WorldEntity {
  World world;
  int x, y;
  Node currentNode;
  
  WorldEntity(World initWorld) {
    world = initWorld;
    x = int(random(world.w));
    y = int(random(world.h));
  }
  
  void tick() {
  }
}
