int dragX, dragY;
World world;

void setup() {
  size(800, 800);
  frameRate(60);

  world = new World(int(random(256*256)));
  dragX = (width - world.width()) / 2;
  dragY = (height - world.height()) / 2;

  world.addPerson("John");
  world.addPerson("Adam");
  world.addPerson("Molly");

  for (int i=0; i<120; i++) {
    world.addTree();
  }
}

void draw() {
  background(255);
  translate(dragX, dragY);
  ellipseMode(CORNER);

  world.tick();
}

void mouseDragged() {
  dragX += mouseX - pmouseX;
  dragY += mouseY - pmouseY;
}
