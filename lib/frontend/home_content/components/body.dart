import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hackathon/frontend/home_content/components/notifications_page.dart';
import 'package:hackathon/size.dart';
import 'package:hackathon/theme.dart';

import '../../../global.dart';

class HomeContentBody extends StatelessWidget {
  const HomeContentBody({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Pallete pallete = Pallete(context);
    return SafeArea(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        builder: (context, double opacity, child) => Opacity(
          opacity: opacity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const Spacer(),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: getHeight(25),
                              width: getWidth(70),
                              padding: const EdgeInsets.only(right: 40),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.yellow,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '123',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: getWidth(14),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: -5,
                              right: -5,
                              child: SvgPicture.asset(
                                'assets/icons/coin.svg',
                                height: 35,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            print("Tap");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationPage(),
                              ),
                            );
                          },
                          // borderRadius: BorderRadius.circular(17),
                          child: Icon(
                            Icons.notifications_rounded,
                            color: pallete.primaryDark(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Hello, ${box.read('name').toString().split(" ")[0]} 👋",
                    style: TextStyle(
                      color: pallete.primaryDark(),
                      fontSize: getWidth(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "What did you do sustainable today?",
                    style: TextStyle(
                      color: pallete.primaryDark(),
                      fontSize: getWidth(16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Your Daily Score",
                    style: TextStyle(
                      color: pallete.primaryDark(),
                      fontSize: getWidth(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: 0.3,
                        color: pallete.primary(),
                        backgroundColor: pallete.primaryDark().withOpacity(0.4),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "30% Daily Progress",
                    style: TextStyle(
                      color: pallete.primaryLight(),
                      fontSize: getWidth(12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Quick Access",
                    style: TextStyle(
                      color: pallete.primaryDark(),
                      fontSize: getWidth(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        Categories(
                          pallete: pallete,
                          logo: 'assets/icons/newPost.svg',
                          name: 'New Post',
                          route: '/newpost',
                        ),
                        const SizedBox(width: 20),
                        Categories(
                          pallete: pallete,
                          logo: 'assets/icons/reward.svg',
                          name: 'Rewards',
                          route: '/reward',
                        ),
                        const SizedBox(width: 20),
                        Categories(
                          pallete: pallete,
                          logo: 'assets/icons/drive.svg',
                          name: 'Drive',
                          route: '/drive',
                        ),
                        const SizedBox(width: 20),
                        Categories(
                          pallete: pallete,
                          logo: 'assets/icons/leaderboard.svg',
                          name: 'LeaderBoard',
                          route: '/leaderb',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Recent Campaigns",
                    style: TextStyle(
                      color: pallete.primaryDark(),
                      fontSize: getWidth(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        CompaignCard(
                            pallete: pallete,
                            img: 'assets/images/shutterstock_1879675894.jpeg',
                            title: 'New Drive1',
                            cat: "Medical",
                            para:
                                "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum "),
                        const SizedBox(width: 20),
                        CompaignCard(
                          pallete: pallete,
                          img: 'assets/images/SustainabilityIdeaLead.jpg',
                          title: 'New Drive2',
                          cat: "E-Waste",
                          para:
                              "All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",
                        ),
                        const SizedBox(width: 20),
                        CompaignCard(
                            pallete: pallete,
                            img: 'assets/images/clean.jfif',
                            title: 'New Drive3',
                            cat: "Cleanliness",
                            para:
                                "While this is a topic that people are aware of, waste generation is increasing at an alarming rate. Countries are rapidly developing without adequate systems in place to manage the changing waste composition of citizens. Cities, home to over half of humanity and generating more than 80% of the world’s GDP, are at the forefront of tackling the global waste challenge."),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CompaignCard extends StatelessWidget {
  const CompaignCard({
    Key? key,
    required this.pallete,
    required this.img,
    required this.title,
    required this.cat,
    required this.para,
  }) : super(key: key);

  final Pallete pallete;
  final String img;
  final String title;
  final String cat;
  final String para;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        width: getWidth(290),
        height: getWidth(290),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(1, 2),
              blurRadius: 5,
            )
          ],
          color: themeChanger.isDarkMode ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: getWidth(270),
                  height: getHeight(130),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: getWidth(150),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: pallete.primaryLight(),
                        fontSize: getWidth(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(1, 2),
                          blurRadius: 5,
                        )
                      ],
                      color: pallete.primary(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        cat,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getWidth(16),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                para,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: pallete.primaryLight().withOpacity(0.6),
                  fontSize: getWidth(16),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 6,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 0.45,
                    color: pallete.primary(),
                    backgroundColor: pallete.primaryDark().withOpacity(0.4),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Raised: \$6000",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: pallete.primary(),
                      fontSize: getWidth(14),
                    ),
                  ),
                  Text(
                    "45%",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: pallete.primary(),
                      fontSize: getWidth(14),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.pallete,
    required this.logo,
    required this.name,
    required this.route,
  }) : super(key: key);

  final Pallete pallete;
  final String logo;
  final String name;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: getWidth(70),
            height: getWidth(70),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(1, 2),
                  blurRadius: 5,
                )
              ],
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(
                logo,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(
              color: pallete.primaryDark(),
              fontSize: getWidth(14),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
