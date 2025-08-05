import 'package:flutter/material.dart';
import 'package:taskify/bloc/dashboard/dashboard_bloc.dart';
import 'package:taskify/bloc/project/project_bloc.dart';
import 'package:taskify/data/models/reponse/project.dart';
import 'package:taskify/ui/features/ai/ai_scheduler_screen.dart';
import 'package:taskify/ui/features/project/create_project_screen.dart';
import 'package:taskify/ui/widgets/app_scaffold.dart';
import 'package:taskify/ui/widgets/project_card.dart';
import 'package:taskify/util/ui_util/color/color_manager.dart';
import '../../../util/ui_util/app_text_styles.dart';
import '../../widgets/app_views.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DashboardBloc _dashboardBloc = DashboardBloc.sharedInstance;
  final ProjectBloc _projectBloc = ProjectBloc();

  void bindProjectBloc(){
    _projectBloc.getProjects();
  }

  @override
  void initState() {
    bindProjectBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasAppBar: false,
      loadingStream: _projectBloc.progressStatusObservable,
      body: Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Overview', style: AppTextStyles.medium(context),),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Flexible(
                        child: AppCard(
                          height: 90,
                          padding: EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StreamBuilder<List<Project>>(
                                  stream: _projectBloc.projectsResponse,
                                  builder: (context, snapshot) {
                                    return Text('${snapshot.data?.length ?? 0}', style: AppTextStyles.bold(context, size: 24),);
                                  }
                              ),
                              Text('Total Projects', style: AppTextStyles.regular(context, secondary: true),),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: AppCard(
                          height: 90,
                          onTap: ()=> AISchedulerScreen.launch(context),
                          padding: EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Jemi AI', style: AppTextStyles.bold(context, size: 24),),
                                  Icon(Icons.keyboard_arrow_right),
                                ],
                              ),
                              Text('Intelligent scheduler', style: AppTextStyles.regular(context, secondary: true),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Projects', style: AppTextStyles.medium(context),),
                      InkWell(
                        onTap: ()=> _dashboardBloc.navigateToTab(1),
                        child: Text('View all', style: AppTextStyles.medium(context, color: ColorManager.green),),),
                    ],
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: StreamBuilder<List<Project>>(
                        stream: _projectBloc.projectsResponse,
                        builder: (context, snapshot) {
                          if(snapshot.data?.isNotEmpty == true) {
                            return Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: (snapshot.data?.length ?? 0) > 5 ? 5 : snapshot.data?.length,
                                  itemBuilder: (context, index)=> ProjectCard(project: snapshot.data![index]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 12.0, right: 12),
                                  child: AppRoundedView(
                                    size: 58,
                                    onTap: ()=> CreateProjectScreen.launch(context),
                                    color: ColorManager.of(context).mainBackgroundInverted,
                                    child: Icon(Icons.add, color: ColorManager.of(context).mainBackground, size: 32,),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('No projects created yet',
                                      style: AppTextStyles.bold(context, size: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                      child: Text(
                                        'Start by adding your first property using the unique property id.',
                                        style: AppTextStyles.regular(context, secondary: true, size: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    AppCard(
                                      wrap: true,
                                      onTap: ()=> CreateProjectScreen.launch(context),
                                      backgroundColor: ColorManager.of(context).mainBackgroundInverted,
                                      borderColor: ColorManager.of(context).mainBackgroundInverted,
                                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.add, color: ColorManager.of(context).mainBackground, size: 30,),
                                          SizedBox(width: 6),
                                          Text('Create a project',
                                            style: AppTextStyles.bold(
                                                context,
                                                color: ColorManager.of(context).mainBackground,
                                                size: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
