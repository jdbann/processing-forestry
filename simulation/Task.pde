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
        break;
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
    begin();
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
  ChopTreeTask(Person person, String id, int tempTreeX, int tempTreeY) {
    super(person, id);
  }
}
