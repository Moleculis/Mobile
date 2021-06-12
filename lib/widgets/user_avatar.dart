import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/common/colors.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/utils/locator.dart';
import 'package:moleculis/widgets/user_letter.dart';

class UserAvatar extends StatefulWidget {
  final UserSmall? user;
  final bool isOnline;
  final bool isAnimate;
  final bool isFriend;

  // white inner circle
  final bool hasInnerBorder;
  final double innerBorderPadding;
  final Color innerBorderColor;

  // black outward circle
  final bool hasBorder;
  final Color borderColor;
  final double? borderHeight;

  final double maxRadius;
  final double? letterSize;

  const UserAvatar({
    Key? key,
    this.isOnline = false,
    this.isAnimate = false,
    this.hasInnerBorder = true,
    this.hasBorder = true,
    this.borderColor = Colors.black,
    this.innerBorderColor = Colors.white,
    this.innerBorderPadding = 3.0,
    this.user,
    this.borderHeight,
    this.maxRadius = 26.0,
    this.letterSize,
    this.isFriend = true,
  }) : super(key: key);

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  late double animatedOpacity;
  late double animatedShadow;

  late final backgroundColor;

  @override
  void initState() {
    super.initState();
    animatedOpacity = widget.isAnimate ? 0.0 : 1.0;
    animatedShadow = widget.isAnimate ? 0.0 : 3.0;
    if (widget.isAnimate) animate();

    final currentUser = locator<AuthBloc>().state.currentUser!;
    backgroundColor = currentUser.username == widget.user!.username
        ? accentColor
        : Colors.blue;
  }

  Future<void> animate() async {
    await Future.delayed(Duration(microseconds: 1));
    if (mounted) setState(() => animatedOpacity = 1.0);
    await Future.delayed(Duration(milliseconds: 500));
    if (mounted) setState(() => animatedShadow = 2.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: animatedOpacity,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: widget.hasInnerBorder
                ? EdgeInsets.all(widget.innerBorderPadding)
                : EdgeInsets.zero,
            decoration: BoxDecoration(
              color: widget.innerBorderColor,
              shape: BoxShape.circle,
              boxShadow: [
                if (widget.hasInnerBorder && widget.hasBorder)
                  BoxShadow(
                    color: widget.borderColor,
                    spreadRadius: widget.borderHeight ?? animatedShadow,
                  )
              ],
            ),
            child: SizedBox(
              width: widget.maxRadius,
              height: widget.maxRadius,
              child: CircleAvatar(
                backgroundColor: backgroundColor,
                minRadius: 15.0,
                maxRadius: widget.maxRadius,
                child: userAvatar,
              ),
            ),
          ),
          if (widget.isOnline)
            Icon(Icons.brightness_1, color: Colors.green, size: 10.0),
        ],
      ),
    );
  }

  Widget get userAvatar {
    if (widget.user == null) return Container();
    return Stack(
      alignment: Alignment.center,
      children: [
        userLetter,
        if (!widget.isFriend)
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }

  Widget get userLetter {
    return Center(
      child: UserLetter(user: widget.user, fontSize: widget.maxRadius / 3),
    );
  }
}
