class Challenge_200Response extends Challenge {
  boolean isComplete;

  Challenge_200Response() {
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
