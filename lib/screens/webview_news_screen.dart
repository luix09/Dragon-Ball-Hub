import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DisplayNewsScreen extends StatelessWidget {
  final String urlPage;
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  DisplayNewsScreen({required this.urlPage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: urlPage,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
