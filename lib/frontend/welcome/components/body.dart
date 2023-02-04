import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hackathon/backend/Auth/account.dart';
import 'package:lottie/lottie.dart';

import '../../../backend/Auth/user_account.dart';
import '../../../size.dart';
import '../../components/primary_btn.dart';
import 'app_title.dart';

class WelcomeBody extends StatefulWidget {
  const WelcomeBody({super.key});

  @override
  State<WelcomeBody> createState() => _WelcomeBodyState();
}

class _WelcomeBodyState extends State<WelcomeBody> {
  // Future<SharedPreferences> sharedPreferences = SharedPreferences.getInstance();
  // late SharedPreferences pref;
  final box = GetStorage();
  bool signedIn = false, signin = false;

  @override
  void initState() {
    signedIn = box.read('signedIn') ?? false;
    // sharedPreferences.then((value) {
    //   pref = value;
    //   setState(() {
    //     prefIsReady = true;
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),
          const AppTitle(),
          const Spacer(),
          LottieBuilder.asset(
            "assets/extras/lottie_welcome.json",
            repeat: false,
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: getHeight(20)),
            child: Text(
              "Welcome to Split-it, with this app you can easily keep track of your expenses, split bills among your friends and stay in your budget!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
                fontSize: getWidth(16),
              ),
            ),
          ),
          SizedBox(height: getHeight(20)),
          if (!signin)
            PrimaryBtn(
              title: "Continue",
              primaryColor: Theme.of(context).primaryColor,
              secondaryColor: Theme.of(context).primaryColor.withOpacity(0.8),
              titleColor: Colors.white,
              padding: getWidth(20),
              hasIcon: false,
              tap: () {
                setState(() {
                  signin = true;
                });
                UserAccount.googleLogin().then((value) {
                  Account user = value!;
                  if (!signedIn || box.read('email') != user.email) {
                    box.write('name', user.name);
                    box.write('photo', user.photo);
                    box.write('email', user.email);
                    box.write('id', user.id);
                    box.write('signedIn', true);
                  }
                  Navigator.pushReplacementNamed(context, "/home");
                });
              },
            ),
          if (signin)
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          SizedBox(height: getHeight(60)),
        ],
      ),
    );
  }
}
