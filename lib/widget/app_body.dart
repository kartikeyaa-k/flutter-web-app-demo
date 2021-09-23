import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuchange_web_app/bloc/product_cubit.dart';
import 'package:nuchange_web_app/network/data/product.dart';
import 'package:nuchange_web_app/util/app_responsive.dart';
import 'package:nuchange_web_app/widget/app_dialog.dart';
import 'package:nuchange_web_app/widget/app_style.dart';

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
  final List<String> imgList = [
    'assets/slider/fe1.jpeg',
    'assets/slider/fr2.jpeg',
    'assets/slider/fr3.jpeg',
    'assets/slider/fr4.jpeg',
    'assets/slider/fr5.jpeg',
  ];
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
    final Function font = ScreenUtils(MediaQuery.of(context)).getFontSize;

    _productCard(Product product) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        // ignore: deprecated_member_use
        child: RaisedButton(
          onPressed: () {
            productDialog(context, product, _products);
          },
          hoverColor: Color(0xFFC3B1E1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          color: Colors.white,
          elevation: 12,
          child: Container(
              height: hp(35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: wp(5),
                    child: Image.asset(
                      product.image ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(hp(1)),
                    child: Text(
                      product.name ?? "",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: font(mediumFont),
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.normal,
                          color: Color(0xFF3d4250)),
                    ),
                  ),
                ],
              )),
        ),
      );
    }

    Widget filterRow = Container(
      width: wp(60),
      height: hp(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: hp(10),
            child: Row(
              children: [
                Text('Filter by category : ',
                    style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: font(lightFont),
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: g3)),
                SizedBox(width: wp(1)),
                DropdownButton<String>(
                  underline: SizedBox(),
                  focusColor: g2,
                  value: _chosenValue,
                  elevation: 5,
                  isDense: true,
                  style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: font(lightFont),
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      color: g3),
                  iconEnabledColor: darkBg,
                  dropdownColor: g1,
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
                    color: darkBg,
                  ),
                  onChanged: (String? value) {
                    if (_chosenValue != value) {
                      setState(() {
                        _chosenValue = value ?? "";
                      });

                      _cubit.filterProducts(_chosenValue, _products);
                    }
                  },
                ),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {},
            // hoverColor: Color(0xFF3d4250),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: loginBttnColor,
            hoverColor: hoverColor,
            elevation: 12,
            child: Container(
                height: hp(4.4),
                width: wp(4),
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text('Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: font(lightFont),
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: lightBg)),
                )),
          ),
        ],
      ),
    );

    Widget slider = Container(
      height: hp(30),
      child: CarouselSlider(
        options: CarouselOptions(
            height: 600,
            autoPlayInterval: Duration(milliseconds: 1700),
            viewportFraction: 0.4,
            enableInfiniteScroll: true,
            autoPlayCurve: Curves.elasticIn,
            autoPlay: true,
            aspectRatio: 1,
            pageSnapping: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            enlargeCenterPage: true),
        items: imgList
            .map((item) => Container(
                  child: Center(child: Image.asset(item, fit: BoxFit.fitWidth)),
                ))
            .toList(),
      ),
    );

    return Container(
      padding: EdgeInsets.only(top: hp(1), bottom: hp(2)),
      child: Column(
        children: [
          filterRow,
          SizedBox(height: hp(1)),
          slider,
          SizedBox(height: hp(1)),
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
              child: Padding(
                padding:
                    EdgeInsets.only(top: hp(4), left: wp(10), right: wp(10)),
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
                              return _productCard(_filteredProducts[index]);
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
                              return _productCard(_products[index]);
                            }),
              )),
        ],
      ),
    );
  }
}
