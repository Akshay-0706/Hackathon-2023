import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hackathon/size.dart';
import 'package:hackathon/theme.dart';

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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          print("Tap");
                        },
                        borderRadius: BorderRadius.circular(17),
                        child: Icon(
                          Icons.notifications_rounded,
                          color: pallete.primaryDark(),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 70),
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
                            backgroundColor:
                                pallete.primaryDark().withOpacity(0.4),
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
                        "Categories",
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
                            Categories(pallete: pallete),
                            const SizedBox(width: 20),
                            Categories(pallete: pallete),
                            const SizedBox(width: 20),
                            Categories(pallete: pallete),
                            const SizedBox(width: 20),
                            Categories(pallete: pallete),
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
                            CompaignCard(pallete: pallete),
                            const SizedBox(width: 20),
                            CompaignCard(pallete: pallete),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
  }) : super(key: key);

  final Pallete pallete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(290),
      height: getWidth(290),
      decoration: BoxDecoration(
        border: Border.all(
          color: pallete.primaryLight().withOpacity(0.4),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl:
                    "https://cleanbinheroes.com/wp-content/uploads/2021/07/taking-trash-out.jpg",
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: getWidth(150),
                  child: Text(
                    "Help to Sarah to defeat pollution",
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
                    border: Border.all(
                      color: pallete.primaryLight().withOpacity(0.4),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "Medical",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: pallete.primaryLight(),
                        fontSize: getWidth(16),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "Hello there Hello there Hello there Hello there Hello there Hello there Hello there Hello there Hello there ",
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
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.pallete,
  }) : super(key: key);

  final Pallete pallete;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: getWidth(70),
          height: getWidth(70),
          decoration: BoxDecoration(
            // color: pallete.primaryDark(),
            border: Border.all(
              color: pallete.primaryDark(),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset(
              "assets/icons/logo.svg",
              color: pallete.primaryDark(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Food",
          style: TextStyle(
            color: pallete.primaryDark(),
            fontSize: getWidth(14),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
