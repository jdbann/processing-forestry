class Challenge {
  World world;

  Challenge() {
    world = new World(int(random(256*256)));

    world.addTrees(treeCount);
    world.addLogs(logCount);

    world.addPerson();
    world.addPerson();
    world.addPerson();
  }

  void tick() {
    world.tick();
  }
}
