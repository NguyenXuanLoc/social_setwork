import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:social_setwork/model/article_model.dart';

class ArticleInteractor {
  static getArticle(BuildContext context) async {
    final data =
        await DefaultAssetBundle.of(context).loadString('assets/article.json');
    var jsonResult = json.decode(data.toString());
    ArticleModel model = ArticleModel.fromJson(jsonResult);
    print("MODEL: "+model.title);
    print("PHOTO: "+model.photos.length.toString());
//    print("TAG: "+model.);
//    print("DATA: " + .toString());
  }
}
