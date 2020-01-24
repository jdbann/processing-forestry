import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.HttpResponse;
import org.apache.http.HttpEntity;
import org.apache.http.util.EntityUtils;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;

class GetRequest {
  String url;
  String content;
  int status;
  HttpGet httpGet;
  HttpResponse response;

  GetRequest(String url_) {
    url = url_;
    httpGet = new HttpGet(url);
  }

  void addHeader(String headerKey, String headerValue) {
    httpGet.addHeader(headerKey, headerValue);
  }

  void send() {
    DefaultHttpClient httpClient = new DefaultHttpClient();

    try {
      response = httpClient.execute(httpGet);
      status = response.getStatusLine().getStatusCode();
      HttpEntity entity = response.getEntity();
      content = EntityUtils.toString(response.getEntity());
      if (entity != null) {
        EntityUtils.consume(entity);
      }
      httpClient.getConnectionManager().shutdown();
    } catch(Exception e) {
      e.printStackTrace();
    }
  }
  
  String getContent() {
    return content;
  }
}

class PostRequest {
  String url;
  String content;
  int status;
  HttpPost httpPost;
  HttpResponse response;
  ArrayList<BasicNameValuePair> dataPairs;

  PostRequest(String url_) {
    url = url_;
    httpPost = new HttpPost(url);
    dataPairs = new ArrayList<BasicNameValuePair>();
  }

  void addHeader(String headerKey, String headerValue) {
    httpPost.addHeader(headerKey, headerValue);
  }

  void addData(String dataKey, String dataValue) {
    BasicNameValuePair pair = new BasicNameValuePair(dataKey, dataValue);
    dataPairs.add(pair);
  }

  void send() {
    DefaultHttpClient httpClient = new DefaultHttpClient();

    try {
      httpPost.setEntity(new UrlEncodedFormEntity(dataPairs, "ISO-8859-1"));
      response = httpClient.execute(httpPost);
      status = response.getStatusLine().getStatusCode();
      HttpEntity entity = response.getEntity();
      content = EntityUtils.toString(response.getEntity());
      if (entity != null) {
        EntityUtils.consume(entity);
      }
      httpClient.getConnectionManager().shutdown();
    } catch(Exception e) {
      e.printStackTrace();
    }
  }
  
  String getContent() {
    return content;
  }
}

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
