import 'package:flutter/material.dart';

class LoadingWrapper extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const LoadingWrapper({
    Key? key,
    required this.isLoading,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            width: double.infinity,
            height: double.infinity,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
