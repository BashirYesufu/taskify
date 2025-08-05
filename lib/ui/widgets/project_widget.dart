import 'package:flutter/material.dart';
import '../../data/models/reponse/project.dart';
import '../../util/ui_util/app_text_styles.dart';
import '../../util/ui_util/color/color_manager.dart';
import 'app_check_box.dart';

class ProjectWidget extends StatefulWidget {
  const ProjectWidget({required this.project, this.onSelected, this.showingDetails = false, super.key});
  final Project project;
  final Function(bool)? onSelected;
  final bool showingDetails;

  @override
  State<ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  Project get project => widget.project;
  num quantity = 0;
  bool get showingDetails => widget.showingDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: showingDetails ? ColorManager.border.withValues(alpha: 0.2) : Colors.transparent,
        border: Border.all(
          color: Colors.transparent
        ),
        borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 showingDetails ? SizedBox() : AppCheckBox(
                    onChanged: (value)=> widget.onSelected?.call(showingDetails),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(project.artist ?? ''),
                      RichText(
                        text: TextSpan(
                          text: 'Ref: ',
                          style: TextStyle(
                            color: ColorManager.border,
                          ),
                          children: [
                            TextSpan(
                              text: project.ticketRef ?? 'ref',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('# ${project.ticketPrice ?? 0.00}'),
                  RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      text: 'Location: ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: project.location ??''
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          showingDetails ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Quantity', style: AppTextStyles.regular(context, weight: FontWeight.w500),),
                  Container(
                    width: 111,
                    height: 48,
                    decoration: BoxDecoration(
                      color: ColorManager.backGround,
                      border: Border.all(color: ColorManager.border),
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            setState(() {
                              if(quantity == 0){return;}
                              quantity -= 1;
                            });
                          },
                          splashFactory: NoSplash.splashFactory,
                          child: Icon(Icons.remove),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text('$quantity', style: AppTextStyles.regular(context),),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              quantity += 1;
                            });
                          },
                          splashFactory: NoSplash.splashFactory,
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ) : SizedBox()
        ],
      ),
    );
  }
}
