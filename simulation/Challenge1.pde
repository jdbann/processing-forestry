class Challenge1 extends Challenge {
  boolean isComplete;

  Challenge1() {
    isComplete = false;
  }

  void listen(Event event) {
    if (event instanceof ClientSuccessEvent) {
      isComplete = true;
    }
  }

  boolean isComplete() {
    return isComplete;
  }
}
