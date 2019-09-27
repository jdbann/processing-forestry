class Task {
  Person person;
  String id;
  int destinationX, destinationY;
  ArrayList<Step> steps;
  Task(Person tempPerson, String tempId) {
    person = tempPerson;
    id = tempId;
    steps = new ArrayList<Step>();
  }

  void begin() {
    Step nextStep = steps.get(0);
    nextStep.begin();
  }

  void tick() {
    for (Step step : steps) {
      if (step.isComplete()) {
        continue;
      }

      step.tick();
      return;
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
}

class WalkTask extends Task {
  int x, y;
  WalkTask(Person person, String id, int tempX, int tempY) {
    super(person, id);
    x = tempX;
    y = tempY;
    steps.add(new WalkStep(person, tempX, tempY));
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
  }

  Path findPathToTree() {
    Path path = person.getPathTo(treeX + 1, treeY);
    if (path != null) { 
      return path;
    }
    path = person.getPathTo(treeX - 1, treeY);
    if (path != null) { 
      return path;
    }
    path = person.getPathTo(treeX, treeY + 1);
    if (path != null) { 
      return path;
    }
    path = person.getPathTo(treeX, treeY - 1);
    return path;
  }

  boolean isPossible() {
    Path path = findPathToTree();
    if (path != null) {
      return true;
    } else {
      return false;
    }
  }
}
