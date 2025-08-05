import 'package:flutter/material.dart';
import 'package:taskify/ui/widgets/app_date_field.dart';
import '../../data/models/reponse/project.dart';
import '../../util/route/app_router.dart';
import '../../util/ui_util/app_text_styles.dart';
import '../../util/ui_util/ui_actions.dart';
import '../widgets/app_button.dart';

mixin TaskTimeDelegate {
  void rescheduleTask(Task task, DateTime time);
}

class TaskTimeSheet extends StatefulWidget {
  const TaskTimeSheet({required this.delegate, required this.task, super.key});
  final TaskTimeDelegate delegate;
  final Task task;

  static launch(BuildContext context, {required TaskTimeDelegate delegate, required Task task}){
    UIActions.showSheet(
        context,
        height: MediaQuery.of(context).size.height - 200, child: TaskTimeSheet(delegate: delegate, task: task));
  }

  @override
  State<TaskTimeSheet> createState() => _TaskTimeSheetState();
}

class _TaskTimeSheetState extends State<TaskTimeSheet> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reschedule Task', style: AppTextStyles.medium(context, size: 32, weight: FontWeight.w600),),
            AppDateField(
              title: 'Due Date',
              borderColor: Colors.grey.withValues(alpha: 0.2),
              hintText: 'Select new due date',
              controller: TextEditingController(),
              onDateChanged: (date){
                selectedDate = date;
              },
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: AppButton(
                  onTap: (){
                    if(selectedDate != null) {
                      AppRouter.goBack(context);
                      widget.delegate.rescheduleTask(widget.task, selectedDate!);
                    }
                  },
                  title: 'Reschedule',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
