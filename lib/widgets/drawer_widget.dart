import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/providers/theme_providerl.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          children: [
            DrawerHeader(
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColor),
                child: Column(
                  children: [
                    Flexible(
                      child: Image.asset(
                        'assets/images/newspaper.png',
                        height: 60,
                        width: 60,
                      ),
                    ),
                    const VerticalSapcing(height: 20),
                    Flexible(
                        child: Text(
                      'News App',
                      style: GoogleFonts.lobster(
                        textStyle:
                            const TextStyle(fontSize: 20, letterSpacing: 0.6),
                      ),
                    ))
                  ],
                )),
            const VerticalSapcing(height: 20),
            ListTileWidget(label: 'Home', icon: IconlyBold.home, fct: () {}),
            ListTileWidget(
                label: 'Bookmark', icon: IconlyBold.bookmark, fct: () {}),
            const Divider(),
            SwitchListTile(
                value: themeProvider.getDarkTheme,
                title: Text(
                  themeProvider.getDarkTheme ? 'Dark Mode ' : 'Light Mode',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                secondary: Icon(
                  themeProvider.getDarkTheme
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onChanged: (bool value) {
                  themeProvider.setDarkTheme = value;
                }),
          ],
        ),
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.label,
    required this.fct,
    required this.icon,
  });
  final String label;
  final Function fct;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      onTap: () {
        fct();
      },
    );
  }
}
