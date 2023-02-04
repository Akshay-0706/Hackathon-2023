import 'package:flutter/material.dart';
import 'package:hackathon/frontend/challenges/components/body.dart';

class Challenges extends StatelessWidget {
  const Challenges({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ChallengesBody(),
    );
  }
}
