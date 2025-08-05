import 'package:flutter/material.dart';
import '../../../data/models/local/dashboard_bar_item.dart';
import '../../../util/route/app_router.dart';
import '../../../util/ui_util/app_text_styles.dart';
import '../../../util/ui_util/color_manager.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  static String routeName = '/dashboard';

  void launch(context) {
    AppRouter.launch(context, routeName: routeName);
  }

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: DashboardBarItem.items[selectedIndex].screen),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 62,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(DashboardBarItem.items.length, (index){
            DashboardBarItem item = DashboardBarItem.items[index];
            return InkWell(
              onTap: (){
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(item.icon, color: selectedIndex == index ? ColorManager.green : null,),
                    Text(
                      item.title,
                      style: AppTextStyles.black(weight: selectedIndex == index ? FontWeight.w600 : null, color: selectedIndex == index ? ColorManager.green : null,),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

