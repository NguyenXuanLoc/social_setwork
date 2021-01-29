class TagModel{
 final int id;
 final String name;
 TagModel(this.id, this.name);

 factory TagModel.fromJson(Map<String,dynamic> ob){
   return TagModel(ob['id'], ob['name']);
 }
}
