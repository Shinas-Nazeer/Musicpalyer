
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);
  final IconData icon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}



