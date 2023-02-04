import 'package:flutter/material.dart';
import 'package:hackathon/frontend/community/components/newpost.dart';
import 'package:hackathon/frontend/home/home.dart';
import 'package:hackathon/frontend/tab_1/tab_1.dart';
import 'package:hackathon/frontend/welcome/welcome.dart';
import 'package:hackathon/frontend/leaderboard/leaderboard.dart';

import 'frontend/splash/splash.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => const Splash(),
  "/welcome": (context) => const Welcome(),
  "/home": (context) => const Home(),
  "/tab": (context) => const Tab1(),
  "/NewPost": (context) => const NewPost(),
};
