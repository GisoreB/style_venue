import 'package:style_venue/core/extensions/context_extension.dart';
import 'package:style_venue/core/utils/theme/color_wheel.dart';
import 'package:style_venue/product/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductRatingBar extends StatelessWidget {
  const ProductRatingBar({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RatingBarIndicator(
          rating: product.rating!.rate!,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: ColorWheel.mangoLatte,
          ),
          itemSize: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            '(${product.rating!.count!})',
            style: context.textTheme.bodySmall,
          ),
        )
      ],
    );
  }
}