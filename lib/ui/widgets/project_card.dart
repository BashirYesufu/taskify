import 'package:flutter/material.dart';
import 'package:taskify/ui/features/project/project_details_screen.dart';
import 'package:taskify/util/extensions/date.dart';
import 'package:taskify/util/ui_util/color/color_manager.dart';
import '../../data/models/reponse/project.dart';
import '../../util/ui_util/app_text_styles.dart';
import 'app_views.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({required this.project, this.canViewDetails = true, super.key});
  final Project project;
  final bool canViewDetails;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  Project get project => widget.project;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      wrap: true,
      onTap:()=> widget.canViewDetails ? ProjectDetailsScreen.launch(context, project: project) : null,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: Text(project.name ?? '', style: AppTextStyles.medium(context, size: 16),)),
              Text('${project.tasks?.length ?? 0} Task${(project.tasks?.length ?? 0)> 1 ? 's' : ''}', style: AppTextStyles.bold(context, color: project.completed == true ? ColorManager.green : ColorManager.orange),),
            ],
          ),
          Flexible(child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(project.description ?? '', style: AppTextStyles.regular(context, size: 12, secondary: true),),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Created: ${project.createdAt?.formatDateTime() ?? ''}', style: AppTextStyles.regular(context, size: 12),),
              Text(project.id ??'', style: AppTextStyles.regular(context, size: 12, secondary: true),),
            ],
          ),
        ],
      ),
    );
  }
}
