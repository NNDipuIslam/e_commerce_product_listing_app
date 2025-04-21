import 'package:e_commerce_product_listing_app/core/constants/app_pallete.dart';
import 'package:e_commerce_product_listing_app/features/search/presentation/widgets/show_product.dart';
import 'package:e_commerce_product_listing_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
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

  Widget _buildSortOption(String title) {
    return ListTile(
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        print('Sort: $title');
        // You can add sorting logic here
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppPalette.white,
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 19),
              _buildSearchBar(),
              const SizedBox(height: 16),
              _buildProductGrid(),
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

  Widget _buildProductGrid() {
    return Row(
      children: [
        Expanded(child: showProduct(context: context)),
        const SizedBox(width: 26),
        Expanded(child: showProduct(context: context)),
      ],
    );
  }
}
