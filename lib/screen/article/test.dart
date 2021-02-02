import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:social_setwork/model/article_model.dart';
import 'package:social_setwork/screen/article/article_interactor.dart';
import 'package:social_setwork/screen/article/article_item.dart';
import 'package:social_setwork/screen/article/tag_item.dart';
import 'package:social_setwork/screen/twitter/twitter_screen.dart';
import 'package:social_setwork/screen/webpage/webview_screen.dart';
import 'package:social_setwork/utils/common_utils.dart';
import 'package:social_setwork/utils/navigation_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class TestPage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<TestPage> {
  ArticleModel model;
  bool _isLoading = true;
  ArticleInteractor intaractor;
  InAppWebViewController webContentDController;
  InAppWebViewController webSocialDController;
  InAppWebViewController webCommentController;
  var controller = PageController(initialPage: 0);

  void onWebLoadContent(inAppWebViewController) {
    this.webContentDController = inAppWebViewController;
    inAppWebViewController.loadData(
        data: model.contentText, mimeType: "text/html", encoding: "UTF-8");
  }

  void onWebCreateFbComment(inAppWebViewController) {
    this.webCommentController = inAppWebViewController;
    webCommentController.loadData(
        baseUrl: model.wwwUrl,
        data: intaractor.getCommentFb(model.wwwUrl),
        mimeType: "text/html",
        encoding: "UTF-8");
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
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.list,
          size: 30,
          color: Colors.black,
        ),
        actions: [
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(),
                  Image.asset('assets/logo_splashscreen.png'),
                  Text(
                    "22'C",
                    style: TextStyle(color: Colors.black26, fontSize: 18),
                  ),
                  Icon(
                    Icons.font_download,
                    color: Colors.black38,
                    size: 30,
                  ),
                  Icon(
                    Icons.camera_alt,
                    size: 30,
                    color: Colors.black,
                  ),
                  Icon(
                    Icons.search,
                    size: 30,
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
                    size: 25,
                  ),
                  Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 25,
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
                return
                  Container(child: Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            height: 200,
                            child: Stack(
                              children: [
                                Expanded(
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                        valueColor: new AlwaysStoppedAnimation<Color>(
                                            Colors.deepOrangeAccent),
                                      ),
                                    )),
                                Image.network(
                                  model.photos[0].url.toString(),
                                  fit: BoxFit.fill,
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  errorBuilder: (context, error, stackhere) {
                                    if (error != null && context != null) {
                                      return Image.asset(
                                        "assets/logo_splashscreen.png",
                                        height: 200,
                                        width: MediaQuery.of(context).size.width,
                                      );
                                    }
                                    return null;
                                  },
                                ),
                                Positioned(
                                  child: Column(
                                    children: [
                                      Spacer(),
                                      Container(
                                        padding:
                                        EdgeInsets.only(left: 10, bottom: 10),
                                        child: Container(
                                          padding: EdgeInsets.only(left: 5, right: 5),
                                          color: Colors.deepOrangeAccent,
                                          child: Text(
                                            model.category.name,
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 16),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                          Expanded(
//                      height: 2500,
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
                                  (InAppWebViewController controller, String url) {
                                if (url != "about:blank") {
                                  NavigationUtils.movePage(context, WebPage(url));
                                  webContentDController.stopLoading();
                                  Timer(Duration(milliseconds: 300), () {
                                    onWebLoadContent(webContentDController);
                                  });
                                }
                              },
                              onLoadStop: (InAppWebViewController controller,
                                  String url) async {
                                double height = double.parse(
                                    await webContentDController.evaluateJavascript(
                                        source:
                                        "document.documentElement.scrollHeight;"));
                                print("TAG HEIGHT: $height");
                              },
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 10),
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
                              height: 400),
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
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 5,
                            child: Container(
                              color: Colors.grey[200],
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
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            height: 5,
                            child: Container(
                              color: Colors.grey[200],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 10),
                              child: InAppWebView(
                                onWebViewCreated: onWebCreateFbComment,
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
                                onLoadStart: (InAppWebViewController controller,
                                    String url) async {
                                  if (url
                                      .contains("https://m.facebook.com/login.php")) {
                                    NavigationUtils.movePage(context, WebPage(url));
                                    onWebCreateFbComment(webCommentController);
                                  }
                                  CommonUtils.eventBus.on<String>().listen((event) {
//                              onWebCreateFbComment(webCommentController);
                                  });
                                },
                                onLoadStop:
                                    (InAppWebViewController controller, String url) {
                                  /* setState(() {
                              _isLoadCommentFb = false;
                              _heightCommentFb = 1000;
                            });*/
                                },
                              ),
                              height: 1000)
                        ],
                      )),height: double.maxFinite,);
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
  }

  Widget pageView() {
    return PageView(
      controller: controller,
      scrollDirection: Axis.horizontal,
      children: [ArticlePage(), TwitterScreen()],
    );
  }
}
