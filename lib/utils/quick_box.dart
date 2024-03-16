import 'dart:math';

import 'package:flutter/material.dart';

runQuickBox(
    {required BuildContext context,
    required String message,
    required bool shakeable}) {
  WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.maybePop(context);
          });
          if (!shakeable) {
            return AlertDialog(
              title: Text(
                message,
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ShakeableDialog(message: message);
          }
        });
  });
}

class ShakeableDialog extends StatefulWidget {
  final Duration duration; // how fast to shake
  final double distance; // how far to shake
  final message;

  const ShakeableDialog({
    this.message,
    Key? key,
    this.duration = const Duration(milliseconds: 300),
    this.distance = 12.0,
  }) : super(key: key);

  @override
  _ShakeableDialogState createState() => _ShakeableDialogState();
}

class _ShakeableDialogState extends State<ShakeableDialog>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final dx = sin(_controller.value * 2 * pi) * widget.distance;
        _controller.repeat();
        return Transform.translate(
          offset: Offset(dx, 0),
          child: child,
        );
      },
      child: AlertDialog(
        title: Text(
          widget.message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
