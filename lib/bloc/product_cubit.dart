import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuchange_web_app/network/data/product.dart';
import 'package:nuchange_web_app/repository/product_repository.dart';
part 'product_state.dart';

class ProductsCubit extends Cubit<ProductState> {
  ProductsCubit(InitialProductState initialState) : super(initialState);

  MovieRepository _movieRepository = MovieRepository();

  Future<void> getProducts(bool forceNetwork) async {
    emit(LoadingProductState());
    print(':: kartik bloc get products');
    try {
      List<Product> productList = await _movieRepository.fetchProductList();

      print(':: kartik bloc product list $productList');

      emit(LoadedProductState(productList));
    } catch (e) {
      emit(FailedProductState());
    }
  }

  Future<void> updateProducts(bool forceNetwork, int productID,
      List<Product> orignalProductList, String quantity) async {
    emit(LoadingUpdateProductsState());
    List<Product> updatedProducts = [];
    print('leng : ${orignalProductList.length}');
    try {
      orignalProductList.forEach((element) {
        if (element.id == productID) {
          print('id matched : $quantity');
          element.quantity = quantity;
          print('id added');
          updatedProducts.add(element);
          print(element.category);
        } else {
          print('elese');
          updatedProducts.add(element);
          //throw an error
        }
        emit(LoadedUpdateProductsState(updatedProducts));
      });
    } catch (e) {
      //display error message
      emit(FailedUpdateProductsState());
    }
  }

  Future<void> filterProducts(
      String category, List<Product> orginalProductList) async {
    emit(LoadingFilterProductState());

    try {
      print(';;;;karrikaa filet : $category');
      List<Product> filterList = [];
      if (category == 'Default') {
        emit(LoadedFilterProductState(orginalProductList));
      } else {
        orginalProductList.forEach((element) {
          print(':: kartik filter ${element.category}');
          print(':: kartik filter string $category');
          if (element.category == category) {
            filterList.add(element);
          } else if (category == 'Default') {
            filterList.clear();
            filterList = orginalProductList;
          }
        });
        emit(LoadedFilterProductState(filterList));
      }
    } catch (e) {
      emit(FailedFilterProductState());
    }
  }
}
