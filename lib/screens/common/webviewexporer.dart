import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExplorer extends StatefulWidget {
  final url;

  WebViewExplorer({
    Key key,
    @required this.url
    }) : super(key: key);

  _WebViewExplorerState createState() => _WebViewExplorerState();
}

class _WebViewExplorerState extends State<WebViewExplorer> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Webview"),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController){
          _controller.complete(webViewController);
        },
      ),
    );
  }
}