class Challenge_GoForAWalk extends Challenge {
  Challenge_GoForAWalk() {
    world.addPerson();
    title = "Challenge 3 - Go For A Walk";
  }

  void listen(Event event) {
    if (event instanceof WalkTaskCompleteEvent) {
      markComplete();
    }
  }

  void openHelp() {
    launch(dataPath("go_for_a_walk.html"));
  }
}
