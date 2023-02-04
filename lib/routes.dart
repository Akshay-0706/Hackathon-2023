import 'package:flutter/material.dart';
import 'package:hackathon/frontend/home/home.dart';
import 'package:hackathon/frontend/screen/screen.dart';
import 'package:hackathon/frontend/side_menu/side_menu.dart';
import 'package:hackathon/frontend/welcome/welcome.dart';

import 'frontend/splash/splash.dart';

Map<String, WidgetBuilder> routes = {
  "/": (context) => const Splash(),
  "/welcome": (context) => const Welcome(),
  "/screen": (context) => const Screen(),
  "/home": (context) => const Home(),
};
