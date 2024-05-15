import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class JsonApi {
  Future<List> loadJSONDataFromAssets(String fileName) async {
    // Load the JSON file from the assets folder
    String jsonString =
        await rootBundle.loadString('assets/Data/$fileName.json');
    // Convert the JSON string to a JSON object
    var data = await json.decode(jsonString);

    // Return the parsed data as a list
    return data;
  }

  Future<List> loadJSONData(String fileName) async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String filePath = '${documentsDir.path}/$fileName.json';
    File file = File(filePath);
    List data = json.decode(await file.readAsString());
    return data;
  }

  setJSONData(String fileName, Map newItem) async {
    List<dynamic> jsonData = await loadJSONData(fileName);
    jsonData.add(newItem);
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String filePath = '${documentsDir.path}/$fileName.json';
    File file = File(filePath);
    await file.writeAsString(jsonEncode(jsonData));
  }

  updateJSONData(String fileName, Map newItem, Map mapID) async {
    String keyID = mapID.keys.first;
    int iD = mapID[keyID];
    List<dynamic> jsonData = await loadJSONData(fileName);
    jsonData.removeWhere((element) {
      return element[keyID] == iD;
    });
    jsonData.add(newItem);

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String filePath = '${documentsDir.path}/$fileName.json';
    File file = File(filePath);
    await file.writeAsString(jsonEncode(jsonData));
  }

  setJSONFiles() async {

    List fileName = ["Cards", "Transactions", "Users", "Wallets"];
    for (int i = 0; i < fileName.length; i++) {
      List<dynamic> jsonData = await loadJSONDataFromAssets(fileName[i]);
      Directory documentsDir = await getApplicationDocumentsDirectory();
      String filePath = '${documentsDir.path}/${fileName[i]}.json';
      File file = File(filePath);
      await file.writeAsString(jsonEncode(jsonData));
    }
  }
}
