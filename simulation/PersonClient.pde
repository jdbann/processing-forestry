class PersonClient extends Client {
  Person person;

  PersonClient(Person initPerson) {
    person = initPerson;
  }

  GetRequest get(String route) {
    GetRequest req = super.get(route);
    req.addHeader("Person", person.name);
    return req;
  }

  PostRequest post(String route) {
    PostRequest req = super.post("/people/" + person.name + route);
    return req;
  }

  void register() {
    PostRequest post = super.post("/people");
    post.addData("name", person.name);
    post.addData("x", str(person.x));
    post.addData("y", str(person.y));
    post.send();
  }
  
  void reportTree(int x, int y) {
    PostRequest post = super.post("/trees");
    post.addData("x", str(x));
    post.addData("y", str(y));
    post.send();
  }

  JSONObject getNewDestination() {
    PostRequest post = post("/target");
    post.send();

    return parseJSONObject(post.getContent());
  }
}
