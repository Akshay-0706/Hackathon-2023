import 'package:flutter/material.dart';
import 'package:hackathon/frontend/side_menu/components/body.dart';
import 'package:hackathon/theme.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return Scaffold(
      body: SideMenuBody(),
    );
  }
}
