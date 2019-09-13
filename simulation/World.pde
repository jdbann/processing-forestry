int worldMin = 40;
int worldMax = 80;
int tileSize = 16;

class World {
  int seed, w, h;
  float scale = 8;
  ArrayList<WorldEntity> entities;
  WorldClient client;
  Graph graph;

  World(int initSeed) {
    seed = initSeed;
    randomSeed(seed);
    w = int(random(worldMin, worldMax));
    h = int(random(worldMin, worldMax));
    entities = new ArrayList<WorldEntity>();
    client = new WorldClient(this);
    client.register();
    graph = new Graph(this);
  }

  void tick() {
    noiseSeed(seed);
    for (int x = 0; x < w; x++) {
      for (int y = 0; y < h; y++) {
        noStroke();
        fill(noise(x / scale, y / scale) * 255);
        rect(x * tileSize, y * tileSize, tileSize, tileSize);
      }
    }
    for (WorldEntity entity : entities) {
      entity.tick();
    }
    graph.tick();
  }

  void addPerson(String name) {
    entities.add(new Person(this, name));
    resetGraph();
  }
  
  void addTree() {
    entities.add(new Tree(this));
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
