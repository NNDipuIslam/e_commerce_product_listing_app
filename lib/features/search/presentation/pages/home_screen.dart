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
  FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 19,
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _searchController,
                        focusNode: _focusNode,
                        hintText: 'Search products...',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    if (_isFocused)
                      IconButton(
                        icon: Icon(Icons.filter_list),
                        onPressed: () {
                          // Handle filter action
                          print('Filter clicked');
                        },
                      ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: showProduct(context: context)),
                    SizedBox(
                      width: 26,
                    ),
                    Expanded(child: showProduct(context: context)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
