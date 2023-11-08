import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/services/utils.dart';

import 'package:news_app/widgets/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Utils(context: context).getColor;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'News App',
            style: GoogleFonts.lobster(
              textStyle:
                  TextStyle(fontSize: 20, letterSpacing: 0.6, color: color),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(IconlyLight.search),
            )
          ],
        ),
        body: Center(child: Container()),
        drawer: const DrawerWidget(),
      ),
    );
  }
}
