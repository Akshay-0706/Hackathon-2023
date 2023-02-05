import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hackathon/backend/database/database.dart';
import 'package:hackathon/const.dart';
import 'package:hackathon/frontend/challenges/components/detect_image.dart';
import 'package:hackathon/frontend/leaderboard/leaderboard.dart';
import 'package:hackathon/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../backend/challenges/chart_data.dart';
import '../../../size.dart';
import '../../components/custom_page_route.dart';

class ChallengesBody extends StatefulWidget {
  const ChallengesBody({super.key});

  @override
  State<ChallengesBody> createState() => _ChallengesBodyState();
}

class _ChallengesBodyState extends State<ChallengesBody> {
  FirebaseDatabase databaseRef = FirebaseDatabase.instance;
  bool challengeIndex = false;
  bool show = false;
  var data;
  Map? daily;
  List<bool> chal = [false, false, false, false, false];
  List<String> names = [
    "Buy an ecofriendly product",
    "Best out of Waste",
    "Donation to Needy",
    "Classfied and segregated Waste",
    "Tree Plantation"
  ];

  double? size = null;
  late final List<ChartData> chartData;

  dynamic getData() async {
    data = await Database.getBalance(databaseRef, GetStorage().read('email'));
    setState(() {
      daily = data['dailyProgress'] ?? {};
      chartData = [
        ChartData("Mon", daily?['Mon'] ?? 0),
        ChartData("Tue", daily?['Tue'] ?? 0),
        ChartData("Wed", daily?['Wed'] ?? 0),
        ChartData("Thu", daily?['Thu'] ?? 0),
        ChartData("Fri", daily?['Fri'] ?? 0),
        ChartData("Sat", daily?['Sat'] ?? 0),
        ChartData("Sun", daily?['Sun'] ?? 0),
      ];
    });
  }

  @override
  void initState() {
    // Database.getBalance(databaseRef, email);
    // TODO: implement initState
    getData();
    super.initState();
  }

  void dismiss() {
    Future.delayed(Duration(seconds: 3), (() {
      setState(() {
        show = false;
      });
    }));
  }

  void check(int index) {
    // print(index);
    Database.setChallenge(databaseRef, GetStorage().read('email'), index + 1,
        chal[index] ? 0 : 1);
    setState(() {
      chal[index] = !chal[index];
      challengeIndex = chal[index];
      show = true;
      dismiss();
    });
    // chal[index]
  }

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: pallete.background(),
        body: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500),
          builder: (context, double opacity, child) => Opacity(
            opacity: opacity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: pallete.background(),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Challenges this week",
                              style: TextStyle(
                                color: pallete.primaryDark(),
                                fontSize: getWidth(24),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/leaderb');
                              },
                              child: SvgPicture.asset(
                                "assets/icons/leaderboard.svg",
                                width: getWidth(25),
                              ),
                            ),
                          ],
                        ),
                      ),
                      daily == null
                          ? CircularProgressIndicator()
                          : SizedBox(
                              height: getHeight(200),
                              child: SfCartesianChart(
                                enableAxisAnimation: true,
                                primaryXAxis: CategoryAxis(),
                                series: <ChartSeries>[
                                  // Renders spline chart
                                  SplineSeries<ChartData, String>(
                                    dataSource: chartData,
                                    color: pallete.primary(),
                                    xAxisName: "Day",
                                    yAxisName: "Task",
                                    width: 3,
                                    xValueMapper: (ChartData data, _) =>
                                        data.day,
                                    yValueMapper: (ChartData data, _) =>
                                        data.task,
                                  ),
                                ],
                              ),
                            ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                if (challengeIndex && show)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AnimatedContainer(
                      duration: Global.drawerDuration,
                      decoration: BoxDecoration(
                        color: pallete.primary().withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            const Icon(Icons.celebration),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  "Congratulations! You've completed a challenge.",
                                  style: TextStyle(
                                    color: pallete.background(),
                                    fontSize: getWidth(16),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: pallete.primaryDark(),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          AnimatedContainer(
                            duration: Global.drawerDuration,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Challenges for you",
                                style: TextStyle(
                                  color: pallete.background(),
                                  fontSize: getWidth(22),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                children: [
                                  ...List.generate(
                                    5,
                                    (index) => ChallengeCard(
                                      pallete: pallete,
                                      challenge: "Buying an ecofriendly item",
                                      index: index,
                                      total: 17,
                                      challengeIndex: chal[index],
                                      check: check,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({
    Key? key,
    required this.pallete,
    required this.challenge,
    required this.index,
    required this.total,
    required this.check,
    required this.challengeIndex,
  }) : super(key: key);

  final Pallete pallete;
  final String challenge;
  final int index, total;
  final bool challengeIndex;
  final Function check;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Global.colors[index % total].withOpacity(0.4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => check(index),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Global.colors[index % total],
                          ),
                          shape: BoxShape.circle),
                      child: Icon(Icons.check, size: challengeIndex ? 20 : 0),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(
                            context,
                            const DetectImage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          challenge,
                          style: TextStyle(
                            color: pallete.background(),
                            fontSize: getWidth(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (index != total - 1) const SizedBox(height: 20),
      ],
    );
  }
}
