part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchInitialLoad extends SearchEvent {}

class SearchLoadMore extends SearchEvent {}

class SearchLoadMoreWithQuery extends SearchEvent {
  final String query;

  const SearchLoadMoreWithQuery(this.query);

  @override
  List<Object> get props => [query];
}

enum SortOption { title, priceLowToHigh, priceHighToLow, rating }

class SortProducts extends SearchEvent {
  final SortOption option;

  SortProducts(this.option);
}

class SearchQueryChanged extends SearchEvent {
  final String query;

  const SearchQueryChanged(this.query);

  @override
  List<Object> get props => [query];
}

class SearchSubmitted extends SearchEvent {
  final String query;

  const SearchSubmitted(this.query);

  @override
  List<Object> get props => [query];
}

class ClearSearch extends SearchEvent {
  const ClearSearch();
}
