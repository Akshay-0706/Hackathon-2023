import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hackathon/size.dart';
import 'package:hackathon/theme.dart';

class Tab1 extends StatelessWidget {
  const Tab1({super.key});

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                  imageUrl: GetStorage().read('photo'), width: getWidth(80)),
            ),
            const SizedBox(height: 20),
            Text(
              "Hello, ${GetStorage().read('name')}!",
              style: TextStyle(
                color: pallete.primaryDark(),
                fontSize: getWidth(18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
