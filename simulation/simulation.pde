int worldMin = 20;
int worldMax = 30;
int tileSize = 16;
int treeCount = 80;

int dragX, dragY;
World world;

void setup() {
  size(1200, 800, P3D);
  frameRate(60);

  world = new World(int(random(256*256)));
  dragX = (width - world.width()) / 2;
  dragY = (height - world.height()) / 2;

  world.addTrees(treeCount);

  world.addPerson("John");
  world.addPerson("Adam");
  world.addPerson("Molly");
}

void draw() {
  pointLight(255, 255, 255, width / 2, height / 2, 400);
  background(0);
  camera(width / 2, 300 + height / 2, 400, width / 2, height / 2, 0, 
       0.0, 1.0, 0.0);
  translate(dragX, dragY);
  ellipseMode(CORNER);

  world.tick();
}

void mouseDragged() {
  dragX += mouseX - pmouseX;
  dragY += mouseY - pmouseY;
}

void keyPressed() {
  debugGraph = !debugGraph;
}
