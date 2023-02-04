import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChallengesBody extends StatelessWidget {
  const ChallengesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        builder: (context, double opacity, child) => Opacity(
          opacity: opacity,
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}