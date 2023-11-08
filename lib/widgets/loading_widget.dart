import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/consts/vars.dart';
import 'package:news_app/services/utils.dart';
import 'package:news_app/widgets/vertical_spacing.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  BorderRadius borderRadius = BorderRadius.circular(18);
  late Color baseShimmerColor, highlightShimerColor, widgetShimmerColor;

  @override
  void didChangeDependencies() {
    var utils = Utils(context: context);

    baseShimmerColor = utils.baseShimmerColor;
    highlightShimerColor = utils.highlightShimmerColor;
    widgetShimmerColor = utils.widgetShimmerColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context: context).getScreenSize;
    return Expanded(
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (ctx, index) {
            return ArticleShimmerEffectsWidget(
                baseShimmerColor: baseShimmerColor,
                highlightShimerColor: highlightShimerColor,
                size: size,
                widgetShimmerColor: widgetShimmerColor,
                borderRadius: borderRadius);
          }),
    );
  }
}

class ArticleShimmerEffectsWidget extends StatelessWidget {
  const ArticleShimmerEffectsWidget({
    super.key,
    required this.baseShimmerColor,
    required this.highlightShimerColor,
    required this.size,
    required this.widgetShimmerColor,
    required this.borderRadius,
  });

  final Color baseShimmerColor;
  final Color highlightShimerColor;
  final Size size;
  final Color widgetShimmerColor;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor,
        child: Stack(
          children: [
            Container(
              height: 60,
              width: 60,
              color: Theme.of(context).colorScheme.secondary,
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                width: 60,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Container(
              color: Theme.of(context).cardColor,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(10.0),
              child: Shimmer.fromColors(
                baseColor: baseShimmerColor,
                highlightColor: highlightShimerColor,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: size.height * 0.12,
                        width: size.height * 0.12,
                        color: widgetShimmerColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.08,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: borderRadius,
                            color: widgetShimmerColor,
                          ),
                        ),
                        const VerticalSapcing(
                          height: 5,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: size.height * 0.025,
                            width: size.width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              color: widgetShimmerColor,
                            ),
                          ),
                        ),
                        FittedBox(
                          child: Row(
                            children: [
                              ClipOval(
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                height: size.height * 0.025,
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                  borderRadius: borderRadius,
                                  color: widgetShimmerColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
