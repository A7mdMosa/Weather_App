import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final IconData? iconData;

  IconButtonWidget({this.onPress, this.iconData});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      child: Icon(
        iconData,
        color: Colors.black,
        size: 50,
      ),
    );
  }
}
