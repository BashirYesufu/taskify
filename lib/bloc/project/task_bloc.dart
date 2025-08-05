import 'package:rxdart/rxdart.dart';
import 'package:taskify/data/models/reponse/project.dart';
import 'package:taskify/util/helper.dart';
import '../base/base_bloc.dart';

class TaskBloc extends BaseBloc {

  final _taskSubject = BehaviorSubject<Task>();
  Stream<Task> get taskResponse => _taskSubject.stream;
  void createTask({required String? description, required String? priority, required DateTime? dueDate}) async {
    if(description == null || description.isEmpty){
      _taskSubject.sink.addError('Kindly enter a valid description');
      return;
    }
    if (priority == null || priority.isEmpty){
      _taskSubject.sink.addError('Kindly select a valid priority');
      return;
    }
    if (dueDate == null){
      _taskSubject.sink.addError('Kindly select a valid due date');
      return;
    }
    Task task = Task(
      id: 'TASK-${Helper.generateSecureId()}',
      completed: false,
      priority: priority.toUpperCase(),
      description: description,
      dueAt: dueDate,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _taskSubject.sink.add(task);
  }

}