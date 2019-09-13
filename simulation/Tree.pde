class Tree extends WorldEntity {
  Tree(World initWorld) {
    super(initWorld);
    currentNode = null;
  }
  
  void tick() {
    stroke(#B5BA72);
    noFill();
    pushMatrix();
    translate(x * tileSize + tileSize / 2, y * tileSize + tileSize / 2, currentNode().h * hScale + tileSize);
    sphere(tileSize / 3);
    popMatrix();
    pushMatrix();
    stroke(#AA968A);
    translate(x * tileSize + tileSize / 2, y * tileSize + tileSize / 2, currentNode().h * hScale + tileSize / 2);
    box(2, 2, tileSize);
    popMatrix();
  }
  
  Node currentNode() {
    if (currentNode == null) {
      currentNode = world.graph.findNode(x, y);
    }
    return currentNode;
  }
}
