import 'package:flutter/material.dart';
import 'package:shopify_app/models/category.model.dart';

class CategoryItemRowWidget extends StatelessWidget {
  final CategoryData categoryData;
  Widget? iconWidget;
  CategoryItemRowWidget({
    required this.categoryData,
    this.iconWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color(categoryData.shadowColor ?? 0),
                    offset: const Offset(0, 10),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors:
                      categoryData.colors?.map((e) => Color(e)).toList() ?? []),
              shape: BoxShape.circle),
          child: Padding(
            padding: EdgeInsets.only(top: categoryData.image != null ? 10 : 0),
            child: Center(
              child: iconWidget != null
                  ? const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 30,
                      color: Colors.red,
                    )
                  : Image.network(
                      categoryData.image ?? '',
                      height: 70,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          categoryData.title ?? 'No Title',
          style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xff515C6F)),
        )
      ],
    );
  }
}
