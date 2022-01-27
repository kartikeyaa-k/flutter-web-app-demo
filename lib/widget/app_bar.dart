import 'package:flutter/material.dart';
import 'package:nuchange_web_app/util/app_responsive.dart';
import 'package:nuchange_web_app/util/app_spacing.dart';
import 'package:nuchange_web_app/widget/app_style.dart';

class AppBarView extends StatelessWidget {
  const AppBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
    final Function fontSize = ScreenUtils(MediaQuery.of(context)).getFontSize;
    Widget logo = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            padding: EdgeInsets.only(
              top: hp(topSpacing),
            ),
            child: Container(
                height: hp(16),
                width: wp(8),
                // decoration: BoxDecoration(border: Border.all()),
                child: Image.asset(
                  "assets/logo/appLogo.png",
                  fit: BoxFit.contain,
                ))),
        Container(
          padding: EdgeInsets.only(top: hp(topSpacing)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Company Name',
                style: TextStyle(
                    fontSize: fontSize(extraLargeFont),
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    color: darkBg),
              ),
              SizedBox(
                height: hp(0.2),
              ),
              Text('- Your Health Is Our Priority'.toUpperCase(),
                  style: TextStyle(
                      fontSize: fontSize(lightFont),
                      fontStyle: FontStyle.normal,
                      color: darkBg)),
            ],
          ),
        ),
      ],
    );

    Widget searchBar = Container(
        width: wp(60),
        child: TextField(
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: borderColor, width: 2.0),
              ),
              hintText: 'Search Products by Name, Category, Vendor, Price',
              suffixIcon: Icon(Icons.search)),
        ));

    return Container(
      width: wp(100),
      // decoration: BoxDecoration(border: Border.all()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          logo,
          SizedBox(
            height: hp(1),
          ),
          searchBar
        ],
      ),
    );
  }
}
