import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskify/bloc/project/project_bloc.dart';
import 'package:taskify/ui/widgets/project_card.dart';

import '../../../data/models/reponse/project.dart';
import '../../../util/ui_util/app_text_styles.dart';
import '../../../util/ui_util/color/color_manager.dart';
import '../../widgets/app_input_field.dart';
import '../../widgets/app_scaffold.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  TextEditingController searchController = TextEditingController();
  final ProjectBloc _projectBloc = ProjectBloc();

  @override
  void initState() {
    bindBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        hasAppBar: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              AppInputField(
                hintText: 'Search project',
                onChanged: (text)=> _projectBloc.filterProjects(text),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _projectBloc.projectsResponse,
                  builder: (context, indexSnapshot) {
                    if (indexSnapshot.hasData && indexSnapshot.data?.isNotEmpty == true) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          Project project = indexSnapshot.data![index];
                          return ProjectCard(project: project,);
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: indexSnapshot.data?.length,
                      );
                    }
                    if (indexSnapshot.hasData && indexSnapshot.data?.isEmpty == true) {
                      return Center(
                        child: Text(
                          'No projects found',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.regular(context, size: 12),
                        ),
                      );
                    }
                    if (indexSnapshot.hasError) {
                      return Center(
                        child: Text(
                          indexSnapshot.error.toString(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.regular(context, size: 12, color: Colors.red),
                        ),
                      );
                    }
                    else {
                      return Center(
                        child: CupertinoActivityIndicator(
                          color: ColorManager.of(context).textMain,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        )
    );
  }

  void bindBloc() async {
    _projectBloc.getProjects();
  }

}
