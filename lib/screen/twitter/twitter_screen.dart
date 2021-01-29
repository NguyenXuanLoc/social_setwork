import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_native_web/flutter_native_web.dart';
import 'package:social_setwork/screen/article/article_interactor.dart';
import 'package:url_launcher/url_launcher.dart';

class TwitterScreen extends StatefulWidget {
  @override
  _TwitterPageState createState() => _TwitterPageState();
}

class _TwitterPageState extends State<TwitterScreen> {
  String data = "<blockquote class=" +
      "\"" +
      "twitter-tweet" +
      "\"" +
      "> <p dir=" +
      "\"" +
      "ltr" +
      "\"" +
      " lang=" +
      "\"" +
      "en" +
      "\"" +
      ">Omar Farouq Bashir is free! Sentence set aside for lack of legal representation. The Sharia court judgment is a nullity. The minor was wrongfully convicted! The court holds that the Sharia Penal system is legal. We may appeal this once we study the judgment.</p>  — Kola Alapinni (@FelaLives) <a href=" +
      "\"" +
      "https://twitter.com/FelaLives/status/1352262328344076289?ref_src=twsrc%5Etfw" +
      "\"" +
      ">January 21, 2021</a></blockquote><script async src=" +
      "\"" +
      "https://platform.twitter.com/widgets.js" +
      "\"" +
      " charset=" +
      "\"" +
      "utf-8" +
      "\"" +
      "></script>";

  String data2 = "<blockquote class=" +
      "\"" +
      "twitter-tweet" +
      "\"" +
      "><p dir=" +
      "\"" +
      "ltr" +
      "\"" +
      " lang=" +
      "\"" +
      "pl" +
      "\"" +
      ">Trybunał Konstytucyjny przedstawił pisemne uzasadnienie do wyroku dotyczącego ochrony życia. Zgodnie z wymogami konstytucyjnymi wyrok zostanie opublikowany dzisiaj w Dzienniku Ustaw.</p>  — Centrum Informacyjne Rządu (@KPRM_CIR) <a href=" +
      "\"" +
      "https://twitter.com/KPRM_CIR/status/1354445120406478852?ref_src=twsrc%5Etfw" +
      "\"" +
      ">January 27, 2021</a></blockquote><script async src=" +
      "\"" +
      "https://platform.twitter.com/widgets.js" +
      "\"" +
      " charset=" +
      "\"" +
      "utf-8" +
      "\"" +
      "></script>";
  String data1 = "<blockquote class=" +
      "\"" +
      "twitter-tweet" +
      "\"" +
      "data-conversation=" +
      "\"" +
      "none" +
      "\"" +
      ">  <p dir=" +
      "\"" +
      "ltr" +
      "\"" +
      " lang=" +
      "\"" +
      "en" +
      "\"" +
      ">Inauguration Topshots:<br /><br />A photo by <a href=" +
      "\"" +
      "https://twitter.com/AFP?ref_src=twsrc%5Etfw" +
      "\"" +
      ">@AFP</a>'s Brendan Smialowski showing Senator Bernie Sanders and his lovely warm mittens (reportedly made by a school teacher in Vermont) at the Biden inauguration has gone viral, sparking countless memes <a href=" +
      "\"" +
      "https://t.co/gaTWHdu9r0" +
      "\"" +
      ">pic.twitter.com/gaTWHdu9r0</a></p>— AFP News Agency (@AFP) <a href=" +
      "\"" +
      "https://twitter.com/AFP/status/1352104473691242499?ref_src=twsrc%5Etfw" +
      "\"" +
      ">January 21, 2021</a></blockquote><script async src=" +
      "\"" +
      "https://platform.twitter.com/widgets.js" +
      "\"" +
      "charset=" +
      "\"" +
      "utf-8" +
      "\"" +
      "></script> 2021-01-28 16:37:13.244 12223-12223/pl.cyfrowypolsat.polsatnews E/TAG: DATA: fbCommentUrl <!DOCTYPE html><html><head>    <meta name=" +
      "\"" +
      "viewport" +
      "\"" +
      "content=" +
      "\"" +
      "width=device-width, initial-scale=1.0" +
      "\"" +
      ">    <meta property=" +
      "\"" +
      "og:locale" +
      "\"" +
      "content=" +
      "\"" +
      "pl_PL" +
      "\"" +
      " /></head><body><div id=" +
      "\"" +
      "fb-root" +
      "\"" +
      "></div><script>(function(d, s, id) {  var js, fjs = d.getElementsByTagName(s)[0];  if (d.getElementById(id)) return;  js = d.createElement(s); js.id = id;  js.src = " +
      "\"" +
      "//connect.facebook.net/pl_PL/sdk.js#xfbml=1&version=v2.6" +
      "\"" +
      ";  fjs.parentNode.insertBefore(js, fjs);}(document, 'script', 'facebook-jssdk'));</script><div class=" +
      "\"" +
      "fb-comments" +
      "\"" +
      " data-href=" +
      "\"" +
      "https://www.polsatnews.pl/wiadomosc/2021-01-28/zdjecie-sandersa-w-rekawiczkach-senator-przekaze-18-mln-na-cele-charytatywne/" +
      "\"" +
      " data-numposts=" +
      "\"" +
      "5" +
      "\"" +
      "></div></body></html>";
  String text =
      "In order to get behavior for match_parent and wrap_content we need to use mainAxisSize property in Row/Column widget, the mainAxisSize property takes MainAxisSize enum having two values which is MainAxisSize.min which behaves as wrap_content and MainAxisSize.max which behaves as match_parent.";
  InAppWebViewController inAppWebViewController;
  InAppWebViewController inAppWebViewController1;

  void onWebCreate(inAppWebViewController) {
    this.inAppWebViewController = inAppWebViewController;
    inAppWebViewController.loadData(
        data: data, mimeType: "text/html", encoding: "UTF-8");
  }

  void onWebCreate1(inAppWebViewController) {
    this.inAppWebViewController1 = inAppWebViewController;
    inAppWebViewController1.loadData(
        data: data1, mimeType: "text/html", encoding: "UTF-8");
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    ArticleInteractor.getArticle(context);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Native WebView as Widget'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text(
                text,
                style: TextStyle(color: Colors.deepOrangeAccent, fontSize: 17),
              ),
              Container(
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
                        (InAppWebViewController controller, String url) {
                      if (url != "about:blank") {
                        inAppWebViewController.stopLoading();
                        _launchURL(url);
                        Timer(Duration(milliseconds: 300), () {
                          inAppWebViewController.loadData(
                              data: data,
                              mimeType: "text/html",
                              encoding: "UTF-8");
                        });
                      }
                    },
                  ),
                  height: 400),
              Container(
                  child: InAppWebView(
                    onWebViewCreated: onWebCreate1,
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
                        (InAppWebViewController controller, String url) {
                      if (url != "about:blank") {
                        inAppWebViewController1.stopLoading();
                        _launchURL(url);
                        Timer(Duration(milliseconds: 300), () {
                          inAppWebViewController1.loadData(
                              data: data1,
                              mimeType: "text/html",
                              encoding: "UTF-8");
                        });
                      }
                    },
                  ),
                  height: 800),
            ],
          ),
        ),
      ),
    );
  }
}
