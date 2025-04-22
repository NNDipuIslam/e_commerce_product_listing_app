import 'package:e_commerce_product_listing_app/core/exports.dart';
import 'package:e_commerce_product_listing_app/features/search/presentation/widgets/show_product.dart';
import 'package:e_commerce_product_listing_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late ScrollController _scrollController;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late SearchBloc _searchBloc;

  @override
  void initState() {
    _scrollController = ScrollController();
    _searchBloc = context.read<SearchBloc>();
    _scrollController.addListener(_scrollListener);
    // TODO: implement initState
    super.initState();
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Sort By',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildSortOption('Title (A-Z)', SortOption.title),
            _buildSortOption('Price: High to Low', SortOption.priceHighToLow),
            _buildSortOption('Price: Low to High', SortOption.priceLowToHigh),
            _buildSortOption('Rating', SortOption.rating),
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger pagination to load more
      _searchBloc.add(SearchLoadMoreWithQuery(_searchController.text));
    }
  }

  Widget _buildSortOption(String title, SortOption option) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        _searchBloc.add(SortProducts(option));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppPalette.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 19,
          ),
          _buildSearchBar(),
          const SizedBox(
            height: 8,
          ),
          Expanded(child:
              BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
            List<Product> products = [];

            if (state is SearchLoading) {
              if (state.isFirstFetch)
                return const Center(child: CircularProgressIndicator());
              products = state.oldProduct;
            } else if (state is SearchError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                  ),
                );
              });

              return const Center(
                child: Text('Something went wrong, please try again later.'),
              );
            } else if (state is SearchLoadedWithQuery) {
              products = state.products;
            }
            if (products.length == 0) {
              return Center(
                child: Text('NO data found'),
              );
            }
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              controller: _scrollController,
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.6,
              ),
              itemBuilder: (context, index) {
                if (index < products.length) {
                  return showProduct(
                      context: context, product: products[index]);
                } else
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
              },
            );
          }))
        ],
      ),
    ));
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              controller: _searchController,
              focusNode: _focusNode,
              hintText: 'Search products...',
              prefixIcon: InkWell(
                  onTap: () {
                    _searchBloc.add(SearchQueryChanged(_searchController.text));
                  },
                  child: const Icon(Icons.search)),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list, size: 48),
            onPressed: _showSortOptions,
          ),
        ],
      ),
    );
  }
}
