import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Avatar extends StatelessWidget {
  final String seed;
  final double size;

  const Avatar({required this.seed, this.size = 250, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SvgPicture.network(
        "https://api.dicebear.com/7.x/adventurer/svg?seed=$seed",
        width: size,
        height: size,
      ),
    );
  }
}
