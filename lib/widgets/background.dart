import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({required this.child, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 1,
          colors: [
            ...[Colors.pink[900]!, Colors.pink[100]!, Colors.white].reversed
          ],
        ),
      ),
      child: child,
    );
  }
}
