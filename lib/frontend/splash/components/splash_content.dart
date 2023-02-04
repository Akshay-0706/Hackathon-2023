import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../size.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.opacity,
  }) : super(key: key);
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        DropShadow(
          opacity: 0.5,
          blurRadius: 7,
          offset: const Offset(0, 5),
          child: Opacity(
            opacity: opacity,
            child: SvgPicture.asset(
              "assets/icons/logo.svg",
              width: getWidth(250),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          child: Opacity(
            opacity: opacity,
            child: Text(
              "Eco-Quest",
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: getHeight(20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
