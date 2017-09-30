import 'dart:convert';
import 'dart:io';

class JsonParser {
  static List<Map<String, dynamic>> parseFile(String filePath) {
    String fileContent = new File(filePath).readAsStringSync();
    List<Map<String, dynamic>> eventsJson = JSON.decode(fileContent);
    return eventsJson;
  }
}
