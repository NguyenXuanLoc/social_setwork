class PhotoModel {
 final String url;
 final String copyright;

 PhotoModel(this.url, this.copyright);

 factory PhotoModel.fromJson(Map<String,dynamic> ob){
   return PhotoModel(ob['url'], ob['copyright']);
 }
}
