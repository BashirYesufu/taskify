import 'package:flutter/material.dart';
import 'package:taskify/data/models/reponse/project.dart';
import 'package:taskify/ui/widgets/project_card.dart';
import '../../../util/route/app_router.dart';
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

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  Project get project => widget.project;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: 'Project Details',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            ProjectCard(project: project, canViewDetails: false,),
            Expanded(child: ListView.builder(
              itemCount: project.tasks?.length,
                itemBuilder: (context, index){
                Task? task = project.tasks?[index];
                return Column(
                  children: [
                    Text(task?.description ?? '')

                  ],
                );
              }
            ))
          ],
        ),
      ),
    );
  }
}
