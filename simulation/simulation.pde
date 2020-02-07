int worldMin = 30;
int worldMax = 30;
int tileSize = 16;
int treeCount = 80;
int logCount = 4;

int zRotation, xRotation, zoom;
ChallengeStack challengeStack;

void setup() {
  size(1200, 800, P3D);
  frameRate(60);

  challengeStack = new ChallengeStack();

  zRotation = 0;
  xRotation = 0;
  zoom = 200;
}

void draw() {
  background(0);

  challengeStack.tick();
  Challenge currentChallenge = challengeStack.currentChallenge();

  image(currentChallenge.world.pg, 0, 0);
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
  zoom = max(100, min(zoom, 300));
}
