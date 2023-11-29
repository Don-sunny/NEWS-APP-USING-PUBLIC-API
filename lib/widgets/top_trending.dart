import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/inner_screens/blog_details.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/widgets/news_details_webview.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class TopTrendingWidget extends StatelessWidget {
  const TopTrendingWidget({
    super.key,
  });
  // final String url;

  @override
  Widget build(BuildContext context) {
    final size = Utils(context: context).getScreenSize;
    final Color color = Utils(context: context).getColor;
    final newsProvider = Provider.of<NewsModel>(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.0),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                child: const NewsDetailsScreen(),
                type: PageTransitionType.rightToLeft,
                inheritTheme: true,
                ctx: context,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  boxFit: BoxFit.fill,
                  errorWidget: Image.asset('assets/images/empty_image.png'),
                  imageUrl: newsProvider.urlToImage,
                  height: size.height * 0.33,
                  width: double.infinity,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  newsProvider.title,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: const NewsDetailsScreen(),
                            type: PageTransitionType.rightToLeft,
                            inheritTheme: true,
                            ctx: context,
                          ),
                        );
                      },
                      icon: IconButton(
                        icon: const Icon(Icons.link),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: NewsDetailsWebView(url: newsProvider.url),
                              type: PageTransitionType.rightToLeft,
                              inheritTheme: true,
                              ctx: context,
                            ),
                          );
                        },
                      )),
                  const Spacer(),
                  SelectableText(
                    newsProvider.dateToShow,
                    style: GoogleFonts.montserrat(fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
