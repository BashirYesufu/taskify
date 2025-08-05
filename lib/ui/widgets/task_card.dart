import 'package:flutter/material.dart';
import 'package:taskify/ui/widgets/app_button.dart';
import 'package:taskify/util/extensions/date.dart';
import 'package:taskify/util/extensions/string.dart';
import '../../data/models/enums/task_priority.dart';
import '../../data/models/reponse/project.dart';
import '../../util/ui_util/app_text_styles.dart';
import '../../util/ui_util/color/color_manager.dart';
import 'app_views.dart';

mixin ProceedDelegate {
  void markAsDone(Task task);
  void reschedule(Task task);
}

class TaskCard extends StatelessWidget {
  const TaskCard({required this.task, required this.delegate, super.key});
  final Task task;
  final ProceedDelegate delegate;
  bool get isDue => task.dueAt?.isAfter(DateTime.now()) ?? false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.description?.capFirstLetter() ?? '', style: AppTextStyles.regular(context, size: 16),),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text('Due: ${task.dueAt?.formatDateTime() ?? ''}', style: AppTextStyles.regular(context, size: 16),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${task.priority?.capFirstLetter() ?? ''} Priority',
                style: AppTextStyles.bold(
                  context,
                  color: task.priority?.toLowerCase() == TaskPriority.low.name
                      ? ColorManager.blue
                      : task.priority?.toLowerCase() == TaskPriority.medium.name
                      ? ColorManager.orange
                      : ColorManager.green,
                ),
              ),
              task.completed == true ? AppRoundedView(
                size: 20,
                color: ColorManager.green,
                child: Icon(Icons.check, size: 12, color: Colors.white,),
              ) : SizedBox(
                width: !isDue ? 160 : 100,
                child: AppButton(
                  title: !isDue ? 'Suggest New Time' : 'Done',
                  onTap: ()=> !isDue ? delegate.reschedule(task) : delegate.markAsDone(task),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
