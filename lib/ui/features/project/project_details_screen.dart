import 'package:flutter/material.dart';
import 'package:taskify/bloc/project/project_bloc.dart';
import 'package:taskify/data/models/reponse/project.dart';
import 'package:taskify/ui/features/dashboard/dashboard.dart';
import 'package:taskify/ui/widgets/project_card.dart';
import 'package:taskify/ui/widgets/task_card.dart';
import 'package:taskify/util/ui_util/app_text_styles.dart';
import '../../../util/route/app_router.dart';
import '../../../util/ui_util/ui_actions.dart';
import '../../widgets/app_scaffold.dart';

class ProjectDetailsScreen extends StatefulWidget {
  const ProjectDetailsScreen({required this.project, super.key,});
  final Project project;
  static const routeName = "/project-details";

  static launch(BuildContext context, {required Project project}) {
    AppRouter.launch(context, routeName: routeName, arguments: project);
  }

  @override
  State<ProjectDetailsScreen> createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> with ProceedDelegate{
  final ProjectBloc _projectBloc = ProjectBloc();
  Project? project;

  void bindProjectBloc(){
    _projectBloc.getProjectById(projectId: widget.project.id);

    _projectBloc.getProjectByIdResponse.listen((project){
     setState(() {
       this.project = project;
     });
    }, onError:(error){
      UIActions.showError(context, message: error);
    });

    _projectBloc.markTaskAsDoneResponse.listen((project){
      setState(() {
        this.project = project;
      });
    }, onError:(error){
      UIActions.showError(context, message: error);
    });

    _projectBloc.deleteProjectSubjectResponse.listen((project){
      Dashboard.launch(context);
    }, onError:(error){
      UIActions.showError(context, message: error);
    });
  }

  @override
  void initState() {
    bindProjectBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: 'Project Details',
      trailing: [
        InkWell(
          onTap: ()=> UIActions.showPriSecPopup(context, message: 'Are you sure you want to delete this project?', onTap: ()=> _projectBloc.deleteProject(projectId: project?.id)),
            child: Text('Delete', style: AppTextStyles.medium(context, color: Colors.red),)),
        SizedBox(width: 16,)
      ],
      loadingStream: _projectBloc.progressStatusObservable,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: project != null ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProjectCard(project: project!, canViewDetails: false,),
            Text('Tasks', style: AppTextStyles.bold(context),),
            Expanded(child: ListView.builder(
              itemCount: project?.tasks?.length,
                itemBuilder: (context, index){
                Task task = project!.tasks![index];
                return TaskCard(task: task, delegate: this,);
              }
            ))
          ],
        ) : SizedBox(),
      ),
    );
  }

  @override
  void markAsDone(Task task) {
    _projectBloc.markTaskAsDone(projectId: project?.id, taskId: task.id);
  }

  @override
  void reschedule(Task task) {
    // TODO: implement reschedule
  }

}
