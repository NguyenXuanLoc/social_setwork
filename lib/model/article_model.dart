import 'package:social_setwork/model/photo_model.dart';
import 'package:social_setwork/model/related_model.dart';
import 'package:social_setwork/model/tag_model.dart';

class ArticleModel {
  final String copyright;
  final int id;

//  final String category;
  final String title;
  final String sourceText;
  final String dateText;
  final String shortDescription;
  final String wwwUrl;
  final bool showMainVod;

  final List<PhotoModel> photos;
  final String contentText;
//  final List<Object> videos;
  final List<TagModel> tags;
  final List<RelatedModel> related;
  final bool skipVod;
  final String seeAlso;


  ArticleModel(
      this.copyright,
      this.id,
      this.title,
      this.sourceText,
      this.dateText,
      this.shortDescription,
      this.wwwUrl,
      this.showMainVod,
      this.photos,
      this.contentText,
      this.tags,
      this.related,
      this.skipVod,
      this.seeAlso);

  factory ArticleModel.fromJson(Map<String, dynamic> ob) {
    return ArticleModel(
        ob['copyright'],
        ob['id'],
//        ob['category'],
        ob['title'],
        ob['source_text'],
        ob['date_text'],
        ob['short_description'],
        ob['www_url'],
        ob['show_main_vod'],
        (ob['photos'] as List).map((e) => PhotoModel.fromJson(e)).toList(),
        ob['content_text'],
//        (ob['videos'] as List).map((e) => VIde),
        (ob['tags'] as List).map((e) => TagModel.fromJson(e)).toList(),
        (ob['related'] as List).map((e) => RelatedModel.fromJson(e)).toList(),
        ob['skip_vod'],
        ob['see_also']);
  }
}
