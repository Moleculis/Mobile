import 'package:flutter/material.dart';

class BigTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Widget trailing;

  const BigTile(
      {Key key, this.title, this.subtitle, this.imageUrl, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: imageUrl == null ? null : NetworkImage(imageUrl),
          child: imageUrl == null
              ? Text(
                  title[0],
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 30),
                )
              : null,
          radius: 40,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                subtitle == null
                    ? Container()
                    : Text(
                        subtitle,
                        textAlign: TextAlign.justify,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
              ],
            ),
          ),
        ),
        trailing ?? Container(),
      ],
    );
  }
}
