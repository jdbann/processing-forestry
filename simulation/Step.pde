class Step {
  Person person;
  
  Step(Person tempPerson) {
    person = tempPerson;
  }
  
  boolean beginStep() {
    return false;
  }
}

class WalkStep extends Step {
  int x, y;
  WalkStep(Person tempPerson, int tempX, int tempY) {
    super(tempPerson);
    x = tempX;
    y = tempY;
  }
  
  boolean beginStep() {
    return person.setDestination(x, y);
  }
}
