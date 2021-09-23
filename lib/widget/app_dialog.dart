import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuchange_web_app/bloc/product_cubit.dart';
import 'package:nuchange_web_app/network/data/product.dart';
import 'package:nuchange_web_app/util/app_responsive.dart';
import 'package:nuchange_web_app/util/form_validators.dart';
import 'package:nuchange_web_app/widget/app_style.dart';

void productDialog(
    BuildContext context, Product filteredProduct, List<Product> orginalList) {
  ProductsCubit _cubit = ProductsCubit(InitialProductState());
  TextEditingController quantity = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  quantity.text = '';
  showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
        final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
        final Function font = ScreenUtils(MediaQuery.of(context)).getFontSize;
        return StatefulBuilder(builder: (context, setState) {
          return BlocListener<ProductsCubit, ProductState>(
            bloc: _cubit,
            listener: (context, state) {
              if (state is LoadingUpdateProductsState) {
              } else if (state is LoadedUpdateProductsState) {
                updateDisplay(context, state.productList);
              } else if (state is FailedUpdateProductsState) {}
            },
            child: Scaffold(
                backgroundColor: Colors.black.withOpacity(0.7),
                body: Center(
                  child: Container(
                    width: wp(24),
                    height: hp(40),
                    child: Card(
                      elevation: 10,
                      color: lightBg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Container(
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(hp(2)),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          height: hp(19),
                                          width: wp(9),
                                          child: Image.asset(
                                            filteredProduct.image ?? "",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        SizedBox(width: wp(1)),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Product Name :',
                                                      style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize:
                                                              font(lightFont),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          color: g3)),
                                                  Text(
                                                      '${filteredProduct.name}',
                                                      style: TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontSize:
                                                              font(mediumFont),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          color: g3)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: hp(0.5),
                                            ),
                                            Text(
                                                'Product Price : ${filteredProduct.price}',
                                                style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize: font(lightFont),
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    color: g3)),
                                            SizedBox(
                                              height: hp(0.5),
                                            ),
                                            Text(
                                                'Vendor : ${filteredProduct.vendor}',
                                                style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize: font(lightFont),
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    color: g3)),
                                            SizedBox(
                                              height: hp(0.5),
                                            ),
                                            Text(
                                                'Category : ${filteredProduct.category}',
                                                style: TextStyle(
                                                    fontFamily: 'Nunito',
                                                    fontSize: font(lightFont),
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle: FontStyle.normal,
                                                    color: g3))
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: hp(3)),

                                    // Mobile Number
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: wp(4), right: wp(4)),
                                      child: Column(children: [
                                        Form(
                                          key: _formKey,
                                          child: TextFormField(
                                            controller: quantity,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(
                                                  7),
                                            ],
                                            validator: (String? val) {
                                              if (val == '' || val == null) {
                                                return "Please add quantity";
                                              } else if (!isNumericUsingRegularExpression(
                                                  val)) {
                                                return "Please provide valid quantity";
                                              } else {
                                                return null;
                                              }
                                            },
                                            style: TextStyle(
                                                fontSize: font(lightFont),
                                                color: g3),
                                            decoration: InputDecoration(
                                              hintText: 'Quantity',
                                              hintStyle: TextStyle(
                                                  fontSize: font(lightFont),
                                                  color: g3.withOpacity(0.5)),
                                              labelStyle: TextStyle(
                                                  fontSize: font(lightFont),
                                                  color: g3),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: g3,
                                                ),
                                              ),
                                              enabledBorder:
                                                  new UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: g3,
                                                          width: 1.0)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: hp(1),
                                        ),
                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              print(
                                                  ':: kartik current form quantity : ${quantity.text}');
                                              if (filteredProduct.id != null) {
                                                _cubit.updateProducts(
                                                    false,
                                                    filteredProduct.id!,
                                                    orginalList,
                                                    quantity.text);
                                              } else {
                                                // throw an error
                                                // something went wrong
                                              }
                                            }
                                          },
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          color: loginBttnColor,
                                          hoverColor: hoverColor,
                                          elevation: 12,
                                          child: Container(
                                              height: hp(4.4),
                                              width: wp(8),
                                              alignment: Alignment.center,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Text('Purchase',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'Nunito',
                                                        fontSize:
                                                            font(lightFont),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        color: lightBg)),
                                              )),
                                        ),
                                      ]),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: wp(0.7), top: hp(1)),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: g3,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          );
        });
      });
}

void updateDisplay(BuildContext context, List<Product> updatedProductList) {
  String map = json.encode(updatedProductList);
  print(map);

  showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
        final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
        final Function font = ScreenUtils(MediaQuery.of(context)).getFontSize;

        return StatefulBuilder(builder: (context, setState) {
          return Scaffold(
              backgroundColor: Colors.black.withOpacity(0.7),
              body: Center(
                child: Container(
                  width: hp(50),
                  height: wp(60),
                  child: Card(
                    elevation: 10,
                    color: g1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Container(
                      child: Stack(
                        children: [
                          Container(
                            height: hp(50),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: hp(5),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(hp(2)),
                                    child: Text(map,
                                        maxLines: 20,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Nunito',
                                            fontSize: font(lightFont),
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            color: g3)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(),
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 15, top: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: g3,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
      });
}
