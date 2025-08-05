import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/util/persistor/persistor_keys.dart';
import '../../data/models/reponse/project.dart';

class DataPersistor {

  static void saveProjects(List<Project> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(data.isEmpty){
      return;
    }
    final dataJson = jsonEncode(data);
    prefs.setString(DataPersistorKeys.keyProject, dataJson);
  }

  static Future<List<Project>> getProjects() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cache = prefs.getString(DataPersistorKeys.keyProject);
    if(cache == null){
      return [];
    }
    List<Project> jsonData = List<Project>.from(jsonDecode(cache).map((json)=> Project.fromJson(json)));
    return jsonData;
  }

}