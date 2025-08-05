import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskify/util/provider/providers/theme_notifier.dart';


final themeProvider = ChangeNotifierProvider<ThemeNotifier>((_) => ThemeNotifier());

