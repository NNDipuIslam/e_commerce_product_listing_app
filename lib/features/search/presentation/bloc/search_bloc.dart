import 'package:bloc/bloc.dart';
import 'package:e_commerce_product_listing_app/core/exports.dart';
import 'package:e_commerce_product_listing_app/features/search/domain/use_cases/search_product_use_case.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetProducts getProducts;
  final SearchProduct searchProduct;
  int _skip = 0;
  final int _limit = 10;
  bool _isFetching = false;
  bool _isFetchingWithQuery = false;
  List<Product> _allProducts = [];
  List<Product> _searchProducts = [];
  int _totalProducts = 0; // Store the total number of products

  SearchBloc({required this.getProducts, required this.searchProduct})
      : super(SearchInitial()) {
    on<SearchInitialLoad>(_onInitialLoad);
    on<SearchLoadMore>(_onLoadMore);
    on<SearchQueryChanged>(_searchQueryChanged);
    on<SearchLoadMoreWithQuery>(_SearchLoadMoreWithQuery);
    on<SortProducts>(_sortProduct);
  }

  Future<void> _onInitialLoad(
      SearchInitialLoad event, Emitter<SearchState> emit) async {
    emit(SearchLoading([]));

    _skip = 0;
    _allProducts.clear();

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
        _totalProducts = productsModel.length;

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

    _isFetching = true;
    emit(SearchLoading(_allProducts));

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

  Future<void> _searchQueryChanged(
      SearchQueryChanged event, Emitter<SearchState> emit) async {
    emit(SearchLoading(_searchProducts));
    _skip = 0;
    _searchProducts.clear();
    var result = await searchProduct.call(
        query: event.query, skip: _skip, limit: _limit);
    result.fold(
      (failure) {
        // Handle failure
        emit(SearchError(failure.message));
      },
      (productsModel) {
        print(productsModel.length);
        _searchProducts.addAll(productsModel);
        _skip += _limit;

        // Check if more products are available
        final hasMore = productsModel.length > _searchProducts.length;

        // Emit the loaded state
        emit(SearchLoadedWithQuery(
          products: _searchProducts,
          total: productsModel.length,
          hasMore: hasMore,
        ));
      },
    );
  }

  Future<void> _SearchLoadMoreWithQuery(
      SearchLoadMoreWithQuery event, Emitter<SearchState> emit) async {
    if (_isFetchingWithQuery) return; // Avoid duplicate requests while fetching

    _isFetching = true; // Set fetching state to true
    emit(SearchLoading(_searchProducts)); // Show loading with current products

    final result = await getProducts(skip: _skip, limit: _limit);

    result.fold(
      (failure) {
        _isFetchingWithQuery = false;
        emit(SearchError(failure.message)); // Emit error state
      },
      (productsModel) {
        _searchProducts.addAll(productsModel);
        _skip += _limit;
        // _totalProducts = productsModel.length;

        // Check if more products are available
        final hasMore = productsModel.length > _searchProducts.length;

        // Emit the loaded state with more products
        _isFetching = false;
        emit(SearchLoadedWithQuery(
          products: _searchProducts,
          total: productsModel.length,
          hasMore: hasMore,
        ));
      },
    );
  }

  Future<void> _sortProduct(
      SortProducts event, Emitter<SearchState> emit) async {
    print('here again ${event.option}');
    List<Product> sortedProducts = List.from(_searchProducts);
    switch (event.option) {
      case SortOption.title:
        sortedProducts.sort((a, b) => (a.title ?? '').compareTo(b.title ?? ''));
        break;
      case SortOption.priceLowToHigh:
        sortedProducts
            .sort((a, b) => (a.price ?? 0.0).compareTo(b.price ?? 0.0));
        break;
      case SortOption.priceHighToLow:
        sortedProducts
            .sort((a, b) => (b.price ?? 0.0).compareTo(a.price ?? 0.0));
        break;
      case SortOption.rating:
        sortedProducts
            .sort((a, b) => (b.rating ?? 0.0).compareTo(a.rating ?? 0.0));
        break;
    }

    emit(SearchLoadedWithQuery(
        products: sortedProducts, total: sortedProducts.length, hasMore: true));
  }
}
