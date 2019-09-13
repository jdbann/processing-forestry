class WorldClient extends Client {
  World world;

  WorldClient(World initWorld) {
    world = initWorld;
  }

  void register() {
    PostRequest post = super.post("/world");
    post.addData("w", str(world.w));
    post.addData("h", str(world.h));
    post.send();
    post.getContent();
  }
}
