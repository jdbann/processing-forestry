class Challenge_GetTasks extends Challenge {
  Challenge_GetTasks() {
    world.addPerson();
    title = "Challenge 2 - Get Tasks";
    description = "When a person has nothing to do, they ask for a task. They do this by making a request to:\n\n/tasks\n\nThis should be a JSON object which includes an array of tasks:\n\n{\n  tasks: []\n}";
  }

  void listen(Event event) {
    if (event instanceof GetTasksSuccessEvent) {
      markComplete();
    }
  }

  void openHelp() {
  }
}
