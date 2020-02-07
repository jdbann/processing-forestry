class Challenge_200Response extends Challenge {
  Challenge_200Response() {
    world.addPerson();
    title = "Challenge 1 - 200 Response";
    description = "A simple one to start with. This person will try to register their location by making a POST request to:\n\nhttp://localhost:4567/people\n\nYou just need to respond with status 200 to proceed.";
  }

  void listen(Event event) {
    if (event instanceof ClientSuccessEvent) {
      markComplete();
    }
  }
}
