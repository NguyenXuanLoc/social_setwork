import 'dart:convert';

import 'package:flutter/cupertino.dart';

class ArticleInteractor {

  static getArticle(BuildContext context) async{
    final data = await DefaultAssetBundle.of(context).loadString('assets/article.json');
    var jsonResult = json.decode(data.toString());

    print("DATA: " + data.toString());
  }
}
