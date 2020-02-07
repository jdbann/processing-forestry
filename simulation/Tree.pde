class Tree extends WorldEntity {
  int health, maxHealth;
  float heading;
  PShape treeShape;

  Tree(World initWorld) {
    super(initWorld);
    health = 3 + int(random(9));
    maxHealth = health;
    heading = random(2.0 * PI);
    traversable = false;
    treeShape = createShape(GROUP);
    sphereDetail(5);
    PShape leaves = createShape(SPHERE, tileSize / 3);
    leaves.translate(0, 0, tileSize);
    leaves.setFill(color(#B5BA72));
    leaves.setStroke(false);
    PShape trunk = createShape(BOX, 2, 2, tileSize);
    trunk.setFill(color(#AA968A));
    trunk.setStroke(false);
    trunk.translate(0, 0, tileSize / 2);
    treeShape.addChild(leaves);
    treeShape.addChild(trunk);
  }

  void tick(PGraphics pg) {
    float damage = 1 - (health / float(maxHealth)); 
    pg.pushMatrix();
    pg.translate(x * tileSize + tileSize / 2, y * tileSize + tileSize / 2, currentNode.h * hScale);
    pg.rotateZ(heading);
    pg.rotateX(damage * PI / 2.0);
    pg.shape(treeShape);
    pg.popMatrix();
  }

  void chop() {
    health --;
    if (health <= 0) {
      world.toRemove.add(this);
      replaceWithLogs();
    }
  }

  void replaceWithLogs() {
    Log logs = new Log(world);
    logs.logCount = maxHealth;
    world.toAdd.add(logs);
    currentNode.setOccupant(logs);
    logs.setCurrentNode(currentNode);
  }
}
