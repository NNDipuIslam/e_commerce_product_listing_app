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

  // Initial load of products
  Future<void> _onInitialLoad(
      SearchInitialLoad event, Emitter<SearchState> emit) async {
    // Emit loading state
    emit(SearchLoading([])); // Empty list for the initial load

    _skip = 0; // Reset skip for new search
    _allProducts.clear(); // Clear the list to reload data

    // Fetch the products
    final result = await getProducts(skip: _skip, limit: _limit);

    result.fold(
      (failure) {
        // Handle failure
        emit(SearchError(failure.message));
      },
      (productsModel) {
        _allProducts.addAll(productsModel);
        _skip += _limit;
        _totalProducts = productsModel.length; // Update total count

        // Check if more products are available
        final hasMore = _totalProducts > _allProducts.length;

        // Emit the loaded state
        emit(SearchLoaded(
          products: _allProducts,
          total: _totalProducts,
          hasMore: hasMore,
        ));
      },
    );
  }

  // Load more products when the user scrolls
  Future<void> _onLoadMore(
      SearchLoadMore event, Emitter<SearchState> emit) async {
    if (_isFetching) return; // Avoid duplicate requests while fetching

    _isFetching = true; // Set fetching state to true
    emit(SearchLoading(_allProducts)); // Show loading with current products

    final result = await getProducts(skip: _skip, limit: _limit);

    result.fold(
      (failure) {
        _isFetching = false;
        emit(SearchError(failure.message)); // Emit error state
      },
      (productsModel) {
        _allProducts.addAll(productsModel);
        _skip += _limit;
        _totalProducts = productsModel.length;

        // Check if more products are available
        final hasMore = _totalProducts > _allProducts.length;

        // Emit the loaded state with more products
        _isFetching = false;
        emit(SearchLoaded(
          products: _allProducts,
          total: _totalProducts,
          hasMore: hasMore,
        ));
      },
    );
  }
}
