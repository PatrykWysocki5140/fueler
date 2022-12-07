class MyJson {
  // ignore: non_constant_identifier_names
  String JsonDecoder(json) {
    json = json.replaceAll('{', '{"');
    json = json.replaceAll(': ', '": "');
    json = json.replaceAll(', ', '", "');
    json = json.replaceAll('}', '"}');
    return json;
  }
}
