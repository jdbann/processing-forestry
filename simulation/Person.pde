class Person extends WorldEntity {
  int moveSpeed;
  String name;
  Path path;
  PersonClient client;
  Task task;

  Person(World initWorld, String initName) {
    super(initWorld);
    name = initName;
    client = new PersonClient(this);
    client.register();
    getNextTask();
    moveSpeed = int(random(2, 5));
  }

  void tick() {
    fill(#FF0000);
    stroke(#FF0000);
    pushMatrix();
    translate(x * tileSize + tileSize / 2, y * tileSize + tileSize / 2, currentNode.h * hScale + tileSize / 2);
    sphere(tileSize / 3);
    popMatrix();
    if (frameCount % moveSpeed == 0) {
      if (task != null) {
        if (task.isComplete()) {
          getNextTask();
        } else {
          task.tick();
        }
      }
    }
    if (path != null) {
      path.tick();
    }
  }

  void walk() {
    Node next = path.nextStep();
    if (next != null) {
      x = next.x;
      y = next.y;
      setCurrentNode(next);
    } else {
      arrived();
    }
    reportIfTreeAt(x - 1, y);
    reportIfTreeAt(x + 1, y);
    reportIfTreeAt(x, y - 1);
    reportIfTreeAt(x, y + 1);
  }
  
  void reportIfTreeAt(int cX, int cY) {
    if (cX >= 0 && cX < world.w && cY >= 0&& cY < world.h) {
      WorldEntity occupant = world.graph.findNode(cX, cY).occupant;
      if (occupant instanceof Tree) {
        client.reportTree(cX, cY);
      }
    }
  }
  
  void getNextTask() {
    ArrayList<Task> tasks = client.getTasks();
    while (tasks.size() > 0) {
      Task nextTask = tasks.get(0);
      tasks.remove(nextTask);
      if (nextTask.isPossible()) {
        client.confirmTask(nextTask);
        task = nextTask;
        task.begin();
        return;
      }
    }
    task = null;
  }
  
  Path getPathTo(int destinationX, int destinationY) {
    try {
      return new Path(world.graph, destinationX, destinationY, x, y);
    } catch (UnreachableException e) {
      return null;
    }
  }
  
  void setDestination(int destinationX, int destinationY) {
    path = getPathTo(destinationX, destinationY);
  }

  void arrived() {
    //getNextTask();
  }
}
