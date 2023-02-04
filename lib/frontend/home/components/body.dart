import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon/frontend/side_menu/side_menu.dart';
import 'package:hackathon/size.dart';
import 'package:hackathon/theme.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int current = 0;

  final List<Widget> tabs = [
    const SideMenu(),
  ];

  void onChanged(int index) {
    if (current != index) {
      setState(() {
        current = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: SizeConfig.width,
          height: 60,
          decoration: BoxDecoration(
            color: pallete.primaryDark(),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 3),
                  blurRadius: 8,
                  color: pallete.background().withOpacity(0.5)),
            ],
          ),
          child: Row(
            children: [
              NavItem(
                index: 0,
                current: current,
                pallete: pallete,
                onChanged: onChanged,
              ),
              NavItem(
                index: 1,
                current: current,
                pallete: pallete,
                onChanged: onChanged,
              ),
              NavItem(
                index: 2,
                current: current,
                pallete: pallete,
                onChanged: onChanged,
              ),
              NavItem(
                index: 3,
                current: current,
                pallete: pallete,
                onChanged: onChanged,
              ),
              NavItem(
                index: 4,
                current: current,
                pallete: pallete,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
      body: Container(),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    Key? key,
    required this.pallete,
    required this.index,
    required this.current,
    required this.onChanged,
  }) : super(key: key);
  final int index, current;
  final Pallete pallete;
  final Function onChanged;
  final int totalItems = 5;

  @override
  Widget build(BuildContext context) {
    final double itemWidth = (SizeConfig.width - 40) * (1 / totalItems);
    return InkWell(
      onTap: () => onChanged(index),
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        width: itemWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: current == index ? 20 : 0,
              height: current == index ? 4 : 0,
              decoration: BoxDecoration(
                color: pallete.background(),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 5),
            SvgPicture.asset(
              "assets/icons/account.svg",
              color: current == index
                  ? pallete.background()
                  : pallete.background().withOpacity(0.5),
              width: 24,
            ),
          ],
        ),
      ),
    );
  }
}