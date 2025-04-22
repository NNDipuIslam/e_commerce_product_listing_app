import 'package:bloc/bloc.dart';
import 'package:e_commerce_product_listing_app/core/exports.dart';

import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetProducts getProducts;
  int _skip = 0;
  final int _limit = 10;
  bool _isFetching = false;
  List<Product> _allProducts = [];
  SearchBloc({required this.getProducts}) : super(SearchInitial()) {
    on<SearchInitialLoad>(_onInitialLoad);
    on<SearchLoadMore>(_onLoadMore);
  }
  Future<void> _onInitialLoad(
      SearchInitialLoad event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    _skip = 0;
    _allProducts.clear();

    final result = await getProducts(skip: _skip, limit: _limit);

    result.fold(
      (failure) => emit(SearchError(failure.message)),
      (products) {
        _allProducts.addAll(products);
        _skip += _limit;
        emit(SearchLoaded(
            products: _allProducts, hasMore: products.length == _limit));
      },
    );
  }

  Future<void> _onLoadMore(
      SearchLoadMore event, Emitter<SearchState> emit) async {
    if (_isFetching || state is! SearchLoaded) return;

    _isFetching = true;
    final result = await getProducts(skip: _skip, limit: _limit);

    result.fold(
      (failure) {
        _isFetching = false;
        emit(SearchError(failure.message));
      },
      (products) {
        _allProducts.addAll(products);
        _skip += _limit;
        _isFetching = false;
        emit(SearchLoaded(
            products: _allProducts, hasMore: products.length == _limit));
      },
    );
  }
}
