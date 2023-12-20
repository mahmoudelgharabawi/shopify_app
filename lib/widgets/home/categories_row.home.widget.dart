import 'package:flutter/material.dart';
import 'package:shopify_app/models/category.model.dart';
import 'package:shopify_app/widgets/home/category_item_row.home.widget.dart';

class CategoriesRowHome extends StatelessWidget {
  final List<CategoryData> categories;
  const CategoriesRowHome({required this.categories, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          ...categories.map((category) => Padding(
                padding: const EdgeInsets.only(right: 20),
                child: CategoryItemRowWidget(
                  categoryData: category,
                ),
              )),
          CategoryItemRowWidget(
            categoryData: CategoryData()
              ..title = 'See More'
              ..colors = [
                Colors.white.value,
                Colors.white.value,
              ]
              ..shadowColor = 0xfff2f5f9,
            iconWidget: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 30,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
