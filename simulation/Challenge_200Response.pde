class Challenge_200Response extends Challenge {
  Challenge_200Response() {
    world.addPerson();
    title = "Challenge 1 - 200 Response";
  }

  void listen(Event event) {
    if (event instanceof ClientSuccessEvent) {
      markComplete();
    }
  }

  void openHelp() {
    launch(dataPath("200_response.html"));
  }
}
