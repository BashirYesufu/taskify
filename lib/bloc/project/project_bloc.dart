import 'package:rxdart/rxdart.dart';
import 'package:taskify/data/models/reponse/project.dart';
import 'package:taskify/util/persistor/data_persistor.dart';
import '../base/base_bloc.dart';

class ProjectBloc extends BaseBloc {

  final _projectsSubject = BehaviorSubject<List<Project>>();
  final _filteredProjectsSubject = BehaviorSubject<List<Project>>();
  Stream<List<Project>> get projectsResponse => _filteredProjectsSubject.stream;
  void getProjects({bool completed = false}) async {
    try {
      toggleProgress(true);
      await Future.delayed(Duration(milliseconds: 1500)).then((response) async {
        await DataPersistor.getProjects().then((projects){
          List<Project> completedProjects = projects.where((action)=> action.completed == true).toList();
          _projectsSubject.sink.add(completed ? completedProjects : projects);
          _filteredProjectsSubject.sink.add(completed ? completedProjects : projects);
        });
        toggleProgress(false);
      }, onError: (e) {
        _filteredProjectsSubject.sink.addError(e);
        toggleProgress(false);
      });
    } catch (e) {
      _filteredProjectsSubject.sink.addError(e);
    }
  }

  void filterProjects(String filter){
    List<Project> data = _projectsSubject.value;
    if(filter.isEmpty) {
      _filteredProjectsSubject.sink.add(data);
      return;
    }
    List<Project> filteredList = [];
    for (Project item in data) {
      if(item.name?.toLowerCase().contains(filter.toLowerCase()) == true || item.description?.toLowerCase().contains(filter.toLowerCase()) == true){
        filteredList.add(item);
      }
    }
    _filteredProjectsSubject.sink.add(filteredList);
  }

}