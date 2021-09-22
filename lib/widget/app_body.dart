import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuchange_web_app/bloc/product_cubit.dart';
import 'package:nuchange_web_app/network/data/product.dart';
import 'package:nuchange_web_app/util/app_responsive.dart';
import 'package:nuchange_web_app/widget/app_dialog.dart';

class AppBody extends StatefulWidget {
  const AppBody({Key? key}) : super(key: key);

  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  ProductsCubit _cubit = ProductsCubit(InitialProductState());
  String _chosenValue = 'Default';
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool isLoading = false;
  @override
  void initState() {
    _cubit.getProducts(false);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = ScreenUtils(MediaQuery.of(context)).wp;
    final Function hp = ScreenUtils(MediaQuery.of(context)).hp;
    return Container(
      height: hp(90),
      child: Column(
        children: [
          Container(
            height: hp(10),
            width: wp(20),
            child: DropdownButton<String>(
              focusColor: Colors.black,
              value: _chosenValue,
              //elevation: 5,
              hint: Container(child: Text('Select Category Code')),
              style: TextStyle(fontSize: 16, color: Colors.black),
              iconEnabledColor: Colors.black,
              dropdownColor: Color(0xFF3d4250),
              items: <String>[
                'Default',
                'Vegetables',
                'Fruits',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),

              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              onChanged: (String? value) {
                setState(() {
                  _chosenValue = value ?? "";
                });
                print('chisssssss vall $_chosenValue');
                _cubit.filterProducts(_chosenValue, _products);
              },
            ),
          ),
          BlocListener<ProductsCubit, ProductState>(
              bloc: _cubit,
              listener: (context, state) {
                if (state is LoadingProductState) {
                  print(':: kartik products loading');
                  setState(() {
                    isLoading = true;
                    _filteredProducts.clear();
                  });
                } else if (state is LoadedProductState) {
                  print(
                      ':: kartik products loaded length : ${state.productList.length}');
                  setState(() {
                    isLoading = false;
                    _products = state.productList;
                  });
                } else if (state is FailedProductState) {
                } else if (state is LoadingFilterProductState) {
                  print(':: kartik products filter loading');
                  setState(() {
                    isLoading = true;
                    _filteredProducts.clear();
                  });
                } else if (state is LoadedFilterProductState) {
                  setState(() {
                    _filteredProducts = state.productList;
                    isLoading = false;
                  });
                } else if (state is FailedFilterProductState) {}
              },
              child: isLoading
                  ? CircularProgressIndicator()
                  : _filteredProducts.length > 0
                      ? GridView.builder(
                          itemCount: _filteredProducts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: (1.92),
                          ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                productDialog(context, _filteredProducts[index],
                                    _products);
                              },
                              child: Card(
                                child: Container(
                                  child:
                                      Text(_filteredProducts[index].name ?? ""),
                                ),
                              ),
                            );
                          })
                      : GridView.builder(
                          itemCount: _products.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: (1.92),
                          ),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                productDialog(
                                    context, _products[index], _products);
                              },
                              child: Card(
                                child: Container(
                                  child: Text(_products[index].name ?? ""),
                                ),
                              ),
                            );
                          })),
        ],
      ),
    );
  }
}
