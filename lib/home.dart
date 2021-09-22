import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuchange_web_app/bloc/product_cubit.dart';
import 'package:nuchange_web_app/util/app_resposive.dart';
import 'package:nuchange_web_app/widget/app_body.dart';
import 'package:nuchange_web_app/widget/app_footer.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ProductsCubit _cubit = ProductsCubit(InitialProductState());
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;

    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [AppBar(), AppBody(), AppFooter()],
        ),
      )),
    );
  }
}
