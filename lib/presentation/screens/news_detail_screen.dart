// lib/presentation/screens/news_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

import '../../data/models/news_model.dart';

class NewsDetailScreen extends StatelessWidget {
  final NewsModel article;

  NewsDetailScreen({required this.article,});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
          child: WebViewPlus(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              controller.loadUrl(article.url);
            },
          )),
    );
  }
}
