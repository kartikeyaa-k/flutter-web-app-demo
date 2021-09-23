import 'package:flutter/material.dart';
import 'package:nuchange_web_app/util/app_responsive.dart';

import 'app_style.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
    final Function font = ScreenUtils(MediaQuery.of(context)).getFontSize;

    return Container(
      width: wp(100),
      height: hp(40),
      child: Card(
        elevation: 10,
        color: borderColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 200,
          child: Container(
            padding: EdgeInsets.all(hp(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //logo
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Logo',
                      style: TextStyle(
                          fontFamily: 'Nunito-Black',
                          fontSize: font(extraLargeFont),
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "© Company",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Nunito-ExtraLight',
                          fontSize: font(lightFont),
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: hp(1),
                    ),
                    Text(
                      "Terms and Conditions",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Nunito-ExtraLight',
                          fontSize: font(lightFont),
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: hp(1),
                    ),
                    Text(
                      "Privacy Policy",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Nunito-ExtraLight',
                          fontSize: font(lightFont),
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.normal,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: hp(1),
                    ),
                  ],
                ),
                SizedBox(
                  width: 0,
                ),
                //social icons
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  "Contact Us",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Nunito-ExtraLight',
                      fontSize: font(lightFont),
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "About Us",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Nunito-ExtraLight',
                      fontSize: font(lightFont),
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Careers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Nunito-ExtraLight',
                      fontSize: font(lightFont),
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.normal,
                      color: Colors.white),
                ),

                SizedBox(
                  width: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
