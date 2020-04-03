class Challenge_Sandbox extends Challenge {
  Challenge_Sandbox() {
    world.addPerson();
    world.addPerson();
    world.addPerson();

    title = "Sandbox";
    description = "Well done! You've completed all the challenges. Now you can just play around!";
  }

  void listen(Event e) {
  }

  void openHelp() {
  }
}
