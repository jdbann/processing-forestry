class Tree extends WorldEntity {
  int health, maxHealth;
  float heading;
  
  Tree(World initWorld) {
    super(initWorld);
    health = 3 + int(random(3));
    maxHealth = health;
    heading = random(2.0 * PI);
    traversable = false;
  }
  
  void tick() {
    float damage = 1 - (health / float(maxHealth)); 
    stroke(#B5BA72);
    noFill();
    pushMatrix();
    translate(x * tileSize + tileSize / 2, y * tileSize + tileSize / 2, currentNode.h * hScale);
    rotateZ(heading);
    rotateX(damage * PI / 2.0);
    pushMatrix();
    translate(0, 0, tileSize);
    sphere(tileSize / 3);
    popMatrix();
    pushMatrix();
    stroke(#AA968A);
    translate(0, 0, tileSize / 2);
    box(2, 2, tileSize);
    popMatrix();
    popMatrix();
  }
  
  void chop() {
    health --;
    if (health <= 0) {
      world.toRemove.add(this);
      currentNode.setOccupant(null);
    }
  }
}
