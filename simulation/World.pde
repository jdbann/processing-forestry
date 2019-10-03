class World {
  int seed, w, h;
  float scale = 8;
  ArrayList<WorldEntity> entities;
  ArrayList<WorldEntity> toRemove;
  WorldClient client;
  Graph graph;

  World(int initSeed) {
    seed = initSeed;
    randomSeed(seed);
    w = int(random(worldMin, worldMax));
    h = int(random(worldMin, worldMax));
    entities = new ArrayList<WorldEntity>();
    toRemove = new ArrayList<WorldEntity>();
    client = new WorldClient(this);
    client.register();
    graph = new Graph(this);
  }

  void tick() {
    noStroke();
    pushMatrix();
    translate(-world.width() / 2, -world.height() / 2);
    graph.tick();
    for (WorldEntity entity : entities) {
      entity.tick();
    }
    if (toRemove.size() > 0) {
      for (WorldEntity entityToRemove : toRemove) {
        entities.remove(entityToRemove);
      }
      toRemove.clear();
      resetGraph();
    }
    popMatrix();
  }

  void addPerson(String name) {
    entities.add(new Person(this, name));
    resetGraph();
  }
  
  void addTrees(int count) {
    for (int i = 0; i < count; i++) {
      entities.add(new Tree(this));
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
