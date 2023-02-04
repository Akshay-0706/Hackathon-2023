import 'package:flutter/material.dart';
import 'package:hackathon/const.dart';
import 'package:hackathon/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../backend/challenges/chart_data.dart';
import '../../../size.dart';

class ChallengesBody extends StatefulWidget {
  const ChallengesBody({super.key});

  @override
  State<ChallengesBody> createState() => _ChallengesBodyState();
}

class _ChallengesBodyState extends State<ChallengesBody> {
  bool challengeDone = false;
  double? size = null;
  final List<ChartData> chartData = [
    ChartData("Mon", 3),
    ChartData("Tue", 6),
    ChartData("Wed", 3),
    ChartData("Thu", 7),
    ChartData("Fri", 1),
    ChartData("Sat", 3),
    ChartData("Sun", 8),
  ];

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);

    return SafeArea(
      child: TweenAnimationBuilder(
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
                  color: pallete.primaryDark(),
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
                              color: pallete.background(),
                              fontSize: getWidth(24),
                            ),
                          ),
                          Icon(
                            Icons.leaderboard_rounded,
                            color: pallete.background(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
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
                            markerSettings: MarkerSettings(
                              shape: DataMarkerType.circle,
                              color: pallete.primaryDark(),
                            ),
                            xValueMapper: (ChartData data, _) => data.day,
                            yValueMapper: (ChartData data, _) => data.task,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (challengeDone)
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
                                  color: pallete.primaryDark(),
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
              AnimatedContainer(
                duration: Global.drawerDuration,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Challenges for you",
                    style: TextStyle(
                      color: pallete.primaryDark(),
                      fontSize: getWidth(22),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      ...List.generate(
                        6,
                        (index) => ChallengeCard(
                          pallete: pallete,
                          challenge: "Buying an ecofriendly item",
                          index: index,
                          total: 17,
                          challengeDone: challengeDone,
                          reset: () {
                            setState(() {
                              challengeDone = !challengeDone;
                            });
                            Future.delayed(const Duration(milliseconds: 1000),
                                () {
                              setState(() {
                                challengeDone = !challengeDone;
                              });
                            });
                          },
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
    required this.reset,
    required this.challengeDone,
  }) : super(key: key);

  final Pallete pallete;
  final String challenge;
  final int index, total;
  final bool challengeDone;
  final VoidCallback reset;

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
                    onTap: reset,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Global.colors[index % total]
                                  .withOpacity(0.4)),
                          shape: BoxShape.circle),
                      child: Icon(Icons.check, size: challengeDone ? 20 : 0),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        challenge,
                        style: TextStyle(
                          color: pallete.primaryDark(),
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
        if (index != total - 1) const SizedBox(height: 20),
      ],
    );
  }
}
