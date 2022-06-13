import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  WebViewScreen(this.title, this.url);
  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WebviewScaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        url: widget.url,
      ),
    );
  }
}
