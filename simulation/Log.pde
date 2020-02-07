class Log extends WorldEntity {
  PShape logPileShape;
  int logPileShapeCount, logCount;
  float heading;

  Log(World world) {
    super(world);
    heading = random(2.0 * PI);
    logCount = int(random(12));
    traversable = false;
  }

  void tick(PGraphics pg) {
    pg.pushMatrix();
    pg.translate(x * tileSize + tileSize / 2, y * tileSize + tileSize / 2, currentNode.h * hScale);
    pg.scale(0.5);
    pg.rotateZ(heading);
    pg.shape(logPileShape(logCount));
    pg.popMatrix();
  }

  PShape logPileShape(int numberOfLogs) {
    if (logPileShape == null || logCount != logPileShapeCount) {
      logPileShape = createShape(GROUP);
      for (int i = 0; i < numberOfLogs; i++) {
        float logWidth = (i / 3) % 2 == 0 ? tileSize * 11.0 / 12.0 : tileSize / 5.0;
        float logDepth = (i / 3) % 2 == 1 ? tileSize * 11.0 / 12.0 : tileSize / 5.0;
        PShape shape = createShape(BOX, logWidth, logDepth, tileSize / 5.0);
        float xSpacing = (i / 3) % 2 == 1 ? (i % 3) - 1 : 0;
        float ySpacing = (i / 3) % 2 == 0 ? (i % 3) - 1 : 0;
        shape.translate(xSpacing * tileSize / 3.0, ySpacing * tileSize / 3.0, (1 + 2 * (i / 3)) * tileSize / 10.0);
        shape.setStroke(false);
        shape.setFill(#AA968A);
        logPileShape.addChild(shape);
      }
      logPileShapeCount = logCount;
    }
    return logPileShape;
  }
  
  boolean removeLog() {
    if (logCount == 0) { return false; }
    logCount --;
    if (logCount == 0) {
      world.toRemove.add(this);
    }
    return true;
  }
}
