import 'package:flutter/material.dart';
import 'package:news_app/providers/theme_providerl.dart';
import 'package:news_app/widgets/drawer_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Center(
          child: SwitchListTile(
              value: themeProvider.getDarkTheme,
              title: Text(
                  themeProvider.getDarkTheme ? 'Dark Mode ' : 'Light Mode'),
              secondary: Icon(
                themeProvider.getDarkTheme ? Icons.dark_mode : Icons.light_mode,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onChanged: (bool value) {
                themeProvider.setDarkTheme = value;
              }),
        ),
        drawer: const DrawerWidget(),
      ),
    );
  }
}
