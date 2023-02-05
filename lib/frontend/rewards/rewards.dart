import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/frontend/rewards/components/body.dart';
import 'package:hackathon/size.dart';
import 'package:hackathon/theme.dart';

import '../../backend/database/database.dart';

class Reward extends StatefulWidget {
  const Reward({super.key});

  @override
  State<Reward> createState() => _RewardPageBodyState();
}

class _RewardPageBodyState extends State<Reward> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RewardBody(),
    );
  }
}
