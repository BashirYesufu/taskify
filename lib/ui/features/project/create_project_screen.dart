import 'package:flutter/material.dart';
import 'package:taskify/bloc/project/project_bloc.dart';
import 'package:taskify/data/models/enums/task_priority.dart';
import 'package:taskify/data/models/reponse/project.dart';
import 'package:taskify/ui/features/dashboard/dashboard.dart';
import 'package:taskify/ui/widgets/app_views.dart';
import 'package:taskify/util/extensions/date.dart';
import 'package:taskify/util/extensions/string.dart';
import 'package:taskify/util/ui_util/color/color_manager.dart';
import '../../../util/route/app_router.dart';
import '../../../util/ui_util/app_text_styles.dart';
import '../../../util/ui_util/ui_actions.dart';
import '../../sheets/tasks_sheets.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/app_scaffold.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});
  static const routeName = "/create-project";

  static void launch(BuildContext context){
    AppRouter.launch(context, routeName: routeName);
  }

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> with TaskDelegate{
  final ProjectBloc _projectBloc = ProjectBloc();
  final TextEditingController _nameTC = TextEditingController();
  final TextEditingController _descriptionTC = TextEditingController();
  List<Task> tasks = [];

  void bindBloc(){
    _projectBloc.createProjectResponse.listen((task){
      UIActions.showSuccessPopup(context, message: 'Project created successfully', onTap: ()=> Dashboard.launch(context),);
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
    return AppScaffold(
      loadingStream: _projectBloc.progressStatusObservable,
      scrollChild: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('New Project', style: AppTextStyles.bold(context, size: 24),),
            Text('Track your work with a project and tasks', style: AppTextStyles.regular(context),),
            AppInputField(
              title: 'Project Name',
              hintText: 'Enter project name',
              padding: EdgeInsets.symmetric(vertical: 20),
              controller: _nameTC,
            ),
            AppInputField(
              title: 'Project Description',
              hintText: 'Enter project description',
              maxLines: 2,
              controller: _descriptionTC,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Text('Tasks', style: AppTextStyles.medium(context),),
                    AppRoundedView(
                      size: 50,
                      onTap: ()=> TaskSheet.launch(context, delegate: this),
                      color: ColorManager.green,
                      child: Icon(Icons.add, color: Colors.white,),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(tasks.length, (index)=> Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tasks[index].description?.capFirstLetter() ?? '', style: AppTextStyles.regular(context, size: 16),),
                              Text('${tasks[index].priority?.capFirstLetter() ?? ''} Priority',
                                style: AppTextStyles.bold(
                                    context,
                                    color: tasks[index].priority?.toLowerCase() == TaskPriority.low.name
                                        ? ColorManager.blue
                                        : tasks[index].priority?.toLowerCase() == TaskPriority.medium.name ? ColorManager.orange : ColorManager.green),),
                              Text('Due on: ${tasks[index].dueAt?.formatDateTime() ?? 'N/A'}', style: AppTextStyles.regular(context),),

                            ],
                          ),
                        ),
                        AppRoundedView(
                          onTap: (){
                            setState(() {
                              tasks.removeAt(index);
                            });
                          },
                          size: 20,
                          color: Colors.red,
                          child: Icon(Icons.close, size: 12, color: Colors.white,),
                        )
                      ],
                    ),
                  )),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: AppButton(
              title: 'Create Project',
              onTap: ()=> _projectBloc.createProject(description: _descriptionTC.text, name: _nameTC.text, tasks: tasks),
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
