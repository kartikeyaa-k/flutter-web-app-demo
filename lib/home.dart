import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuchange_web_app/bloc/product_cubit.dart';
import 'package:nuchange_web_app/util/app_responsive.dart';
import 'package:nuchange_web_app/widget/app_bar.dart';
import 'package:nuchange_web_app/widget/app_body.dart';
import 'package:nuchange_web_app/widget/app_footer.dart';
import 'package:nuchange_web_app/widget/app_style.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // ideally this widget will have user data hence keeping it by default stateful

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: g1,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [AppBarView(), AppBody(), AppFooter()],
        ),
      )),
    );
  }
}
