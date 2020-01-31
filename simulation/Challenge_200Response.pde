class Challenge_200Response extends Challenge {
  Challenge_200Response() {
    world.addPerson();
  }

  void listen(Event event) {
    if (event instanceof ClientSuccessEvent) {
      complete = true;
    }
  }
}
