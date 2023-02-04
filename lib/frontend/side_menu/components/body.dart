import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hackathon/global.dart';

import '../../../size.dart';
import '../../../theme.dart';

class SideMenuBody extends StatelessWidget {
  const SideMenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    Pallete pallete = Pallete(context);
    return Scaffold(
      backgroundColor: pallete.primaryDark(),
      body: Container(
        width: SizeConfig.width * Global.drawerOffset,
        height: double.infinity,
        color: pallete.primaryDark(),
        child: Column(),
      ),
    );
  }
}
