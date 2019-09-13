class Person extends WorldEntity {
  int tX, tY, moveSpeed;
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
    currentNode = world.graph.findNode(x, y);
    arrived();
    moveSpeed = int(random(3, 10));
  }

  void tick() {
    fill(#FF0000);
    stroke(#FF0000);
    pushMatrix();
    translate(x * tileSize + tileSize / 2, y * tileSize + tileSize / 2, currentNode.h * hScale + tileSize / 2);
    sphere(tileSize / 3);
    popMatrix();
    //ellipse(xW(), yW(), tileSize, tileSize);
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
      currentNode = next;
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
