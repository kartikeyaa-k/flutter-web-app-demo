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

class LoadedProductState extends ProductState {
  final List<Product> productList;
  LoadedProductState(this.productList);
}

class FailedProductState extends ProductState {}

//update
class LoadingUpdateProductsState extends ProductState {}

class LoadedUpdateProductsState extends ProductState {
  final List<Product> productList;
  LoadedUpdateProductsState(this.productList);
}

class FailedUpdateProductsState extends ProductState {}

//filter
class LoadingFilterProductState extends ProductState {}

class LoadedFilterProductState extends ProductState {
  final List<Product> productList;
  LoadedFilterProductState(this.productList);
}

class FailedFilterProductState extends ProductState {}
