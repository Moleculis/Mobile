import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moleculis/widgets/input.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSend;
  final Function(String text)? onChanged;
  final bool animate;

  const MessageInput({
    Key? key,
    required this.controller,
    required this.focusNode,
    required this.onSend,
    required this.onChanged,
    this.animate = false,
  }) : super(key: key);

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput>
    with SingleTickerProviderStateMixin {
  late Animation<double> spreadRadiusAnimation;
  late final AnimationController controller;
  void Function(AnimationStatus status)? listener;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    createAnimation();
    if (widget.animate) startAnimation();
    super.initState();
  }

  @override
  void didUpdateWidget(MessageInput oldWidget) {
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        startAnimation();
      } else {
        stopAnimation();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void startAnimation() async {
    controller.repeat(reverse: true);
  }

  void stopAnimation() async {
    controller.reset();
    controller.stop();
  }

  void createAnimation() {
    final Animation curve = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );

    spreadRadiusAnimation =
        Tween(begin: 0.0, end: 7.0).animate(curve as Animation<double>);

    if (listener != null) controller.removeStatusListener(listener!);

    listener = (_) async {
      if (controller.status == AnimationStatus.completed) {
        if (mounted && widget.animate) {
          controller.reset();
          controller.forward();
        }
      }
    };

    controller.addStatusListener(listener!);
  }

  @override
  Widget build(BuildContext context) {
    final controllerIsNotEmpty = widget.controller.text.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0, horizontal: 13.0),
      child: Row(
        children: [
          Expanded(
            child: AnimatedBuilder(
              animation: spreadRadiusAnimation,
              builder: (BuildContext context, Widget? child) {
                final animatedSpreadRadius = spreadRadiusAnimation.value;
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      if (widget.animate)
                        BoxShadow(
                          spreadRadius: animatedSpreadRadius,
                          blurRadius: 5,
                          color: Colors.blue.withOpacity(0.3),
                        ),
                    ],
                  ),
                  child: Input(
                    isDense: true,
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    borderRadius: BorderRadius.circular(30.0),
                    style: TextStyle(fontSize: 12.0),
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.send,
                    backgroundColor: Colors.white,
                    disabledBorderColor: Colors.grey,
                    padding: EdgeInsets.zero,
                    hint: 'write_message'.tr(),
                    onTap: () => widget.onChanged!(''),
                    onChanged: widget.onChanged,
                    onFieldSubmitted: (text) => widget.onSend(),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 17.0,
                    ),
                  ),
                );
              },
            ),
          ),
          GestureDetector(
            onTap: widget.onSend,
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: controllerIsNotEmpty
                    ? Colors.white
                    : Colors.grey.withOpacity(0.5),
                border: Border.all(
                  color: controllerIsNotEmpty
                      ? Theme.of(context).accentColor
                      : Colors.grey,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.send,
                size: 16,
                color: controllerIsNotEmpty
                    ? Theme.of(context).accentColor
                    : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
