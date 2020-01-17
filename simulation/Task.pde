class Task implements Comparable<Task> {
  Person person;
  String id, type;
  int destinationX, destinationY, expense;
  ArrayList<Step> steps;

  Task(Person tempPerson, String tempId) {
    person = tempPerson;
    id = tempId;
    steps = new ArrayList<Step>();
    type = "unknown";
    expense = person.world.w * person.world.h;
  }

  void begin() {
    Step nextStep = steps.get(0);
    nextStep.begin();
  }

  void tick() {
    ArrayList<Step> toRemove = new ArrayList<Step>();
    for (Step step : steps) {
      if (step.isComplete()) {
        toRemove.add(step);
        continue;
      }

      step.tick();
      break;
    }
    for (Step step : toRemove) {
      steps.remove(step);
    }
  }

  boolean isComplete() {
    for (Step step : steps) {
      if (!step.isComplete()) {
        return false;
      }
    }
    return true;
  }

  boolean isPossible() {
    return false;
  }

  public int compareTo(Task task) {
    return expense - task.expense;
  }
}

class WalkTask extends Task {
  int x, y;
  Path path;

  WalkTask(Person person, String id, int tempX, int tempY) {
    super(person, id);
    x = tempX;
    y = tempY;
    steps.add(new WalkStep(person, tempX, tempY));
    type = "walk";
    path = person.getPathTo(x, y);
    if (path != null) { 
      expense = path.cameFrom.size();
    }
  }

  boolean isPossible() {
    Path path = person.getPathTo(x, y);
    if (path != null) {
      return true;
    } else {
      return false;
    }
  }
}

class WanderTask extends Task {
  int x, y;
  WanderTask(Person person) {
    super(person, "wander_" + person.id);
    Path path = null;
    while (path == null) {
      x = person.x + int(random(3)) - 1;
      y = person.y + int(random(3)) - 1;
      path = person.getPathTo(x, y);
    }
    steps.add(new WalkStep(person, x, y));
    type = "wander";
  }
}

class ChopTreeTask extends Task {
  int treeX, treeY;

  ChopTreeTask(Person person, String id, int tempTreeX, int tempTreeY) {
    super(person, id);
    treeX = tempTreeX;
    treeY = tempTreeY;
    Path path = findPathToTree();
    if (path != null) {
      Node destination = path.end;
      steps.add(new WalkStep(person, destination.x, destination.y));
      steps.add(new ChopTreeStep(person, treeX, treeY));
    }
    type = "chopTree";
    if (path != null) { 
      expense = path.cameFrom.size();
    }
  }

  Path findPathToTree() {
    Path chosenPath = null;
    int chosenPathSize = person.world.w * person.world.h;
    Path path = person.getPathTo(treeX + 1, treeY);
    if (path != null) { 
      chosenPath = path;
      chosenPathSize = path.cameFrom.size();
    }
    path = person.getPathTo(treeX - 1, treeY);
    if (path != null && path.cameFrom.size() < chosenPathSize) { 
      chosenPath = path;
      chosenPathSize = path.cameFrom.size();
    }
    path = person.getPathTo(treeX, treeY + 1);
    if (path != null && path.cameFrom.size() < chosenPathSize) { 
      chosenPath = path;
      chosenPathSize = path.cameFrom.size();
    }
    path = person.getPathTo(treeX, treeY - 1);
    if (path != null && path.cameFrom.size() < chosenPathSize) {
      chosenPath = path;
      chosenPathSize = path.cameFrom.size();
    }
    return chosenPath;
  }

  boolean isPossible() {
    Tree tree = null;
    for (WorldEntity entity : person.world.entities) {
      if (!(entity instanceof Tree)) {
        continue;
      }
      if (entity.x == treeX && entity.y == treeY) {
        tree = (Tree)entity;
      }
    }
    Path path = findPathToTree();
    return path != null && tree != null;
  }
}

class MoveLogTask extends Task {
  int startX, startY, endX, endY;
  Path startPath, endPath;

  MoveLogTask(Person person, String id, int tempStartX, int tempStartY, int tempEndX, int tempEndY) {
    super(person, id);
    startX = tempStartX;
    startY = tempStartY;
    endX = tempEndX;
    endY = tempEndY;
    startPath = findPathTo(startX, startY);
    endPath = findPathTo(endX, endY);
    if (startPath != null && endPath != null) {
      Node startDestination = startPath.end;
      Node endDestination = endPath.end;
      steps.add(new WalkStep(person, startDestination.x, startDestination.y));
      steps.add(new PickUpLog(person, startX, startY));
      steps.add(new WalkStep(person, endDestination.x, endDestination.y));
      steps.add(new DropLog(person, endX, endY));
    }
    type = "moveLog";
    if (startPath != null) { 
      expense = startPath.cameFrom.size();
    }
  }

  boolean isPossible() {
    Log log = null;
    for (WorldEntity entity : person.world.entities) {
      if (!(entity instanceof Log)) {
        continue;
      }
      if (entity.x == startX && entity.y == startY) {
        log = (Log)entity;
      }
    }
    return (startPath != null && endPath != null && person.carrying == null && log != null);
  }

  Path findPathTo(int x, int y) {
    Path chosenPath = null;
    int chosenPathSize = person.world.w * person.world.h;
    Path path = person.getPathTo(x + 1, y);
    if (path != null) { 
      chosenPath = path;
      chosenPathSize = path.cameFrom.size();
    }
    path = person.getPathTo(x - 1, y);
    if (path != null && path.cameFrom.size() < chosenPathSize) { 
      chosenPath = path;
      chosenPathSize = path.cameFrom.size();
    }
    path = person.getPathTo(x, y + 1);
    if (path != null && path.cameFrom.size() < chosenPathSize) { 
      chosenPath = path;
      chosenPathSize = path.cameFrom.size();
    }
    path = person.getPathTo(x, y - 1);
    if (path != null && path.cameFrom.size() < chosenPathSize) {
      chosenPath = path;
      chosenPathSize = path.cameFrom.size();
    }
    return chosenPath;
  }
}
