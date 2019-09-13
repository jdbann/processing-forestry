class Tree extends WorldEntity {
  World world;
  int x, y;
  
  Tree(World initWorld) {
    super(initWorld);
  }
  
  void tick() {
    fill(#00FF00);
    noStroke();
    ellipse(xW(), yW(), tileSize, tileSize);
  }
}
