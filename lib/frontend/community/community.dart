import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/frontend/community/components/body.dart';
import 'package:hackathon/size.dart';
import 'package:hackathon/theme.dart';

import '../../backend/database/database.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityPageBodyState();
}

class _CommunityPageBodyState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommunityBody(),
    );
  }
}
