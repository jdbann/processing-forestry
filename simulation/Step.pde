class Step {
  Person person;
  boolean completed;

  Step(Person tempPerson) {
    person = tempPerson;
    completed = false;
  }

  void tick() {
  };

  boolean isComplete() {
    return true;
  }

  void begin() {
  }
}

class WalkStep extends Step {
  int x, y;
  boolean begun;

  WalkStep(Person person, int tempX, int tempY) {
    super(person);
    x = tempX;
    y = tempY;
    begun = false;
  }

  void tick() {
    if (begun == false) { 
      begin();
    }
    person.walk();
  }

  boolean isComplete() {
    if (completed != true && person.x == x && person.y == y) {
      completed = true;
    }
    return completed == true;
  }

  void begin() {
    person.setDestination(x, y);
    begun = true;
  }
}

class ChopTreeStep extends Step {
  int treeX, treeY;
  Tree tree;
  ChopTreeStep(Person person, int tempTreeX, int tempTreeY) {
    super(person);
    treeX = tempTreeX;
    treeY = tempTreeY;
    for (WorldEntity entity : person.world.entities) {
      if (!(entity instanceof Tree)) {
        break;
      }
      if (entity.x == treeX && entity.y == treeY) {
        tree = (Tree)entity;
      }
    }
  }

  void tick() {
    tree.chop();
  }

  boolean isComplete() {
    if (tree == null) {
      return true;
    }
    return tree.health <= 0;
  }
}

class PickUpLog extends Step {
  int logX, logY;
  Log log;

  PickUpLog(Person person, int tempLogX, int tempLogY) {
    super(person);
    logX = tempLogX;
    logY = tempLogY;
  }

  void tick() {
    log = findLog();
    if (log != null) {
      if (abs(log.x - person.x) <= 1 && abs(log.y - person.y) <= 1) {
        if (log.removeLog()) {
          person.pickUpLog();
        }
      }
    }
  }

  Log findLog() {
    for (WorldEntity entity : person.world.entities) {
      if (!(entity instanceof Log)) {
        continue;
      }
      if (entity.x == logX && entity.y == logY) {
        return (Log)entity;
      }
    }
    return null;
  }

  boolean isComplete() {
    log = findLog();
    return (person.carrying == "log" || log == null || log.logCount == 0);
  }
}

class DropLog extends Step {
  int dropX, dropY;

  DropLog(Person person, int tempDropX, int tempDropY) {
    super(person);
    dropX = tempDropX;
    dropY = tempDropY;
  }

  void tick() {
    Log newLog = null;
    for (WorldEntity entity : person.world.entities) {
      if (!(entity instanceof Log)) {
        continue;
      }
      if (entity.x == dropX && entity.y == dropY) {
        newLog = (Log)entity;
      }
    }

    if (newLog != null) {
      newLog.logCount ++;
    } else {
      newLog = new Log(person.world);
      newLog.x = dropX;
      newLog.y = dropY;
      newLog.logCount = 1;
      Node logNode = person.world.graph.findNode(dropX, dropY);
      newLog.setCurrentNode(logNode);
      logNode.setOccupant(newLog);
      person.world.toAdd.add(newLog);
    }
    person.carrying = null;
  }

  boolean isComplete() {
    return (person.carrying == null);
  }
}
