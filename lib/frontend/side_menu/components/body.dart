import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hackathon/const.dart';
import 'package:hackathon/frontend/news/news.dart';

import '../../../backend/auth/user_account.dart';
import '../../../size.dart';
import '../../../theme.dart';
import '../../components/custom_page_route.dart';
import '../../welcome/welcome.dart';

class SideMenuBody extends StatelessWidget {
  const SideMenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    final box = GetStorage();
    return Scaffold(
      backgroundColor: pallete.primaryDark(),
      body: Container(
        color: pallete.primaryDark(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getHeight(60)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: box.read("photo"),
                  width: getWidth(60),
                ),
              ),
            ),
            SizedBox(height: getHeight(20)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                box.read("name"),
                style: TextStyle(
                  color: pallete.background(),
                  fontSize: getWidth(20),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: getHeight(20)),
            Divider(color: pallete.background()),
            SizedBox(height: getHeight(20)),
            DrawerCard(
              pallete: pallete,
              title: "Profile",
              iconPath: "assets/icons/profile.svg",
              clicked: () {
                print("object");
              },
            ),
            SizedBox(height: getHeight(20)),
            DrawerCard(
              pallete: pallete,
              title: "Articles",
              iconPath: "assets/icons/articles.svg",
              clicked: () {
                print("object");
                Navigator.push(
                  context,
                  CustomPageRoute(
                    context,
                    const News(),
                  ),
                );
              },
            ),
            SizedBox(height: getHeight(20)),
            DrawerCard(
              pallete: pallete,
              title: "Rewards",
              iconPath: "assets/icons/rewards.svg",
              clicked: () {
                print("object");
              },
            ),
            SizedBox(height: getHeight(20)),
            DrawerCard(
              pallete: pallete,
              title: "Trophy wall",
              iconPath: "assets/icons/trophy.svg",
              clicked: () {
                print("object");
              },
            ),
            SizedBox(height: getHeight(20)),
            Spacer(),
            DrawerCard(
              pallete: pallete,
              title: "Log out",
              iconPath: "assets/icons/logout.svg",
              clicked: () {
                print("object");
                UserAccount.googleLogout();
                Navigator.pushReplacement(
                  context,
                  CustomPageRoute(
                    context,
                    const Welcome(),
                  ),
                );
              },
            ),
            SizedBox(height: getHeight(20)),
          ],
        ),
      ),
    );
  }
}

class DrawerCard extends StatelessWidget {
  const DrawerCard({
    Key? key,
    required this.pallete,
    required this.title,
    required this.iconPath,
    required this.clicked,
  }) : super(key: key);

  final Pallete pallete;
  final String title, iconPath;
  final VoidCallback clicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: clicked,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: getWidth(30),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: pallete.background(),
                fontSize: getWidth(20),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
