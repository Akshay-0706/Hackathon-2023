import 'package:flutter/material.dart';

import 'components/body.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LeaderBoardBody(),
    );
  }
}
