import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/services/utils.dart';

import 'package:news_app/widgets/drawer_widget.dart';
import 'package:news_app/widgets/tabs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newType = NewsType.allNews;
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
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TabWidget(
                      text: 'All news',
                      color: newType == NewsType.allNews
                          ? Theme.of(context).cardColor
                          : Colors.transparent,
                      function: () {
                        if (newType == NewsType.allNews) {
                          return;
                        }
                        setState(() {
                          newType = NewsType.allNews;
                        });
                      },
                      fontSize: newType == NewsType.allNews ? 22 : 14),
                  const SizedBox(
                    width: 25,
                  ),
                  TabWidget(
                      text: 'Top Trending ',
                      color: newType == NewsType.topTrending
                          ? Theme.of(context).cardColor
                          : Colors.transparent,
                      function: () {
                        if (newType == NewsType.topTrending) {
                          return;
                        }
                        setState(() {
                          newType = NewsType.topTrending;
                        });
                      },
                      fontSize: newType == NewsType.topTrending ? 22 : 14)
                ],
              ),
            )
          ],
        ),
        drawer: const DrawerWidget(),
      ),
    );
  }
}
