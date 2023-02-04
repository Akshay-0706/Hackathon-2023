import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon/frontend/donate/components/body.dart';

class Donate extends StatelessWidget {
  const Donate({super.key, required this.title, required this.color});
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DonateBody(title: title, color: color,),
    );
  }
}
