import 'package:flutter/material.dart';
import 'package:hackathon/frontend/donate/donate.dart';
import 'package:hackathon/frontend/community/components/new_post.dart';
import 'package:hackathon/frontend/home/home.dart';
import 'package:hackathon/frontend/rewards/rewards.dart';
import 'package:hackathon/frontend/screen/screen.dart';
import 'package:hackathon/frontend/side_menu/side_menu.dart';
import 'package:hackathon/frontend/welcome/welcome.dart';
import 'package:hackathon/frontend/leaderboard/leaderboard.dart';

import 'frontend/splash/splash.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => const Splash(),
  "/welcome": (context) => const Welcome(),
  "/newpost": (context) => const NewPost(),
  "/screen": (context) => const Screen(),
  "/leaderb": (context) => const LeaderBoard(),
  "/reward": (context) => const Reward(),
};
