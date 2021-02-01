import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_setwork/screen/article/article_screen.dart';
import 'package:social_setwork/utils/navigation_utils.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      NavigationUtils.movePageAndRemoveOldPage(context, ArticlePage());
    });
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    color: Colors.grey[100],
                    height: 90,
                    child: Image.asset(
                      "assets/logo_splashscreen.png",
                      height: 10,
                    ),
                  ),
                ),
              ),
              CircularProgressIndicator(
                strokeWidth: 1,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
