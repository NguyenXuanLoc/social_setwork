import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:social_setwork/screen/article/article_screen.dart';
import 'package:social_setwork/utils/common_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  String url;

  WebPage(this.url);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  double loading = 0;
  bool isLoading = true;

  @override
  void initState() {
    Timer(Duration(milliseconds: 1200), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.share,
                        color: Colors.white,
                        size: 25,
                      ),
                    )
                  ],
                ),
                color: Colors.blueGrey,
              ),
              /*  LinearProgressIndicator(
                value: loading,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),*/
              Builder(
                builder: (_) {
                  if (isLoading)
                    return Expanded(
                        child: Center(
                      child: CircularProgressIndicator(),
                    ));
                  return Expanded(
                      child: Container(
                    child: InAppWebView(
                      initialUrl: widget.url,
                      initialOptions: InAppWebViewGroupOptions(
                        crossPlatform:
                            InAppWebViewOptions(debuggingEnabled: true),
                      ),
                      onLoadStart:
                          (InAppWebViewController controller, String url) {
                        print("TAG: URL: " + url);
                        if (url.contains(
                            "https://m.facebook.com/plugins/close_popup.php")) {
                          CommonUtils.eventBus.fire("reload");
                          Navigator.of(context).pop();
                        }
                      },
                      onLoadStop: (InAppWebViewController controller,
                          String url) async {},
                    ),
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
