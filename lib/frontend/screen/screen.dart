import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon/frontend/home/home.dart';
import 'package:hackathon/frontend/side_menu/side_menu.dart';
import 'package:hackathon/global.dart';
import 'package:hackathon/size.dart';
import 'package:hackathon/theme.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation, borderAnimation, scaleAnimation;
  bool isSideMenuClosed = true;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Global.drawerDuration)
          ..addListener(() {
            setState(() {});
          });

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    borderAnimation = Tween<double>(begin: 0, end: 24).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: pallete.primaryDark(),
        body: Stack(
          children: [
            Transform.translate(
              offset: Offset(
                  animation.value * SizeConfig.width * Global.drawerOffset * -1,
                  0),
              child: const SideMenu(),
            ),
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(animation.value - 30 * animation.value * pi / 180),
              child: Transform.translate(
                offset: Offset(
                    animation.value * SizeConfig.width * Global.drawerOffset,
                    0),
                child: Transform.scale(
                  scale: scaleAnimation.value,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(borderAnimation.value)),
                    child: const Home(),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 20,
              top: 20,
              child: InkWell(
                onTap: () {
                  print("Tap");
                  // print(SizeConfig.width * Global.drawerOffset * -1);
                  if (isSideMenuClosed) {
                    animationController.forward();
                  } else {
                    animationController.reverse();
                  }
                  setState(() {
                    isSideMenuClosed = !isSideMenuClosed;
                  });
                },
                borderRadius: BorderRadius.circular(17),
                child: Container(
                  width: getWidth(34),
                  height: getWidth(34),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: pallete.primaryDark(),
                      boxShadow: [
                        BoxShadow(
                          color: pallete.primaryDark().withOpacity(0.5),
                          offset: const Offset(0, 1),
                          blurRadius: 8,
                        )
                      ]),
                  child: Icon(
                    Icons.menu,
                    color: pallete.background(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
