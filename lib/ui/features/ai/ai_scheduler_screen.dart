import 'package:flutter/material.dart';
import 'package:taskify/bloc/ai/ai_bloc.dart';
import 'package:taskify/bloc/project/project_bloc.dart';
import 'package:taskify/data/models/enums/task_priority.dart';
import 'package:taskify/data/models/reponse/ai_project.dart';
import 'package:taskify/data/models/reponse/project.dart';
import 'package:taskify/ui/features/dashboard/dashboard.dart';
import 'package:taskify/ui/widgets/app_views.dart';
import 'package:taskify/util/extensions/date.dart';
import 'package:taskify/util/extensions/string.dart';
import 'package:taskify/util/ui_util/color/color_manager.dart';
import '../../../util/debouncer.dart';
import '../../../util/helper.dart';
import '../../../util/route/app_router.dart';
import '../../../util/ui_util/app_text_styles.dart';
import '../../../util/ui_util/ui_actions.dart';
import '../../sheets/tasks_sheets.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/app_scaffold.dart';

class AISchedulerScreen extends StatefulWidget {
  const AISchedulerScreen({super.key});
  static const routeName = "/ai-scheduler";

  static void launch(BuildContext context){
    AppRouter.launch(context, routeName: routeName);
  }

  @override
  State<AISchedulerScreen> createState() => _AISchedulerScreenState();
}

class _AISchedulerScreenState extends State<AISchedulerScreen> with TaskDelegate{
  final ProjectBloc _projectBloc = ProjectBloc();
  final AiBloc _aiBloc = AiBloc();
  final TextEditingController _descriptionTC = TextEditingController();
  List<Task> tasks = [];
  AiProject? aiProject;
  Debouncer? debouncer;
  Stream<bool>? loader;

  bindAIBloc(){
    _aiBloc.aiDescriptionResponse.listen((project){
      aiProject = project;
      setState(() {
        tasks = project.tasks?.map((t) => Task(
          id: 'TASK-${Helper.generateSecureId()}',
          completed: false,
          priority: TaskPriority.medium.name.toUpperCase(),
          description: t,
          dueAt: DateTime.now().add(Duration(days: 1)),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        )).toList() ?? [];
      });
    }, onError:(error){
      UIActions.showError(context, message: error);
    });

    _aiBloc.progressStatusObservable.listen((loading){
      setState(() {
        loader = loading ? _aiBloc.progressStatusObservable : null;
      });
    });
  }

  void bindBloc(){
    _projectBloc.createProjectResponse.listen((task){
      UIActions.showSuccessPopup(context, message: 'Project created successfully', onTap: ()=> Dashboard.launch(context),);
    }, onError:(error){
      UIActions.showError(context, message: error);
    });

    _projectBloc.progressStatusObservable.listen((loading){
      setState(() {
        loader = loading ? _projectBloc.progressStatusObservable : null;
      });
    });

  }

  @override
  void initState() {
    debouncer = Debouncer(milliseconds: 500);
    bindBloc();
    bindAIBloc();
    super.initState();
  }

  @override
  void dispose() {
    debouncer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      loadingStream: loader,
      scrollChild: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Jemi-9', style: AppTextStyles.bold(context, size: 24),),
            Text('What would you like me to do today?', style: AppTextStyles.regular(context),),
            AppInputField(
              title: 'Prompt',
              hintText: 'Enter prompt',
              maxLines: 2,
              controller: _descriptionTC,
              onChanged: (text)=> debouncer?.run(()=> _aiBloc.generateAIDescription(description: text)),
            ),
            StreamBuilder<AiProject>(
              stream: _aiBloc.aiDescriptionResponse,
              builder: (context, snapshot) {
                if(snapshot.data != null) {
                  AiProject project = snapshot.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(project.name ?? '', style: AppTextStyles.medium(context),),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(project.description ?? '', style: AppTextStyles.regular(context, secondary: true),),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(tasks.length, (index) =>
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(tasks[index].description?.capFirstLetter() ?? '',
                                          style: AppTextStyles.regular(context, size: 16),),
                                        Text('${tasks[index].priority?.capFirstLetter() ?? ''} Priority',
                                          style: AppTextStyles.bold(
                                              context,
                                              color: tasks[index].priority
                                                  ?.toLowerCase() ==
                                                  TaskPriority.low.name
                                                  ? ColorManager.blue
                                                  : tasks[index].priority
                                                  ?.toLowerCase() ==
                                                  TaskPriority.medium.name
                                                  ? ColorManager.orange
                                                  : ColorManager.green),),
                                        Text('Due on: ${tasks[index].dueAt
                                            ?.formatDateTime() ?? 'N/A'}',
                                          style: AppTextStyles.regular(
                                              context),),

                                      ],
                                    ),
                                  ),
                                  AppRoundedView(
                                    onTap: () {
                                      setState(() {
                                        tasks.removeAt(index);
                                      });
                                    },
                                    size: 20,
                                    color: Colors.red,
                                    child: Icon(Icons.close, size: 12,
                                      color: Colors.white,),
                                  )
                                ],
                              ),
                            )),
                      )
                    ],
                  );
                }
                return SizedBox();
              }
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: AppButton(
            title: 'Create Project',
            onTap: ()=> _projectBloc.createProject(description: aiProject?.description, name: aiProject?.name, tasks: tasks),
          ),
        ),
      ),
    );
  }

  @override
  void proceedWithTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

}
