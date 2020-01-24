class Challenge {
  World world;
  EventStream stream;

  Challenge() {
    world = new World(int(random(256*256)));

    world.addTrees(treeCount);
    world.addLogs(logCount);

    world.addPerson();
    world.addPerson();
    world.addPerson();

    stream = new EventStream(this);
  }

  void tick() {
    world.tick();
  }

  boolean isComplete() {
    return false;
  }
}
