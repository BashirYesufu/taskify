import 'package:flutter/cupertino.dart';
import '../../../data/models/enums/app_theme.dart';
import '../../persistor/data_persistor.dart';

class ThemeNotifier extends ChangeNotifier {

  AppTheme _themeMode = AppTheme.system;
  AppTheme get theme => _themeMode;

  ThemeNotifier() {
    getTheme();
  }

  Future<AppTheme> getTheme()async {
    String theme = await DataPersistor.getUserTheme();
    switch (theme) {
      case 'LIGHT':{
        _themeMode = AppTheme.light;
        return AppTheme.light;
      }
      case 'DARK':{
        _themeMode = AppTheme.dark;
        return AppTheme.dark;
      }
      default: {
        _themeMode = AppTheme.system;
        return AppTheme.system;
      }
    }
  }

  void setThemeMode (AppTheme theme){
    DataPersistor.saveUserTheme(theme: theme.name.toUpperCase());
    _themeMode = theme;
    notifyListeners();
  }

}