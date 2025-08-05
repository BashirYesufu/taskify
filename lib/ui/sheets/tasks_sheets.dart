import 'package:flutter/material.dart';
import 'package:taskify/bloc/project/task_bloc.dart';
import 'package:taskify/data/models/enums/task_priority.dart';
import 'package:taskify/ui/widgets/app_date_field.dart';
import 'package:taskify/ui/widgets/app_picker_field.dart';
import 'package:taskify/util/extensions/string.dart';
import '../../data/models/reponse/project.dart';
import '../../util/route/app_router.dart';
import '../../util/ui_util/app_text_styles.dart';
import '../../util/ui_util/ui_actions.dart';
import '../widgets/app_button.dart';
import '../widgets/app_input_field.dart';

mixin TaskDelegate {
  void proceedWithTask(Task task);
}

class TaskSheet extends StatefulWidget {
  const TaskSheet({required this.delegate, super.key});
  final TaskDelegate delegate;

  static launch(BuildContext context, {required TaskDelegate delegate}){
    UIActions.showSheet(
        context,
        height: MediaQuery.of(context).size.height - 200, child: TaskSheet(delegate: delegate,));
  }

  @override
  State<TaskSheet> createState() => _TaskSheetState();
}

class _TaskSheetState extends State<TaskSheet> {
  final TextEditingController _descriptionTC = TextEditingController();
  final TaskBloc _taskBloc = TaskBloc();
  String? priority;
  DateTime? selectedDate;

  bindBloc(){
    _taskBloc.taskResponse.listen((task){
      AppRouter.goBack(context);
      widget.delegate.proceedWithTask(task);
    }, onError:(error){
      UIActions.showError(context, message: error);
    });
  }


  @override
  void initState() {
    bindBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task', style: AppTextStyles.medium(context, size: 32, weight: FontWeight.w600),),
            AppInputField(
              title: 'Task Description',
              hintText: 'Enter description',
              maxLines: 2,
              borderColor: Colors.grey.withValues(alpha: 0.2),
              controller: _descriptionTC,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: AppPickerField(
                title: 'Task Priority',
                hintText: 'Select priority',
                onChanged: (dynamic priority) {
                  this.priority = priority;
                },
                items: TaskPriority.values.map((task)=> task.name.capFirstLetter()).toList(),
              ),
            ),
            AppDateField(
              title: 'Due Date',
              borderColor: Colors.grey.withValues(alpha: 0.2),
              hintText: 'Select due date',
              controller: TextEditingController(),
              onDateChanged: (date){
                selectedDate = date;
              },
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: AppButton(
                  onTap: ()=> _taskBloc.createTask(description: _descriptionTC.text, priority: priority, dueDate: selectedDate),
                  title: 'Add Task',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
