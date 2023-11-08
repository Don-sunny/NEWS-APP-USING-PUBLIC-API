import 'package:flutter/material.dart';
import 'package:news_app/providers/theme_providerl.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils({
    required this.context,
  });
  Size get getScreenSize => MediaQuery.of(context).size;

  bool get getTheme => Provider.of<ThemeProvider>(context).getDarkTheme;
  Color get getColor => getTheme ? Colors.white : Colors.black;
}
