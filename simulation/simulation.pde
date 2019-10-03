int worldMin = 30;
int worldMax = 30;
int tileSize = 16;
int treeCount = 80;
int logCount = 4;

int zRotation, xRotation, zoom;
World world;

void setup() {
  size(1200, 800, P3D);
  frameRate(60);

  world = new World(int(random(256*256)));
  zRotation = 0;
  xRotation = 0;
  zoom = 200;

  world.addTrees(treeCount);
  world.addLogs(logCount);

  world.addPerson("John");
  world.addPerson("Adam");
  world.addPerson("Molly");
}

void draw() {
  pointLight(192, 192, 192, width / 3, 2 * height / 2, 400);
  ambientLight(128, 128, 128);
  background(0);
  camera(width / 2, 300 + height / 2, 200, width / 2, height / 2, 0, 
    0.0, 1.0, 0.0);
  translate(width / 2, height / 2);
  ellipseMode(CORNER);
  rotateX(xRotation / 180.0);
  rotateZ(zRotation / 180.0);
  scale(zoom / 200.0);

  world.tick();
}

void mouseDragged() {
  zRotation -= mouseX - pmouseX;
  xRotation -= mouseY - pmouseY;
}

void keyPressed() {
  debugGraph = !debugGraph;
}

void mouseWheel(MouseEvent event) {
  zoom -= event.getCount();
}
