import 'package:flutter/material.dart';
import 'package:nuchange_web_app/util/app_resposive.dart';

class AppBar extends StatelessWidget {
  const AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
    return Container(
      width: wp(100),
      height: hp(20),
      decoration: BoxDecoration(border: Border.all()),
    );
  }
}
