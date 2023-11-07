import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news_app/widgets/vertical_spacing.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
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
                    const Flexible(child: Text('News App'))
                  ],
                )),
            const VerticalSapcing(height: 20),
            ListTiles(label: 'Home', icon: IconlyBold.home, fct: () {}),
            ListTiles(label: 'Bookmark', icon: IconlyBold.bookmark, fct: () {}),
            const Divider()
          ],
        ),
      ),
    );
  }
}

class ListTiles extends StatelessWidget {
  const ListTiles({
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
      leading: Icon(icon),
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
