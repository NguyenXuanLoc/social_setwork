import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:social_setwork/model/article_model.dart';

class ArticleInteractor {

  Future<ArticleModel> getArticle(BuildContext context) async {
    final data =
        await DefaultAssetBundle.of(context).loadString('assets/article.json');
    var jsonResult = json.decode(data.toString());
    return ArticleModel.fromJson(jsonResult);
  }
 String getContentSosialNetWork(){
    return data;
  }
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
// static getArticle(BuildContext context) async {
//   final data =
//       await DefaultAssetBundle.of(context).loadString('assets/article.json');
//   var jsonResult = json.decode(data.toString());
//   ArticleModel model = ArticleModel.fromJson(jsonResult);
//   print("MODEL: " + model.title);
//   print("PHOTO: " + model.photos.length.toString());
//   print("PHOTO: " + model.category.toString());
//   print("TAGS: " + model.tags.length.toString());
// }
}
