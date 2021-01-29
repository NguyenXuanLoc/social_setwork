class RelatedModel {
  final int ts;
  final String url;
  final String jsonUrl;
  final int newsId;
  final String title;
  final String descShort;
  final String categoryText;
  final String imageUrl;


  RelatedModel(this.ts, this.url, this.jsonUrl, this.newsId, this.title,
      this.descShort, this.categoryText, this.imageUrl);

  factory RelatedModel.fromJson(Map<String, dynamic> ob) {
    return RelatedModel(ob['ts'], ob['url'], ob['json_url'], ob['news_id'],
        ob['title'], ob['desc_short'], ob['category_text'], ob['image_url']);
  }
}
