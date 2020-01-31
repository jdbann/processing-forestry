import java.util.UUID;

class Person extends WorldEntity {
  float moveSpeed;
  String id, carrying;
  Path path;
  PersonClient client;
  Task task;
  PShape personShape;
  int noTaskCount;
  GetNextTaskThread thread;
  boolean registered;

  Person(World initWorld) {
    super(initWorld);
    id = UUID.randomUUID().toString();
    client = new PersonClient(this);
    task = null;
    moveSpeed = int(random(3, 10));
    personShape = createShape(SPHERE, tileSize / 3.0);
    personShape.setFill(#FF0000);
    personShape.setStroke(false);
    carrying = null;
    noTaskCount = 0;
    thread = new GetNextTaskThread(this);
    thread.start();
    registered = false;
  }

  void tick() {
    if (registered == false) {
      registered = client.register();
    }
    if (frameCount % moveSpeed == 0) {
      if (task != null) {
        if (task.isComplete()) {
          task = null;
        } else {
          task.tick();
        }
      } else {
        task = null;
      }
    }
    if (path != null) {
      path.tick();
    }
    drawPerson();
  }
  
  void drawPerson() {
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
    if (task == null) { personShape.setFill(#FF0000); } else {
      switch(task.type) {
        case "walk":
          personShape.setFill(#00FF00);
          break;
        case "chopTree":
          personShape.setFill(#0000FF);
          break;
        case "moveLog":
          personShape.setFill(#FFFF00);
          break;
        default:
          personShape.setFill(#FFFFFF);
          break;
      }
    }
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
      complete();
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
    if (tasks.size() > 0) {
      ArrayList<Task> possibleTasks = new ArrayList<Task>();
      for (Task nextTask : tasks) {
        if (nextTask.isPossible()) { possibleTasks.add(nextTask); } else { client.reportImpossible(nextTask); }
      }
      Collections.sort(possibleTasks);
      
      if (possibleTasks.size() > 0) {
        task = possibleTasks.get(0);
        client.confirmTask(task);
        task.begin();
        noTaskCount = 0;
        return;
      }
    }
    
    noTaskCount ++;
    if (noTaskCount > 10) {
      task = new WanderTask(this);
      task.begin();
      return;
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

  void complete() {
    //getNextTask();
  }
  
  void pickUpLog() {
    carrying = "log";
  }
}

class GetNextTaskThread extends Thread {
  Person person;
  
  GetNextTaskThread(Person tempPerson) {
    super();
    person = tempPerson;
  }
  
  void run() {
    while (true) {
      if (person.task == null) {
        person.getNextTask();
      }
      delay(100);
    }
  }
}
