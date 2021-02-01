import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_setwork/model/related_model.dart';

class ArticleItem extends StatefulWidget {
  RelatedModel ob;

  ArticleItem(this.ob);

  @override
  _ArticleItemState createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: Image.network(
              widget.ob.imageUrl,
              height: 90,
            ),
            height: 90,
            width: 120,
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.ob.categoryText,
                    style: TextStyle(color: Colors.deepOrange),
                  ),
                  Text(widget.ob.title)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
      height: 120,
    );
  }
  @override
  bool get wantKeepAlive => true;
}
