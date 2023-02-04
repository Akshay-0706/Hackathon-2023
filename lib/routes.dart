import 'package:flutter/material.dart';
import 'package:hackathon/frontend/donate/donate.dart';
import 'package:hackathon/frontend/community/components/newpost.dart';
import 'package:hackathon/frontend/home/home.dart';
import 'package:hackathon/frontend/screen/screen.dart';
import 'package:hackathon/frontend/side_menu/side_menu.dart';
import 'package:hackathon/frontend/welcome/welcome.dart';
import 'package:hackathon/frontend/leaderboard/leaderboard.dart';

import 'frontend/splash/splash.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => const Splash(),
  "/welcome": (context) => const Welcome(),
  "/NewPost": (context) => const NewPost(),
  "/tab4": (context) => const LeaderBoard(),
};
