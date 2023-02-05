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
                  top: -7,
                  right: -14,
                  child: SvgPicture.asset(
                    'assets/icons/coin.svg',
                    height: 70,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: getWidth(20)),
          const MyWidget(),
        ],
      ),
    ));
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        buildRow(context),
        buildRow(context),
        buildRow(context),
      ],
    ));
  }

  buildRow(context) {
    final width = MediaQuery.of(context).size.width - 70;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildContainer(context, false),
          buildContainer(context, true),
        ],
      ),
    );
  }

  buildContainer(context, isExpired) {
    final width = MediaQuery.of(context).size.width - 70;

    return Container(
      height: width / 2,
      width: width / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
              top: 100,
              left: 10,
              child: SvgPicture.asset(
                'assets/icons/google_logo.svg',
                width: width / 8,
              )),
          Positioned(bottom: 10, left: 10, child: Container()),
          Positioned(
              top: width / 4 - 10,
              child: Container(
                color: Colors.grey,
                height: 20,
                width: width / 2,
                child: const Text(
                  'Expired',
                  textAlign: TextAlign.center,
                ),
              )),
          Positioned(
            top: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Gift Card',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  'Gift Voucher Rs 100',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
