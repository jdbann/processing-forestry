class Task {
  int destinationX, destinationY;
  Task() {
  }
}

class WalkTask extends Task {
  WalkTask(int tempDestinationX, int tempDestinationY) {
    destinationX = tempDestinationX;
    destinationY = tempDestinationY;
  }
}
