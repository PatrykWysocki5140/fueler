// ignore: file_names
class MyJson {
  // ignore: non_constant_identifier_names
  String JsonDecoder(String json) {
    json = json.replaceAll('{', '{"');
    json = json.replaceAll(': ', '": "');
    json = json.replaceAll(', ', '", "');
    json = json.replaceAll('}', '"}');
    return json;
  }

  // ignore: non_constant_identifier_names
  String JsonDecoderList(String json) {
    json = json.replaceAll('"}", "{"', '"}, {"');
    json = json.replaceAll('"{"longitude": "', '"');
    json = json.replaceAll('", "latitude": "', ',');
    json = json.replaceAll('"}", "name":', '", "name":');
    json = json.replaceAll('": "[{"', '", "": [{"');
    json = json.replaceAll('"}]"}', '", ""}]}');
    return json;
  }
}
