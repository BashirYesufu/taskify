import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/util/provider/providers.dart';
import 'package:taskify/util/route/route_handler.dart';
import 'package:taskify/util/ui_util/theme/theme_manager.dart';
import 'data/models/enums/app_theme.dart';

class App extends StatefulWidget {

  App({super.key});

  static final sharedInstance = App();
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, _) {
        var themePro = ref.watch(themeProvider);
        return MaterialApp(
          title: 'Taskify',
          navigatorKey: App.navigatorKey,
          debugShowCheckedModeBanner: false,
          themeMode: themePro.theme == AppTheme.light
              ? ThemeMode.light
              : themePro.theme == AppTheme.dark
              ? ThemeMode.dark
              : ThemeMode.system,
          darkTheme: ThemeManager.sharedInstance.darkTheme,
          theme: ThemeManager.sharedInstance.theme,
          routes: RouteHandler.routes,
          initialRoute: RouteHandler.initialRoute,
          onGenerateRoute: RouteHandler.onGenerateRoute,
        );
      },
    );
  }

}