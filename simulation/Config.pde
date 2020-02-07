class Config {
  private JSONObject jsonConfig, jsonDefault;

  Config() {
    File targetFile = new File(sketchPath("config.json"));
    if (targetFile.exists()) {
      jsonConfig = loadJSONObject("config.json");
    }

    jsonDefault = new JSONObject();
    jsonDefault.setString("baseUrl", "http://localhost:4567");
  }

  String baseUrl() {
    return getStringConfig("baseUrl");
  }

  private String getStringConfig(String keyName) {
    if(jsonConfig != null && !jsonConfig.isNull(keyName)) {
      return jsonConfig.getString(keyName);
    }

    return jsonDefault.getString(keyName);
  }
}
