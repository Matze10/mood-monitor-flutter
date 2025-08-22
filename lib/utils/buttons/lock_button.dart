import 'package:flutter/material.dart';

class LockButton extends StatelessWidget {
  final bool locked;
  final VoidCallback onPressed;
  final Color? color;
  final double size;

  const LockButton({
    super.key,
    required this.locked,
    required this.onPressed,
    this.color,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        locked ? Icons.lock : Icons.lock_open,
        color: color ?? Theme.of(context).iconTheme.color,
        size: size,
      ),
      onPressed: onPressed,
      tooltip: locked ? 'Lock' : 'Unlock',
    );
  }
}
