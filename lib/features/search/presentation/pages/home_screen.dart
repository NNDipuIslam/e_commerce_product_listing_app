import 'package:e_commerce_product_listing_app/core/constants/app_pallete.dart';
import 'package:e_commerce_product_listing_app/core/exports.dart';
import 'package:e_commerce_product_listing_app/features/search/presentation/widgets/show_product.dart';
import 'package:e_commerce_product_listing_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late ScrollController _scrollController;
  late SearchBloc _searchBloc;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchBloc = context.read<SearchBloc>();
    _scrollController.addListener(_scrollListener);
    _focusNode.addListener(_handleFocusChange);
    _searchBloc.add(SearchInitialLoad());
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
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
            _buildSortOption('Price: High to Low'),
            _buildSortOption('Price: Low to High'),
            _buildSortOption('Rating'),
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final currentState = context.read<SearchBloc>().state;

      // Check if the current state is SearchLoaded and if more data is available
      if (currentState is SearchLoaded && currentState.hasMore) {
        // Trigger pagination to load more
        _searchBloc.add(SearchLoadMore());
      }
    }
  }

  Widget _buildSortOption(String title) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        print('Sort: $title');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products = [];
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppPalette.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 19),
              _buildSearchBar(),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    print('BlocBuilder rebuilt with state: $state');

                    if (state is SearchLoading) {
                      return const Center(child: CircularProgressIndicator());
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
                        child: Text(
                            'Something went wrong, please try again later.'),
                      );
                    } else if (state is SearchLoaded) {
                      print(state.hasMore);
                      if (state.products.isEmpty) {
                        return const Center(
                            child: Text('No products available'));
                      }

                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        controller: _scrollController,
                        itemCount:
                            state.products.length + (state.hasMore ? 1 : 0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.6,
                        ),
                        itemBuilder: (context, index) {
                          if (index == state.products.length) {
                            return const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          return showProduct(
                              context: context, product: state.products[index]);
                        },
                      );
                    }

                    return const Center(child: Text('Something went wrong.'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            controller: _searchController,
            focusNode: _focusNode,
            hintText: 'Search products...',
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        if (_isFocused)
          IconButton(
            icon: const Icon(Icons.filter_list, size: 48),
            onPressed: _showSortOptions,
          ),
      ],
    );
  }
}
