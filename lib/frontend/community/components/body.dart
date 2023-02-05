import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon/theme.dart';

import '../../../backend/database/database.dart';
import '../../../size.dart';

class CommunityBody extends StatefulWidget {
  const CommunityBody({super.key});

  @override
  State<CommunityBody> createState() => _CommunityBodyState();
}

class _CommunityBodyState extends State<CommunityBody> {
  FirebaseDatabase databaseRef = FirebaseDatabase.instance;
  var data;

  void getData() async {
    data = await Database.getCommunity(databaseRef);
    setState(() {});
  }

  late Timer timer;

  @override
  void initState() {
    getData();
    timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      getData();
      if (data != null) this.timer.cancel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 2,
          title: Text(
            "Community",
            style: TextStyle(
              color: pallete.primaryDark(),
              fontSize: getWidth(24),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: pallete.primaryDark(),
          child: Icon(
            Icons.add,
            color: pallete.background(),
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/newpost');
          },
        ),
        body: data == null
            ? Center(
                child: CircularProgressIndicator(
                color: pallete.primary(),
              ))
            : FirebaseAnimatedList(
                physics: const BouncingScrollPhysics(),
                query: databaseRef.ref('Community').orderByChild('timestamp'),
                sort: (a, b) {
                  Map user1 = a.value as Map;
                  Map user2 = b.value as Map;
                  return DateTime.parse(user1['timestamp'])
                          .isAfter(DateTime.parse(user2['timestamp']))
                      ? -1
                      : 1;
                },
                itemBuilder: ((context, snapshot, animation, index) {
                  return buildCard(context, snapshot.value);
                }),
              ),
      ),
    );
  }
}

Widget buildCard(BuildContext context, var snapshot) {
  Pallete pallete = Pallete(context);
  print(snapshot);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 10),
      Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: getHeight(300)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      imageUrl: snapshot['userImg'],
                      width: getWidth(50),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot['name'],
                        style: TextStyle(
                          color: pallete.primaryDark(),
                          fontSize: getWidth(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        snapshot['user'],
                        style: TextStyle(
                          color: pallete.primaryDark(),
                          fontSize: getWidth(12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: CachedNetworkImage(
                imageUrl: snapshot['img'],
                height: getHeight(200),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                snapshot['title'],
                style: TextStyle(
                  color: pallete.primaryDark(),
                  fontSize: getWidth(18),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                snapshot['desc'],
                maxLines: 2,
                style: TextStyle(
                  color: pallete.primaryDark().withOpacity(0.7),
                  fontSize: getWidth(14),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Divider(
              color: pallete.primaryDark(),
              height: 2,
            )
          ],
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}
