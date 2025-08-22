import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final Widget child;
  final double size;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  const RoundButton({
    super.key,
    required this.child,
    this.size = 40,
    this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: SizedBox(
          width: size,
          height: size,
          child: Center(child: child),
        ),
      ),
    );
  }
}
