import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon/size.dart';

class RewardsBody extends StatefulWidget {
  const RewardsBody({super.key});

  @override
  State<RewardsBody> createState() => _RewardsBodyState();
}

class _RewardsBodyState extends State<RewardsBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: getHeight(55),
                  width: getWidth(120),
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
                      fontSize: getWidth(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: -5,
                  right: -14,
                  child: SvgPicture.asset(
                    'assets/icons/coin.svg',
                    height: 70,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
