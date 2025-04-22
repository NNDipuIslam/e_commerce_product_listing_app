part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  final List<Product> oldProduct;
  final bool isFirstFetch;

  SearchLoading(this.oldProduct, {this.isFirstFetch = false});
}

class SearchLoaded extends SearchState {
  final List<Product> products;
  final int total;
  final bool hasMore;

  const SearchLoaded({
    required this.products,
    required this.total,
    required this.hasMore,
  });
  @override
  List<Object> get props => [products, total, hasMore];
}

class SearchLoadedWithQuery extends SearchState {
  final List<Product> products;
  final int total;
  final bool hasMore;

  const SearchLoadedWithQuery({
    required this.products,
    required this.total,
    required this.hasMore,
  });
  @override
  List<Object> get props => [products, total, hasMore];
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
