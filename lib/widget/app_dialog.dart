import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuchange_web_app/bloc/product_cubit.dart';
import 'package:nuchange_web_app/network/data/product.dart';
import 'package:nuchange_web_app/util/form_validators.dart';

void productDialog(
    BuildContext context, Product filteredProduct, List<Product> orginalList) {
  ProductsCubit _cubit = ProductsCubit(InitialProductState());
  TextEditingController quantity = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  quantity.text = '0';
  showDialog(
      context: context,
      useSafeArea: false,
      barrierDismissible: true,
      builder: (BuildContext context) {
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
                    width: 400,
                    height: 390,
                    child: Card(
                      elevation: 10,
                      color: Color(0xFF3d4250),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Container(
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                //Login Title
                                SizedBox(height: 20),
                                Container(
                                  padding: EdgeInsets.only(top: 10, left: 10),
                                  alignment: Alignment.center,
                                  width: 399,
                                  child: Text(
                                    filteredProduct.name ?? "",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10, left: 10),
                                  alignment: Alignment.center,
                                  width: 399,
                                  child: Text(
                                    filteredProduct.price.toString(),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10, left: 10),
                                  alignment: Alignment.center,
                                  width: 399,
                                  child: Text(
                                    filteredProduct.vendor ?? "",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10, left: 10),
                                  alignment: Alignment.center,
                                  width: 399,
                                  child: Text(
                                    filteredProduct.category ?? "",
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                SizedBox(height: 30),
                                Form(
                                  key: _formKey,
                                  child: TextFormField(
                                    controller: quantity,
                                    decoration:
                                        InputDecoration(labelText: 'Quanity'),
                                    validator: (String? val) {
                                      val = val!.trim();
                                      if (val.contains('.')) {
                                        return "Please enter quantity as round figure";
                                      } else if (val == '') {
                                        return "Please enter quantity to procede";
                                      } else if (val == '0') {
                                        return "Please enter quantity to procede";
                                      } else if (!isNumericUsingRegularExpression(
                                          val)) {
                                        return "Please enter numeric value";
                                      } else
                                        return null;
                                    },
                                  ),
                                ),
                                // Mobile Number
                                Column(children: [
                                  SizedBox(
                                    height: 25,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
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
                                    child: Card(
                                        // hoverColor: Color(0xFF3d4250),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                        color: Colors.red,
                                        elevation: 12,
                                        child: Container(
                                          height: 30,
                                          width: 80,
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              'Continue',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        )),
                                  ),
                                ]),
                              ],
                            ),
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
                                    color: Colors.white,
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
        return StatefulBuilder(builder: (context, setState) {
          return Scaffold(
              backgroundColor: Colors.black.withOpacity(0.7),
              body: Center(
                child: Container(
                  width: 400,
                  height: 390,
                  child: Card(
                    elevation: 10,
                    color: Color(0xFF3d4250),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    child: Container(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              //Login Title
                              SizedBox(height: 20),

                              SizedBox(height: 30),

                              // Mobile Number
                              Column(children: [
                                SizedBox(
                                  height: 25,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                      // hoverColor: Color(0xFF3d4250),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                      color: Colors.red,
                                      elevation: 12,
                                      child: Container(
                                        height: 30,
                                        width: 80,
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(
                                            'Continue',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )),
                                ),
                              ]),
                            ],
                          ),
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
                                  color: Colors.white,
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
