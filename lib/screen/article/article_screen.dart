import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_setwork/model/article_model.dart';
import 'package:social_setwork/screen/article/article_interactor.dart';
import 'package:social_setwork/screen/article/article_item.dart';
import 'package:social_setwork/screen/article/tag_item.dart';
import 'package:social_setwork/screen/twitter/twitter_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  ArticleModel model;
  bool _isLoading = true;
  ArticleInteractor intaractor;
  InAppWebViewController webContentDController;
  InAppWebViewController webSocialDController;

  void onWebLoadContent(inAppWebViewController) {
    this.webContentDController = inAppWebViewController;
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

  void onWebSocial(inAppWebViewController) {
    this.webSocialDController = inAppWebViewController;
    inAppWebViewController.loadData(
        data: intaractor.getContentSosialNetWork(),
        mimeType: "text/html",
        encoding: "UTF-8");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.art_track,
          size: 40,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        actions: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.search,
                color: Colors.white,
              ),
              Image.asset('assets/logo_splashscreen.png'),
              Text(
                "22'C",
                style: TextStyle(color: Colors.black26, fontSize: 20),
              ),
              Image.asset(
                'assets/fontsize_white_pressed.png',
              ),
              Icon(
                Icons.camera_alt,
                color: Colors.black,
              ),
              Icon(
                Icons.search,
                color: Colors.black38,
              ),
            ],
          ))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 30,
                  )
                ],
              ),
              color: Colors.blueGrey,
            ),
            Builder(
              builder: (_) {
                if (_isLoading)
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
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
                        onWebViewCreated: onWebLoadContent,
                        initialOptions: InAppWebViewGroupOptions(
                          android: AndroidInAppWebViewOptions(
                            useWideViewPort: false,
                          ),
                          ios: IOSInAppWebViewOptions(
                            enableViewportScale: true,
                          ),
                          crossPlatform: InAppWebViewOptions(
                              debuggingEnabled: true,
                              javaScriptEnabled: true,
                              javaScriptCanOpenWindowsAutomatically: true),
                        ),
                        onLoadStart:
                            (InAppWebViewController controller, String url) {},
                        onLoadStop:
                            (InAppWebViewController controller, String url) {
                          webSocialDController.evaluateJavascript(
                              source: 'document.body.scrollHeight');
                        },
                      ),
                    ),
                    Container(
                        child: InAppWebView(
                          onWebViewCreated: onWebSocial,
                          initialOptions: InAppWebViewGroupOptions(
                            android: AndroidInAppWebViewOptions(
                              useWideViewPort: false,
                            ),
                            ios: IOSInAppWebViewOptions(
                              enableViewportScale: true,
                            ),
                            crossPlatform: InAppWebViewOptions(
                                debuggingEnabled: true,
                                javaScriptEnabled: true,
                                javaScriptCanOpenWindowsAutomatically: true),
                          ),
                          onLoadStart:
                              (InAppWebViewController controller, String url) {
                            if (url != "about:blank") {
                              webSocialDController.stopLoading();
                              _launchURL(url);
                              Timer(Duration(milliseconds: 300), () {
                                webSocialDController.loadData(
                                    data: intaractor.getContentSosialNetWork(),
                                    mimeType: "text/html",
                                    encoding: "UTF-8");
                              });
                            }
                          },
                        ),
                        height: 300),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GridView.count(
                        mainAxisSpacing: 5,
                        childAspectRatio: 4.0,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        // to disable GridView's scrolling
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        children: model.tags.map((e) => ItemTag(e)).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Zobacz takze",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 6,
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: GridView.count(
                        mainAxisSpacing: 5,
                        childAspectRatio: 4.0,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 1,
                        children:
                            model.related.map((e) => ArticleItem(e)).toList(),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Dodaj komentarz",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.only(left: 10, right: 10),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 6,
                      child: Container(
                        color: Colors.grey,
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

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void loadUrl() {
    var buf = new StringBuffer();
    try {
//      InputStream json =
//      BufferedReader in =
//    new BufferedReader(new InputStreamReader(json, "UTF-8"));
//    String str;
//
//    while ((str = in.readLine()) != null) {
//    buf.write(str);
//    }
//
//    in.close();
    } catch (ex) {
      print("EXP: " + ex.toString());
    }
//    String html = buf.toString().replace("%link%", fbCommentUrl);
//    wvFacebook.loadDataWithBaseURL(fbCommentUrl, html, "text/html", "UTF-8", null);
  }
}
