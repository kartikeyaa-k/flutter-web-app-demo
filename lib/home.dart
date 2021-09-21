import 'package:flutter/material.dart';
import 'package:nuchange_web_app/widget/app_body.dart';
import 'package:nuchange_web_app/widget/app_footer.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(),
            AppBody(),
            AppFooter(),
          ],
        ),
      )),
    );
  }
}
