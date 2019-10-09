class PersonClient extends Client {
  Person person;

  PersonClient(Person initPerson) {
    person = initPerson;
  }

  GetRequest get(String route) {
    GetRequest req = super.get("/people/" + person.name + route);
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
  
  void reportLog(Log log) {
    PostRequest post = super.post("/logs");
    post.addData("x", str(log.x));
    post.addData("y", str(log.y));
    post.addData("quantity", str(log.logCount));
    post.send();
  }

  JSONObject getNewDestination() {
    PostRequest post = post("/target");
    post.send();

    return parseJSONObject(post.getContent());
  }

  ArrayList<Task> getTasks() {
    GetRequest get = get("/tasks");
    get.send();
    ArrayList<Task> tasks = new ArrayList<Task>();
    if (get.getContent() != null) {
      JSONObject jsonResponse = parseJSONObject(get.getContent());
      JSONArray jsonTasks = jsonResponse.getJSONArray("tasks");
  
      for (int i = 0; i < jsonTasks.size(); i++) {
        JSONObject jsonTask = jsonTasks.getJSONObject(i);
        switch(jsonTask.getString("type")) {
        case "walk":
          tasks.add(new WalkTask(person, jsonTask.getString("id"), jsonTask.getInt("x"), jsonTask.getInt("y")));
          break;
        case "chopTree":
          tasks.add(new ChopTreeTask(person, jsonTask.getString("id"), jsonTask.getInt("x"), jsonTask.getInt("y")));
          break;
        case "moveLog":
          tasks.add(new MoveLogTask(person, jsonTask.getString("id"), jsonTask.getInt("log_x"), jsonTask.getInt("log_y"), jsonTask.getInt("drop_x"), jsonTask.getInt("drop_y")));
          break;
        }
      }
    }
    return tasks;
  }

  void confirmTask(Task task) {
    PostRequest post = post("/tasks");
    post.addData("id", task.id);
    post.send();
  }
  
  void reportImpossible(Task task) {
    PostRequest post = post("/tasks/" + task.id + "/impossible");
    post.send();
  }
}
