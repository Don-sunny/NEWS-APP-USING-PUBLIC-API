import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsWebView extends StatefulWidget {
  const NewsDetailsWebView({super.key});

  @override
  State<NewsDetailsWebView> createState() => _NewsDetailsWebViewState();
}

class _NewsDetailsWebViewState extends State<NewsDetailsWebView> {
  static double pro = 0;
  Connectivity connectivity = Connectivity();
  WebViewController controller = WebViewController()
    ..enableZoom(true)
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://github.com/NaimurNoyon/WebView_App'));

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context: context).getColor;
    controller
        .setNavigationDelegate(NavigationDelegate(onProgress: (int progress) {
      setState(() {
        pro = progress / 100;
      });
    }));
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: color),
          centerTitle: true,
          title: Text(
            'https://github.com/NaimurNoyon/WebView_App',
            style: TextStyle(color: color),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz),
            )
          ],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: double.tryParse(pro.toString()),
              color: pro == 1.0 ? Colors.transparent : Colors.blue,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            Expanded(
              child: WebViewWidget(controller: controller),
            )
          ],
        ),
      ),
    );
  }
}
