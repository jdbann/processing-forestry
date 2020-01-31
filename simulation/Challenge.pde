abstract class Challenge {
  World world;
  EventStream stream;

  Challenge() {
    stream = new EventStream(this);
    int seed = int(random(256*256));
    world = new World(seed, stream);

    world.addTrees(treeCount);
    world.addLogs(logCount);

    world.addPerson();
    world.addPerson();
    world.addPerson();
  }

  void tick() {
    world.tick();
  }

  abstract void listen(Event e);

  abstract boolean isComplete();
}
