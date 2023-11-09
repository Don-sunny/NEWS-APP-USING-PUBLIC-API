import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/inner_screens/serach_screen.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/article_widget.dart';
import 'package:news_app/widgets/empty_screen.dart';
import 'package:page_transition/page_transition.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({super.key});

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  @override
  Widget build(BuildContext context) {
    Color color = Utils(context: context).getColor;
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Bookmarks',
            style: GoogleFonts.lobster(
              textStyle:
                  TextStyle(fontSize: 20, letterSpacing: 0.6, color: color),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: const EmptyNewsWdiget(
            text: 'you didn\'t add anything yer to your bookmarks',
            imagePath: 'assets/images/bookmark.png')
        // ListView.builder(
        //     itemCount: 10,
        //     itemBuilder: (ctx, index) {
        //       return const ArticleWidget();
        //     }),
        );
  }
}
