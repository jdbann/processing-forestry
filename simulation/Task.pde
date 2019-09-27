class Task {
  String id;
  int destinationX, destinationY;
  Task() {
  }
}

class WalkTask extends Task {
  WalkTask(String tempId, int tempDestinationX, int tempDestinationY) {
    id = tempId;
    destinationX = tempDestinationX;
    destinationY = tempDestinationY;
  }
}
