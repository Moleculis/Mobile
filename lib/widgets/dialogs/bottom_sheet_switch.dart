import 'package:flutter/material.dart';

class BottomSheetSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const BottomSheetSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _BottomSheetSwitchState createState() => _BottomSheetSwitchState();
}

class _BottomSheetSwitchState extends State<BottomSheetSwitch> {
  late bool switchValue;

  @override
  void initState() {
    switchValue = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: switchValue,
      onChanged: (newValue) {
        setState(() => switchValue = newValue);
        widget.onChanged(newValue);
      },
    );
  }
}
