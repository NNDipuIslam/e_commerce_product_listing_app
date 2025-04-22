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
  int _totalProducts = 0; // Store the total number of products

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
      (failure) {
        emit(SearchError(failure.message));
      },
      (productsModel) {
        _allProducts.addAll(productsModel);
        _skip += _limit;
        _totalProducts = productsModel.length; // Store the total
        final hasMore = _limit == _totalProducts; // Check if more data exists
        emit(SearchLoaded(
          products: _allProducts,
          total: _totalProducts,
          hasMore: hasMore,
        ));
      },
    );
  }

  Future<void> _onLoadMore(
      SearchLoadMore event, Emitter<SearchState> emit) async {
    emit(SearchLoading());

    final result = await getProducts(skip: _skip, limit: _limit);

    result.fold(
      (failure) {
        _isFetching = false;
        emit(SearchError(failure.message));
      },
      (productsModel) {
        _allProducts.addAll(productsModel);
        _skip += _limit;
        _totalProducts = productsModel.length; // Update total if needed
        final hasMore = _limit == _totalProducts; // Check if more data exists
        print(hasMore);
        _isFetching = false;
        try {
          emit(SearchLoaded(
            products: _allProducts,
            total: _totalProducts,
            hasMore: hasMore,
          ));
        } catch (e) {
          print(e.toString());
        }

        print(
            'Got more ${productsModel.length}, total ${_allProducts.length}, hasMore: $hasMore');
      },
    );
  }
}
