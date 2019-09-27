class Task {
  Person person;
  String id;
  int destinationX, destinationY;
  ArrayList<Step> steps;
  Task(Person tempPerson) {
    person = tempPerson;
    steps = new ArrayList<Step>();
  }
  
  boolean doNextStep() {
    return true;
  }
}

class WalkTask extends Task {
  WalkTask(Person person, String tempId, int tempDestinationX, int tempDestinationY) {
    super(person);
    id = tempId;
    steps.add(new WalkStep(person, tempDestinationX, tempDestinationY));
    doNextStep();
  }
  
  boolean doNextStep() {
    Step nextStep = steps.get(0);
    steps.remove(nextStep);
    return nextStep.beginStep();
  }
}
