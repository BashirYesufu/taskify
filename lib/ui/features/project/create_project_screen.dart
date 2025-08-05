import 'package:flutter/material.dart';
import '../../../util/route/app_router.dart';
import '../../../util/ui_util/app_text_styles.dart';
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

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final TextEditingController _idTC = TextEditingController();
  final TextEditingController _nameTC = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scrollChild: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('New Project', style: AppTextStyles.bold(context, size: 24),),
            Text('Track your work with a project and tasks', style: AppTextStyles.regular(context),),
            AppInputField(
              title: 'Property Id',
              hintText: 'Enter property id',
              textCapitalization: TextCapitalization.characters,
              padding: EdgeInsets.symmetric(vertical: 20),
              controller: _idTC,
            ),
            AppInputField(
              title: 'Property Name',
              hintText: 'Enter Property name',
              controller: _nameTC,
            ),
            AppButton(
              title: 'Add Property',

            ),
          ],
        ),
      ),
    );
  }

}
