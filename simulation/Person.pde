class Person extends WorldEntity {
  float moveSpeed;
  String name;
  Path path;
  PersonClient client;
  Task task;
  PShape personShape;

  Person(World initWorld, String initName) {
    super(initWorld);
    name = initName;
    client = new PersonClient(this);
    client.register();
    getNextTask();
    moveSpeed = int(random(5, 20));
    personShape = createShape(SPHERE, tileSize / 3.0);
    personShape.setFill(#FF0000);
    personShape.setStroke(false);
  }

  void tick() {
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
    Node n;
    float xM = x, yM = y, hM = currentNode.h;
    if (path != null) {
      n = path.cameFrom.get(path.start);
      if (n != null) {
        xM = x + (1 + (frameCount % moveSpeed)) * (n.x - x) / moveSpeed;
        yM = y + (1 + (frameCount % moveSpeed)) * (n.y - y) / moveSpeed;
        hM = currentNode.h + (1 + (frameCount % moveSpeed)) * (n.h - currentNode.h) / moveSpeed;
      }
    }
    pushMatrix();
    translate(xM * tileSize + tileSize / 2, yM * tileSize + tileSize / 2, hM * hScale + tileSize / 2);
    shape(personShape);
    popMatrix();
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
    reportIfAnythingAt(x - 1, y);
    reportIfAnythingAt(x + 1, y);
    reportIfAnythingAt(x, y - 1);
    reportIfAnythingAt(x, y + 1);
  }

  void reportIfAnythingAt(int cX, int cY) {
    if (cX >= 0 && cX < world.w && cY >= 0&& cY < world.h) {
      WorldEntity occupant = world.graph.findNode(cX, cY).occupant;
      if (occupant instanceof Tree) {
        client.reportTree(cX, cY);
      }
      if (occupant instanceof Log) {
        client.reportLog((Log) occupant);
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
    } 
    catch (UnreachableException e) {
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
