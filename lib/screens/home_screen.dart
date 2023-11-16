import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/inner_screens/serach_screen.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/news_api.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/article_widget.dart';
import 'package:news_app/widgets/drawer_widget.dart';
import 'package:news_app/widgets/empty_screen.dart';
import 'package:news_app/widgets/loading_widget.dart';
import 'package:news_app/widgets/tabs.dart';
import 'package:news_app/widgets/top_trending.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newType = NewsType.allNews;
  int currentPageIndex = 0;
  String sortBy = SortByEnum.publishedAt.name;
  // List<NewsModel> newsList = [];

  @override
  void didChangeDependencies() {
    getNewsList();
    super.didChangeDependencies();
  }

  Future<List<NewsModel>> getNewsList() async {
    List<NewsModel> newsList = await NewsAPiServices.getAllNews();
    return newsList;

    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final color = Utils(context: context).getColor;
    Size size = Utils(context: context).getScreenSize;
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
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: const SearchScreen(),
                    type: PageTransitionType.rightToLeft,
                    inheritTheme: true,
                    ctx: context,
                  ),
                );
              },
              icon: const Icon(
                IconlyLight.search,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
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
              const VerticalSapcing(height: 10),
              newType == NewsType.topTrending
                  ? Container()
                  : SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          paginationButtons(
                              function: () {
                                if (currentPageIndex == 0) {
                                  return;
                                }
                                setState(() {
                                  currentPageIndex--;
                                });
                              },
                              text: 'Prev'),
                          Flexible(
                            flex: 2,
                            child: ListView.builder(
                                itemCount: 10,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Material(
                                      color: currentPageIndex == index
                                          ? Colors.blue
                                          : Theme.of(context).cardColor,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            currentPageIndex = index;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                              child: Text('${index + 1}')),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          paginationButtons(
                              function: () {
                                if (currentPageIndex == 9) {
                                  return;
                                }
                                setState(() {
                                  currentPageIndex++;
                                });
                              },
                              text: 'Next'),
                        ],
                      ),
                    ),
              const VerticalSapcing(
                height: 10,
              ),
              newType == NewsType.topTrending
                  ? Container()
                  : Align(
                      alignment: Alignment.topRight,
                      child: Material(
                        color: Theme.of(context).cardColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: DropdownButton(
                              value: sortBy,
                              items: dropDownItems,
                              onChanged: (String? value) {
                                setState(() {
                                  sortBy = value!;
                                });
                              }),
                        ),
                      ),
                    ),
              FutureBuilder<List<NewsModel>>(
                  future: getNewsList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingWidget(
                        newsType: newType,
                      );
                    } else if (snapshot.hasError) {
                      return Expanded(
                          child: EmptyNewsWdiget(
                        text: 'an error occured ${snapshot.error}',
                        imagePath: 'assets/images/no_news.png',
                      ));
                    } else if (snapshot.data == null) {
                      return Expanded(
                          child: EmptyNewsWdiget(
                        text: 'an error occured ${snapshot.error}',
                        imagePath: 'assets/images/no_news.png',
                      ));
                    }
                    return newType == NewsType.allNews
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (ctx, index) {
                                return ArticleWidget(
                                    imageUrl: snapshot.data![index].urlToImage);
                              },
                            ),
                          )
                        : SizedBox(
                            height: size.height * 0.6,
                            child: Swiper(
                              autoplay: true,
                              autoplayDelay: 8000,
                              itemWidth: size.width * 0.9,
                              layout: SwiperLayout.STACK,
                              viewportFraction: 0.9,
                              itemCount: 5,
                              itemBuilder: (ctx, index) {
                                return const TopTrendingWidget();
                              },
                            ),
                          );
                  })
              //
            ],
          ),
        ),
        drawer: const DrawerWidget(),
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropDownItems {
    List<DropdownMenuItem<String>> menuItem = [
      DropdownMenuItem(
        value: SortByEnum.relevency.name,
        child: Text(SortByEnum.relevency.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.popularity.name,
        child: Text(SortByEnum.popularity.name),
      ),
      DropdownMenuItem(
        value: SortByEnum.publishedAt.name,
        child: Text(SortByEnum.publishedAt.name),
      )
    ];
    return menuItem;
  }

  Widget paginationButtons({required Function function, required String text}) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.all(6.0),
          textStyle:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      child: Text(text),
    );
  }
}
