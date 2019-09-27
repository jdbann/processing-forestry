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
  WalkStep(Person tempPerson, int tempX, int tempY) {
    super(tempPerson);
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
