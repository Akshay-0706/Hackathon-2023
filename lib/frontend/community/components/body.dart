import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/backend/Auth/database.dart';
import 'package:hackathon/theme.dart';

class CommunityPageBody extends StatefulWidget {
  const CommunityPageBody({super.key});

  @override
  State<CommunityPageBody> createState() => _CommunityPageBodyState();
}

class _CommunityPageBodyState extends State<CommunityPageBody> {
  FirebaseDatabase databaseRef = FirebaseDatabase.instance;
  var data;

  void getData() async {
    data = await Database.getCommunity(databaseRef);
    // print(data.length());
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/NewPost');
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => NewPost(id:),
            //   ),
            // );
          },
        ),
        body: data == null
            ? CircularProgressIndicator()
            : FirebaseAnimatedList(
                query: databaseRef.ref('Community').orderByChild('timestamp'),
                sort: (a, b) {
                  Map user1 = a.value as Map;
                  Map user2 = b.value as Map;
                  print(user1['timestamp']);
                  print(user2['timestamp']);
                  return DateTime.parse(user1['timestamp'])
                          .isAfter(DateTime.parse(user2['timestamp']))
                      ? -1
                      : 1;
                },
                itemBuilder: ((context, snapshot, animation, index) {
                  print(snapshot.value);
                  print("hi");
                  return buildCard(context, snapshot.value);
                })),
      ),
    );
  }
}

Widget buildCard(BuildContext context, var snapshot) {
  Pallete pallete = Pallete(context);
  return Container(
    child: Column(
      children: [
        Text(
          snapshot['desc'],
        ),
        Text(snapshot['likes'].toString()),
        Text(
          snapshot['user'],
        ),
        Text(
          snapshot['timestamp'],
          style: TextStyle(color: Colors.black),
        )
      ],
    ),
    decoration: BoxDecoration(
      color: pallete.primaryDark(),
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
            offset: Offset(0, 3),
            blurRadius: 8,
            color: pallete.primaryDark().withOpacity(0.3)),
      ],
    ),
  );
}
