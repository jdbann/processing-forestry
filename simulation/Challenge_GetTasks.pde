class Challenge_GetTasks extends Challenge {
  Challenge_GetTasks() {
    world.addPerson();
    title = "Challenge 2 - Get Tasks";
  }

  void listen(Event event) {
    if (event instanceof GetTasksSuccessEvent) {
      markComplete();
    }
  }

  void openHelp() {
  }
}
