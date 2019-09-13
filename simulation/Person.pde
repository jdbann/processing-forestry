int moveSpeed = 10;

class Person extends WorldEntity {
  int tX, tY;
  String name;
  Path path;
  PersonClient client;

  Person(World initWorld, String initName) {
    super(initWorld);
    tX = x;
    tY = y;
    name = initName;
    client = new PersonClient(this);
    client.register();
    arrived();
  }

  void tick() {
    fill(#FF0000);
    stroke(#FF0000);
    ellipse(xW(), yW(), tileSize, tileSize);
    //line(
    //  xW() + tileSize / 2, 
    //  yW() + tileSize / 2, 
    //  tX * tileSize + tileSize / 2, 
    //  tY * tileSize + tileSize / 2
    //  );
    if (frameCount % moveSpeed == 0) {
      walk();
    }
    if (path != null) {
      path.tick();
    }
  }

  void walk() {
    Node next = path.nextStep();
    if (next != null) {
      x = next.x;
      y = next.y;
    } else {
      arrived();
    }
  }

  void arrived() {
    JSONObject newDestination = client.getNewDestination();
    tX = newDestination.getInt("x");
    tY = newDestination.getInt("y");
    try {
      path = new Path(world.graph, tX, tY, x, y);
    } catch (UnreachableException e) {
      println("Couldn't reach that location. Getting a new one.");
      arrived();
    }
  }
}
