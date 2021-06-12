import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SimpleTile extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final String? avatarUrl;
  final Function? onTap;
  final Widget? trailing;
  final EdgeInsets? contentPadding;

  const SimpleTile({
    Key? key,
    this.title,
    this.subtitle,
    this.avatarUrl,
    this.onTap,
    this.trailing,
    this.contentPadding,
    this.subtitleWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap as void Function()?,
      contentPadding: contentPadding,
      title: Text(title!),
      subtitle: subtitleWidget == null
          ? subtitle != null
              ? Text(
                  subtitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : null
          : subtitleWidget,
      leading: CircleAvatar(
        backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
            ? CachedNetworkImageProvider(avatarUrl!)
            : null,
        child: avatarUrl != null && avatarUrl!.isNotEmpty
            ? null
            : Text(
                title![0],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
      ),
      trailing: trailing,
    );
  }
}
