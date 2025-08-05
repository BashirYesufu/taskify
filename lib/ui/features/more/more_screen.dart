import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../util/provider/providers.dart';
import '../../../data/models/enums/app_theme.dart';
import '../../../util/persistor/data_persistor.dart';
import '../../../util/ui_util/app_text_styles.dart';
import '../../widgets/app_radio_button.dart';
import '../../widgets/app_scaffold.dart';
import '../../widgets/app_views.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasAppBar: false,
      appBarTitle: 'More',
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: FutureBuilder(
                  future: DataPersistor.getLoginUser(), builder: (context, snap){
                return Text(snap.data?.email ?? '', style: AppTextStyles.regular(context),);
              }),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Theme', style: AppTextStyles.bold(context, size: 20),),
                AppCard(
                  wrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RowItemWidget(
                        icon: Icons.swipe_down_rounded,
                        text: 'Appearance',
                        trailingIcon: Icon(Icons.keyboard_arrow_down_sharp, size: 18,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Consumer(
                          builder: (BuildContext context, WidgetRef ref, Widget? child) {
                            final theme = ref.read(themeProvider);
                            return Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: AppRadioButton(
                                      title: 'Light',
                                      active: theme.theme == AppTheme.light,
                                      onChanged: (_)=> theme.setThemeMode(AppTheme.light),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: AppRadioButton(
                                    title: 'Dark',
                                    active: theme.theme == AppTheme.dark,
                                    onChanged: (_)=> theme.setThemeMode(AppTheme.dark),
                                  ),
                                ),
                                Flexible(
                                  child: AppRadioButton(
                                    title: 'System',
                                    active: theme.theme == AppTheme.system,
                                    onChanged: (_)=> theme.setThemeMode(AppTheme.system),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


}


class RowItemWidget extends StatelessWidget {
  const RowItemWidget({
    required this.icon,
    required this.text,
    this.trailingIcon,
    this.textColor,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String text;
  final Widget? trailingIcon;
  final Function()? onTap;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 24,),
                SizedBox(width: 10),
                Text(text, style: AppTextStyles.medium(context, size: 16, color: textColor),)
              ],
            ),
            trailingIcon ?? Icon(Icons.arrow_forward_ios, size: 12,)
          ],
        ),
      ),
    );
  }
}
