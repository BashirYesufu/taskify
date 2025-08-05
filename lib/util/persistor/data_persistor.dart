import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskify/util/persistor/persistor_keys.dart';
import '../../data/models/reponse/project.dart';
import '../../data/models/reponse/user.dart';

class DataPersistor {

  static Future<void> saveProjects(List<Project> data) async {
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

  static Future<void> editProject(Project updatedProject) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cache = prefs.getString(DataPersistorKeys.keyProject);
    if (cache == null) return;
    List<Project> projects = List<Project>.from(
      jsonDecode(cache).map((json) => Project.fromJson(json)),
    );
    int index = projects.indexWhere((project) => project.id == updatedProject.id);
    if (index != -1) {
      updatedProject.updatedAt = DateTime.now();
      projects[index] = updatedProject;
      prefs.setString(DataPersistorKeys.keyProject, jsonEncode(projects.map((e) => e.toJson()).toList()));
    }
  }

  static Future<void> deleteProject(String projectId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final cache = prefs.getString(DataPersistorKeys.keyProject);
    if (cache == null) return;

    List<Project> projects = List<Project>.from(
      jsonDecode(cache).map((json) => Project.fromJson(json)),
    );
    projects.removeWhere((project) => project.id == projectId);
    prefs.setString(DataPersistorKeys.keyProject, jsonEncode(projects.map((e) => e.toJson()).toList()));
  }

  static void saveUser(User? user) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(user==null){
      prefs.remove(DataPersistorKeys.keyUser);
      return;
    }
    String response = jsonEncode(user.toJson());
    prefs.setString(DataPersistorKeys.keyUser, response);
  }

  static Future<User?> getLoginUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(DataPersistorKeys.keyUser);
    if( jsonString==null){
      return null;
    }
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    User response = User.fromJson(jsonMap);
    return response;
  }

  static void saveUserTheme({required String theme}) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(DataPersistorKeys.keyTheme, theme);
  }

  static Future<String> getUserTheme() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(DataPersistorKeys.keyTheme);
    if(value==null){
      return "";
    }
    return value;
  }

}