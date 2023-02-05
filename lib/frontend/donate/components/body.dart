import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hackathon/frontend/components/primary_btn.dart';
import 'package:hackathon/frontend/screen/screen.dart';
import 'package:hackathon/size.dart';
import 'package:hackathon/theme.dart';
import 'package:lottie/lottie.dart';

import '../../../global.dart';
import '../../components/custom_page_route.dart';

class DonateBody extends StatelessWidget {
  const DonateBody({super.key, required this.title, required this.color});
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: color.withOpacity(0.2),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ListView(
            children: [
              SizedBox(height: getHeight(20)),
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: getWidth(34),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: getWidth(24),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Donate Now!",
                    style: TextStyle(
                      color: pallete.primaryDark(),
                      fontSize: getWidth(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: getHeight(20)),
              Container(
                height: getWidth(180),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: getWidth(10)),
                        SvgPicture.asset("assets/extras/donation_chip.svg"),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                "assets/extras/donation_design_5.svg"),
                            Row(
                              children: [
                                SizedBox(width: getWidth(10)),
                                SvgPicture.asset(
                                    "assets/extras/donation_design_2.svg"),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                "assets/extras/donation_design_4.svg"),
                            SizedBox(height: getWidth(5)),
                            Row(
                              children: [
                                SizedBox(width: getWidth(40)),
                                SvgPicture.asset(
                                    "assets/extras/donation_design_3.svg"),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        SvgPicture.asset("assets/extras/donation_design_6.svg"),
                        const Spacer(),
                        SvgPicture.asset(
                          "assets/extras/donation_design_7.svg",
                          width: getWidth(30),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Global SDG",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: getWidth(20),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "EcoQuest",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: getWidth(16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                  "assets/extras/donation_design_8.svg"),
                              SvgPicture.asset(
                                "assets/extras/donation_design_1.svg",
                                width: getWidth(50),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: pallete.primaryDark(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: color.withOpacity(1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: getHeight(20)),
                          Text(
                            "Invoice from Global SDG",
                            style: TextStyle(
                              color: pallete.background(),
                              fontSize: getWidth(18),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Billed to ${title.toLowerCase()}",
                            style: TextStyle(
                              color: pallete.background().withOpacity(0.8),
                              fontSize: getWidth(14),
                            ),
                          ),
                          SizedBox(height: getHeight(20)),
                        ],
                      ),
                    ),
                    SizedBox(height: getHeight(20)),
                    Text(
                      "+91 XXXX X0266",
                      style: TextStyle(
                        color: pallete.background(),
                        fontSize: getWidth(18),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Banking Name: Akshay Vaman Vhatkar",
                      style: TextStyle(
                        color: pallete.background().withOpacity(0.8),
                        fontSize: getWidth(14),
                      ),
                    ),
                    SizedBox(height: getHeight(20)),
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: TextField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          // controller: textEditingController,
                          keyboardType: TextInputType.number,
                          cursorColor: pallete.primary(),
                          style: TextStyle(
                              fontSize: getWidth(30),
                              color: pallete.background()),
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            prefixIconColor: Colors.black,
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                "\u{20B9}",
                                style: TextStyle(
                                  color: pallete.background(),
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Add a Note(Optional)",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: pallete.background(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        // focusNode: node2,
                        minLines: 2,
                        maxLines: 3,
                        cursorColor: pallete.primaryDark(),

                        textInputAction: TextInputAction.done,
                        style: TextStyle(color: pallete.primaryDark()),
                        decoration: InputDecoration(
                          hintText: "Add a note...",
                          hintStyle: TextStyle(
                              color: pallete.primaryLight().withOpacity(0.9)),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 238, 237, 237),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 242, 241, 241),
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 242, 241, 241),
                              )),
                        ),
                      ),
                    ),
                    SizedBox(height: getHeight(5)),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              PrimaryBtn(
                primaryColor: pallete.primaryDark(),
                secondaryColor: pallete.primaryDark().withOpacity(0.9),
                padding: 0,
                title: "Proceed",
                tap: () {
                  showDialog(
                    context: context,
                    builder: (_) => WillPopScope(
                      onWillPop: () async => false,
                      child: AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        title: Text(
                          "Payment successful",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: pallete.primaryDark(),
                            fontSize: getHeight(20),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Lottie.asset(
                              "assets/extras/lottie_donation_success.json",
                              width: getHeight(120),
                              height: getHeight(120),
                            ),
                            Text(
                              "Thank you!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.8),
                                fontSize: getHeight(14),
                              ),
                            ),
                            SizedBox(height: getHeight(10)),
                            PrimaryBtn(
                              primaryColor: pallete.primaryDark(),
                              secondaryColor: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.8),
                              padding: 20,
                              title: "Continue",
                              tap: () {
                                Navigator.pushReplacement(
                                  context,
                                  CustomPageRoute(
                                    context,
                                    const Screen(),
                                  ),
                                );
                              },
                              titleColor: pallete.background(),
                              hasIcon: false,
                            ),
                          ],
                        ),
                        backgroundColor: pallete.background(),
                      ),
                    ),
                  );
                },
                titleColor: pallete.background(),
                hasIcon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
