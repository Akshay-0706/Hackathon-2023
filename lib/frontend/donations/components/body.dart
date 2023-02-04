import 'package:flutter/material.dart';
import 'package:hackathon/const.dart';
import 'package:hackathon/frontend/donate/donate.dart';
import 'package:hackathon/size.dart';
import 'package:hackathon/theme.dart';

import '../../components/custom_page_route.dart';

class DontaionsBody extends StatelessWidget {
  const DontaionsBody({super.key});

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    List<String> title = [
      "NO POWERTY",
      "ZERO HUNGER",
      "GOOD HEALTH AND WELL-BEING",
      "QUALITY EDUCATION",
      "GENDER EQUALITY",
      "CLEAN WATER AND SANITATION",
      "AFFORDABLE AND CLEAN ENERGY",
      "DECENT WORK AND ECONOMIC GROWTH",
      "INDUSTRY, INNOVATION AND INFRASTRUCTURE",
      "REDUCED INEQUALITIES",
      "SUSTAINABLE CITIES AND COMMUNITIES",
      "RESPONSIBLE CONSUMPTION AND PRODUCTION",
      "CLIMATE ACTION",
      "LIFE BELOW WATER",
      "LIFE ON LAND",
      "PEACE, JUSTICE AND STRONG INSTITUTIONS",
      "PARTNERSHIPS FOR THE GOALS",
    ];

    return SafeArea(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 500),
        builder: (context, double opacity, child) => Opacity(
          opacity: opacity,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    "Donate to the Global Goals",
                    style: TextStyle(
                      color: pallete.primaryDark(),
                      fontSize: getWidth(30),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Which Global Goal would you like to donate to?",
                    style: TextStyle(
                      color: pallete.primaryDark(),
                      fontSize: getWidth(20),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...List.generate(
                    17,
                    (index) => DonationCard(
                      colors: Global.colors,
                      pallete: pallete,
                      title: title,
                      index: index,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DonationCard extends StatelessWidget {
  const DonationCard({
    Key? key,
    required this.colors,
    required this.pallete,
    required this.title,
    required this.index,
  }) : super(key: key);

  final List<Color> colors;
  final Pallete pallete;
  final List<String> title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.push(
            context,
            CustomPageRoute(
              context,
              Donate(
                title: title[index],
                color: colors[index],
              ),
            ),
          ),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: getHeight(100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: colors[index],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "${index + 1}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getWidth(60),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Text(
                      title[index],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: title[index].length > 26
                            ? getWidth(16)
                            : title[index].length > 21
                                ? getWidth(18)
                                : getWidth(20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Image.asset(
                    "assets/images/donations/$index.jpg",
                    width: 60,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (index != 16) const SizedBox(height: 10),
      ],
    );
  }
}
