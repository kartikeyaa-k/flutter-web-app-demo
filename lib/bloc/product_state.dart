part of 'product_cubit.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

//initial
class InitialProductState extends ProductState {}

//fetch
class LoadingProductState extends ProductState {}

class LoadedProductState extends ProductState {}

class FailedProductState extends ProductState {}

//update
class LoadingUpdateProductsState extends ProductState {}

class LoadedUpdateProductsState extends ProductState {}

class FailedUpdateProductsState extends ProductState {}
