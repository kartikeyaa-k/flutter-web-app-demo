import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuchange_web_app/network/data/product.dart';
import 'package:nuchange_web_app/repository/product_repository.dart';
part 'product_state.dart';

class ProductsCubit extends Cubit<ProductState> {
  ProductsCubit(InitialProductState initialState) : super(initialState);

  ProductRepository _productRepository = ProductRepository();

  Future<void> getProducts(bool forceNetwork) async {
    emit(LoadingProductState());
    print(':: kartik bloc get products');
    try {
      List<Product> productList = await _productRepository.fetchProductList();

      print(':: bloc product list $productList');

      emit(LoadedProductState(productList));
    } catch (e) {
      emit(FailedProductState());
    }
  }

  Future<void> updateProducts(bool forceNetwork, int productID,
      List<Product> orignalProductList, String quantity) async {
    emit(LoadingUpdateProductsState());
    List<Product> updatedProducts = [];

    try {
      orignalProductList.forEach((element) {
        if (element.id == productID) {
          element.quantity = quantity;

          updatedProducts.add(element);
          print(element.category);
        } else {
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

    print('filter category : $category');
    try {
      List<Product> filterList = [];
      if (category == 'Default') {
        emit(LoadedFilterProductState(orginalProductList));
      } else {
        orginalProductList.forEach((element) {
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
