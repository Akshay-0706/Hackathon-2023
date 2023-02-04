import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hackathon/backend/Auth/database.dart';
import 'package:hackathon/size.dart';
import 'package:hackathon/theme.dart';

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
        await Database.getBalance(databaseRef, "akshay0706vhatkar@gmail.com");
    print('data shown');
    print(data);
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
            children: [
              level == null
                  ? CircularProgressIndicator()
                  : Expanded(
                      child: FirebaseAnimatedList(
                          query: databaseRef.ref('Users').orderByChild('level'),
                          sort: (a, b) {
                            Map user1 = a.value as Map;
                            Map user2 = b.value as Map;
                            return user2['level'] - user1['level'];
                          },
                          itemBuilder: ((context, snapshot, animation, index) {
                            print(snapshot.value);
                            print(snapshot.key);
                            Map user = snapshot.value as Map;
                            user['key'] = snapshot.key;
                            return buildUser(
                                context, index + 1, snapshot.key!, user);
                          })),
                    ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildUser(BuildContext context, int index, String email, var user) {
  return Container(
    margin: EdgeInsets.only(bottom: 8),
    height: 100,
    width: MediaQuery.of(context).size.width,
    child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: Text(
                    "#$index",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                CircleAvatar(
                  radius: 26.0,
                  backgroundImage: NetworkImage(user['img']),
                  backgroundColor: Colors.transparent,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        user['name'].toString(),
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "email",
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Icon(
            //   Icons.star_outline_rounded,
            //   size: 32,
            // ),
            const SizedBox(
              width: 5,
            ),

            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    height: 30,
                    width: 80,
                    padding: const EdgeInsets.only(right: 100),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.yellow,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
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
                      height: 43,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 10,
                    child: Text(
                      user['level'].toString(),
                      style: TextStyle(
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
        )),
    decoration: BoxDecoration(
      border: email == GetStorage().read('email').replaceAll('.', '_')
          ? Border.all(color: Colors.white, width: 3)
          : null,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          offset: email == GetStorage().read('email').replaceAll('.', '_')
              ? Offset(3, 4)
              : Offset(1, 2),
          blurRadius: 5,
        )
      ],
      color: email != GetStorage().read('email').replaceAll('.', '_')
          ? Colors.blue
          : Colors.yellow,
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
