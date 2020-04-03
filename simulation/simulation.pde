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
  pixelDensity(displayDensity());

  surface.setTitle("Forestry");

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
  image(currentChallenge.overlay(), 0, 0);

  textSize(16);
  text("Press [h] for help on current challenge", 40, 760);
}

void mouseDragged() {
  zRotation -= mouseX - pmouseX;
  xRotation -= mouseY - pmouseY;
}

void keyPressed() {
  switch(key) {
    case 'g':
      debugGraph = !debugGraph;
      break;
    case 'h':
      challengeStack.currentChallenge().openHelp();
      break;
  }
}

void mouseWheel(MouseEvent event) {
  zoom -= event.getCount();
  zoom = max(100, min(zoom, 300));
}
