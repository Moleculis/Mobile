import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final Widget content;
  final Widget? trailing;
  final EdgeInsets? tilePadding;
  final bool initialExpanded;
  final Duration duration;
  final bool centerTitle;

  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.content,
    this.trailing,
    this.tilePadding,
    this.initialExpanded = false,
    this.duration = const Duration(milliseconds: 300),
    this.centerTitle = false,
  }) : super(key: key);

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> contentAnimation;
  late Animation<double> trailingAnimation;
  bool isForward = true;

  @override
  void initState() {
    animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    Tween<double> contentTween;
    Tween<double> trailingTween;
    if (widget.initialExpanded) {
      contentTween = Tween(begin: 1.0, end: 0.0);
      trailingTween = Tween(begin: 0.5, end: 0.0);
    } else {
      contentTween = Tween(begin: 0.0, end: 1.0);
      trailingTween = Tween(begin: 0.0, end: 0.5);
    }
    contentAnimation = contentTween.animate(animationController);
    trailingAnimation = trailingTween.animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget trailing = RotationTransition(
      turns: trailingAnimation,
      child: widget.trailing ??
          RotationTransition(
            turns: AlwaysStoppedAnimation(-90 / 360),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
            ),
          ),
    );

    Widget tile;

    if (widget.centerTitle) {
      tile = Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: widget.title,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: trailing,
          ),
        ],
      );
    } else {
      tile = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.title,
          trailing,
        ],
      );
    }
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (isForward) {
              animationController.forward();
              isForward = false;
            } else {
              animationController.reverse();
              isForward = true;
            }
          },
          child: Padding(
            padding: widget.tilePadding ??
                const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
            child: tile,
          ),
        ),
        SizeTransition(
          sizeFactor: contentAnimation,
          child: widget.content,
        )
      ],
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
