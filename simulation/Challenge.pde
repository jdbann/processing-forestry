abstract class Challenge {
  World world;
  EventStream stream;
  boolean complete;

  Challenge() {
    stream = new EventStream(this);
    int seed = int(random(256*256));
    world = new World(seed, stream);
    complete = false;

    world.addTrees(treeCount);
    world.addLogs(logCount);
  }

  void tick() {
    world.tick();
  }

  abstract void listen(Event e);
}
