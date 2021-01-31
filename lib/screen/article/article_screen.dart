import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:social_setwork/model/article_model.dart';
import 'package:social_setwork/screen/article/article_interactor.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  ArticleModel model;
  bool _isLoading = true;
  ArticleInteractor intaractor;
  InAppWebViewController inAppWebViewController;

  void onWebCreate(inAppWebViewController) {
    this.inAppWebViewController = inAppWebViewController;
    inAppWebViewController.loadData(
        data: model.contentText, mimeType: "text/html", encoding: "UTF-8");
  }

  @override
  void initState() {
    intaractor = new ArticleInteractor();
    getArticle(context);
    super.initState();
  }

  void getArticle(BuildContext context) async {
    model = await intaractor.getArticle(context);
    if (model != null)
      setState(() {
        _isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          Icon(
            Icons.add,
            color: Colors.deepOrangeAccent,
          ),
          Icon(
            Icons.add,
            color: Colors.deepOrangeAccent,
          ),
          Icon(
            Icons.add,
            color: Colors.deepOrangeAccent,
          ),
          Icon(
            Icons.add,
            color: Colors.deepOrangeAccent,
          ),
          Icon(
            Icons.add,
            color: Colors.deepOrangeAccent,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Icon(Icons.add), Icon(Icons.add)],
              ),
              color: Colors.blueGrey,
            ),
            Builder(
              builder: (_) {
                if (_isLoading)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return Expanded(
                    child: ListView(
                  shrinkWrap: true,
                  children: [
                    Image.network(
                      model.photos[0].url.toString(),
                      fit: BoxFit.fill,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      model.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.sourceText,
                            style: TextStyle(color: Colors.black45),
                          ),
                          Text(
                            model.dateText,
                            style: TextStyle(color: Colors.black45),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    ),
                    Container(
                      height: 900,
                      child: InAppWebView(
                        onWebViewCreated: onWebCreate,
                        initialOptions: InAppWebViewGroupOptions(
                          android: AndroidInAppWebViewOptions(
                            useWideViewPort: false,
                          ),
                          ios: IOSInAppWebViewOptions(
                            enableViewportScale: false,
                          ),
                          crossPlatform: InAppWebViewOptions(
                              debuggingEnabled: true,
                              javaScriptEnabled: true,
                              javaScriptCanOpenWindowsAutomatically: true),
                        ),
                        onLoadStart:
                            (InAppWebViewController controller, String url) {},
                      ),
                    ),
                  ],
                ));
              },
            )
          ],
        ),
      ),
    );
  }
}
