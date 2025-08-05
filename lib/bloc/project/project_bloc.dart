import 'package:rxdart/rxdart.dart';
import 'package:taskify/data/models/reponse/project.dart';
import 'package:taskify/util/persistor/data_persistor.dart';
import '../../util/helper.dart';
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

  final _createProjectSubject = BehaviorSubject<Project>();
  Stream<Project> get createProjectResponse => _createProjectSubject.stream;
  void createProject({required String? description, required String? name, required List<Task> tasks}) async {
    if (name == null || name.isEmpty){
      _createProjectSubject.sink.addError('Kindly enter a valid project name');
      return;
    }
    if(description == null || description.isEmpty){
      _createProjectSubject.sink.addError('Kindly enter a valid project description');
      return;
    }
    if(tasks.isEmpty){
      _createProjectSubject.sink.addError('Kindly enter at least one task');
      return;
    }
    toggleProgress(true);
    await Future.delayed(Duration(milliseconds: 1500)).then((onValue){
      Project project = Project(
          id: 'PROJECT-${Helper.generateSecureId()}',
          completed: false,
          name: name,
          description: description,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          tasks: tasks
      );
      toggleProgress(false);
      DataPersistor.addProject(project);
      _createProjectSubject.sink.add(project);
    });
  }

  final _getProjectByIdSubject = BehaviorSubject<Project?>();
  Stream<Project?> get getProjectByIdResponse => _getProjectByIdSubject.stream;
  void getProjectById({required String? projectId}) async {
    if (projectId == null || projectId.isEmpty){
      _getProjectByIdSubject.sink.addError('Invalid project id');
      return;
    }
    toggleProgress(true);
    await Future.delayed(Duration(milliseconds: 1500)).then((onValue) async {
      toggleProgress(false);
      await DataPersistor.getProjectById(projectId).then((project){
        _getProjectByIdSubject.sink.add(project);
      });
    });
  }

  final _markTaskAsDoneSubject = BehaviorSubject<Project?>();
  Stream<Project?> get markTaskAsDoneResponse => _markTaskAsDoneSubject.stream;
  void markTaskAsDone({required String? projectId, required String? taskId}) async {
    if (projectId == null || projectId.isEmpty){
      _markTaskAsDoneSubject.sink.addError('Invalid project id');
      return;
    }
    if (taskId == null || taskId.isEmpty){
      _markTaskAsDoneSubject.sink.addError('Invalid task id');
      return;
    }
    toggleProgress(true);
    await Future.delayed(Duration(milliseconds: 1500)).then((onValue) async {
      toggleProgress(false);
      await DataPersistor.markTaskAsDone(projectId, taskId).then((project){
        _markTaskAsDoneSubject.sink.add(project);
      });
    });
  }

  final _rescheduleTaskSubject = BehaviorSubject<Project?>();
  Stream<Project?> get rescheduleTaskResponse => _rescheduleTaskSubject.stream;
  void rescheduleTask({required String? projectId, required String? taskId, required DateTime? dueDate}) async {
    if (projectId == null || projectId.isEmpty){
      _rescheduleTaskSubject.sink.addError('Invalid project id');
      return;
    }
    if (taskId == null || taskId.isEmpty){
      _rescheduleTaskSubject.sink.addError('Invalid task id');
      return;
    }
    if (dueDate == null){
      _rescheduleTaskSubject.sink.addError('Invalid due date');
      return;
    }
    toggleProgress(true);
    await Future.delayed(Duration(milliseconds: 1500)).then((onValue) async {
      toggleProgress(false);
      await DataPersistor.rescheduleTask(projectId, taskId, dueDate).then((project){
        _rescheduleTaskSubject.sink.add(project);
      });
    });
  }

  final _deleteProjectSubject = BehaviorSubject<bool>();
  Stream<bool> get deleteProjectSubjectResponse => _deleteProjectSubject.stream;
  void deleteProject({required String? projectId}) async {
    if (projectId == null || projectId.isEmpty){
      _deleteProjectSubject.sink.addError('Invalid project id');
      return;
    }
    toggleProgress(true);
    await Future.delayed(Duration(milliseconds: 1500)).then((onValue) async {
      toggleProgress(false);
      await DataPersistor.deleteProject(projectId).then((project){
        _deleteProjectSubject.sink.add(true);
      });
    });
  }

}