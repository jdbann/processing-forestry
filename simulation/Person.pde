class Person extends WorldEntity {
  int tX, tY, moveSpeed;
  String name;
  Path path;
  PersonClient client;

  Person(World initWorld, String initName) {
    super(initWorld);
    tX = x;
    tY = y;
    name = initName;
    client = new PersonClient(this);
    client.register();
    currentNode = world.graph.findNode(x, y);
    arrived();
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
      walk();
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
      currentNode = next;
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
      if (world.graph.findNode(cX, cY).occupant instanceof Tree) {
        client.reportTree(cX, cY);
      }
    }
  }
  
  Task getNextTask() {
    ArrayList<Task> tasks = client.getTasks();
    Task nextTask = tasks.get(0);
    client.confirmTask(nextTask);
    return nextTask;
  }

  void arrived() {
    Task newTask = getNextTask();
    tX = newTask.destinationX;
    tY = newTask.destinationY;
    try {
      path = new Path(world.graph, tX, tY, x, y);
    } catch (UnreachableException e) {
      println("Couldn't reach that location. Getting a new one.");
      arrived();
    }
  }
}
