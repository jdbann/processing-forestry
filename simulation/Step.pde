class Step {
  Person person;
  
  Step(Person tempPerson) {
    person = tempPerson;
  }
  
  void tick() {};
  
  boolean isComplete() {
    return true;
  }
  
  void begin() {}
}

class WalkStep extends Step {
  int x, y;
  WalkStep(Person person, int tempX, int tempY) {
    super(person);
    x = tempX;
    y = tempY;
  }
  
  void tick() {
    person.walk();
  }
  
  boolean isComplete() {
    return person.x == x && person.y == y;
  }
  
  void begin() {
    person.setDestination(x, y);
  }
}

class ChopTreeStep extends Step {
  int treeX, treeY;
  Tree tree;
  ChopTreeStep(Person person, int tempTreeX, int tempTreeY) {
    super(person);
    treeX = tempTreeX;
    treeY = tempTreeY;
    for(WorldEntity entity : person.world.entities) {
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
