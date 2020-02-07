class World {
  int seed, w, h;
  float scale = 8;
  ArrayList<WorldEntity> entities;
  ArrayList<WorldEntity> toRemove;
  ArrayList<WorldEntity> toAdd;
  WorldClient client;
  Graph graph;
  EventStream eventStream;
  PGraphics pg;

  World(int initSeed, EventStream eventStream_) {
    seed = initSeed;
    randomSeed(seed);
    w = int(random(worldMin, worldMax));
    h = int(random(worldMin, worldMax));
    entities = new ArrayList<WorldEntity>();
    toRemove = new ArrayList<WorldEntity>();
    toAdd = new ArrayList<WorldEntity>();
    client = new WorldClient(this);
    client.register();
    graph = new Graph(this);
    eventStream = eventStream_;
  }

  void tick() {
    pg = createGraphics(width, height, P3D);
    pg.beginDraw();
    pg.camera(width / 2, 300 + height / 2, 200, width / 2, height / 2, 0, 
        0.0, 1.0, 0.0);
    pg.translate(width / 2, height / 2);
    pg.ellipseMode(CORNER);
    pg.rotateX(xRotation / 180.0);
    pg.rotateZ(zRotation / 180.0);
    pg.pointLight(192, 192, 192, width / 3, 400, 2 * height / 2);
    pg.ambientLight(128, 128, 128);
    pg.scale(zoom / 200.0);

    pg.noStroke();
    pg.pushMatrix();
    pg.translate(-width() / 2, -height() / 2);
    graph.tick(pg);
    for (WorldEntity entity : entities) {
      entity.tick(pg);
    }
    if (toRemove.size() > 0 || toAdd.size() > 0) {
      for (WorldEntity entityToRemove : toRemove) {
        entities.remove(entityToRemove);
      }
      toRemove.clear();
      for (WorldEntity entityToAdd : toAdd) {
        entities.add(entityToAdd);
      }
      toAdd.clear();
      resetGraph();
    }
    pg.popMatrix();
    pg.endDraw();
  }

  void addPerson() {
    entities.add(new Person(this));
    resetGraph();
  }

  void addTrees(int count) {
    for (int i = 0; i < count; i++) {
      entities.add(new Tree(this));
    }
    resetGraph();
  }

  void addLogs(int count) {
    for (int i = 0; i < count; i++) {
      entities.add(new Log(this));
    }
    resetGraph();
  }

  void resetGraph() {
    graph = new Graph(this);
  }

  int width() {
    return(w * tileSize);
  }

  int height() {
    return(h * tileSize);
  }
}
