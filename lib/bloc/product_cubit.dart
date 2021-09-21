import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'product_state.dart';

class ProductsCubit extends Cubit<ProductState> {
  ProductsCubit(InitialProductState initialState) : super(initialState);

  Future<void> getProducts(bool forceNetwork) async {
    emit(LoadingProductState());

    try {
      emit(LoadedProductState());
    } catch (e) {
      emit(FailedProductState());
    }
  }

  Future<void> updateProducts(bool forceNetwork) async {
    emit(LoadingUpdateProductsState());

    try {
      emit(LoadedUpdateProductsState());
    } catch (e) {
      emit(FailedUpdateProductsState());
    }
  }
}
