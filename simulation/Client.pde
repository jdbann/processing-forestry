import http.requests.*;

String baseUrl = "http://localhost:4567";

class Client {
  Client() {
  }

  GetRequest get(String route) {
    return new GetRequest(baseUrl + route);
  }

  PostRequest post(String route) {
    return new PostRequest(baseUrl + route);
  }
}
