import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  WebViewApp({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _WebViewAppState createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  WebViewController _controller;
  Future<void> loadHtmlFromAssets(String filename, controller) async {
    String fileText = await rootBundle.loadString(filename);
    controller.loadUrl(Uri.dataFromString(fileText,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
  Future<String> loadLocal() async {
    return await rootBundle.loadString('assets/about_us.html');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("widget.title"),
      ),
      body: FutureBuilder<String>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return WebView(
              initialUrl:
              new Uri.dataFromString("https://twitter.com", mimeType: 'text/html')
                  .toString(),
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: <JavascriptChannel>[
                JavascriptChannel(
                    name: 'MessageInvoker',
                    onMessageReceived: (s) {
                      // Scaffold.of(context).showSnackBar(SnackBar(
                      //   content: Text(s.message),
                      // ));
                    }),
              ].toSet(),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}