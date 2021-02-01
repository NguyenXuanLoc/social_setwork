import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_setwork/model/tag_model.dart';

class ItemTag extends StatefulWidget {
  TagModel ob;

  ItemTag(this.ob);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<ItemTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 15,
              ),
              color: Colors.deepOrange,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
              child: Text(
            widget.ob.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ))
        ],
      ),
    );
  }
}
