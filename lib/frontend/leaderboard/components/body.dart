import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hackathon/theme.dart';

import '../../../backend/database/database.dart';
import '../../../size.dart';

class LeaderBoardBody extends StatefulWidget {
  const LeaderBoardBody({super.key});

  @override
  State<LeaderBoardBody> createState() => _LeaderBoardBodyState();
}

class _LeaderBoardBodyState extends State<LeaderBoardBody> {
  FirebaseDatabase databaseRef = FirebaseDatabase.instance;
  int? progress, level;
  bool isLoaded = false;

  void getData() async {
    final data =
        await Database.getBalance(databaseRef, GetStorage().read('email'));
    print('data shown');
    print(data);
    if (mounted)
      setState(() {
        progress = data['progress'];
        level = data['level'];
      });
  }

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                    "Leaderboard",
                    style: TextStyle(
                      color: pallete.primaryDark(),
                      fontSize: getWidth(24),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: getHeight(20)),
              level == null
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: FirebaseAnimatedList(
                        query: databaseRef.ref('Users').orderByChild('level'),
                        sort: (a, b) {
                          Map user1 = a.value as Map;
                          Map user2 = b.value as Map;
                          return user2['level'] - user1['level'];
                        },
                        itemBuilder: ((context, snapshot, animation, index) {
                          Map user = snapshot.value as Map;
                          user['key'] = snapshot.key;
                          return buildUser(
                              context, index + 1, snapshot.key!, user);
                        }),
                      ),
                    ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildUser(BuildContext context, int index, String email, var user) {
  Pallete pallete = Pallete(context);
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      border: email == GetStorage().read('email').replaceAll('.', '_')
          ? Border.all(color: pallete.primaryDark(), width: 1)
          : Border.all(color: pallete.primaryDark(), width: 1),
      boxShadow: [
        BoxShadow(
          color: pallete.primaryDark().withOpacity(0.5),
          offset: email == GetStorage().read('email').replaceAll('.', '_')
              ? const Offset(3, 4)
              : const Offset(1, 2),
          blurRadius: 8,
        )
      ],
      color: email != GetStorage().read('email').replaceAll('.', '_')
          ? Colors.blue
          : Colors.yellow,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "#$index",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: user['img'] == null
                    ? const Icon(Icons.person_rounded)
                    : CachedNetworkImage(
                        imageUrl: user['img'],
                        width: getWidth(50),
                      ),
              ),
              SizedBox(
                width: SizeConfig.width * 0.4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user['name'].toString(),
                        // "Long long long long name",
                        maxLines: 2,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "email",
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: getWidth(12),
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 0),
                  height: 30,
                  width: 60,
                  padding: const EdgeInsets.only(right: 100),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.yellow,
                    border: Border.all(
                      color: pallete.primaryDark(),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: const Offset(1, 2),
                        blurRadius: 5,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Positioned(
                  top: -6,
                  right: -2,
                  child: SvgPicture.asset(
                    'assets/icons/trophy.svg',
                    height: 40,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 10,
                  child: Text(
                    user['level'].toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
