import 'package:e_commerce_product_listing_app/core/constants/app_pallete.dart';
import 'package:e_commerce_product_listing_app/core/exports.dart';
import 'package:e_commerce_product_listing_app/core/navigator_service.dart';
import 'package:e_commerce_product_listing_app/core/service_locator.dart';
import 'package:e_commerce_product_listing_app/features/search/presentation/widgets/show_product.dart';
import 'package:e_commerce_product_listing_app/routes/routes.dart';
import 'package:e_commerce_product_listing_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  late SearchBloc _searchBloc;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchBloc = context.read<SearchBloc>();
    _scrollController.addListener(_scrollListener);

    _searchBloc.add(SearchInitialLoad());
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Check if the current state is SearchLoaded and if more data is available

      // Trigger pagination to load more
      _searchBloc.add(SearchLoadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppPalette.white,
            resizeToAvoidBottomInset: false,
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 19),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: _buildSearchBar(),
                  ),
                  const SizedBox(height: 16),
                  Expanded(child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (context, state) {
                    List<Product> products =
                        sl<ProductLocalDataSource>().getAllProducts();
                    if (state is SearchLoading) {
                      if (state.isFirstFetch)
                        return const Center(
                            child: CircularProgressIndicator());
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
                    } else if (state is SearchLoaded) {
                      products = state.products;
                    }
            
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      controller: _scrollController,
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                            child:
                                Center(child: CircularProgressIndicator()),
                          );
                      },
                    );
                  }))
                ])));
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        print('nn');
        NavigatorService.pushNamed(AppRoutes.searchScreen);
      },
      child: CustomTextField(
        hintText: 'Search products...',
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black,
        ),
        enabled: false, // Disable TextFormField interaction
      ),
    );
  }
}
