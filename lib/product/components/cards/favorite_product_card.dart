import 'package:style_venue/core/components/buttons/circular_icon_button.dart';
import 'package:style_venue/core/components/cards/primary_list_tile.dart';
import 'package:style_venue/core/components/cards/tile_image_card.dart';
import 'package:style_venue/core/components/custom_message.dart';
import 'package:style_venue/core/components/primary_snackbar.dart';
import 'package:style_venue/core/constants/asset_paths.dart';
import 'package:style_venue/core/extensions/context_extension.dart';
import 'package:style_venue/core/extensions/string_case_extension.dart';
import 'package:style_venue/core/utils/lang/generated/locale_keys.g.dart';
import 'package:style_venue/features/bag/bloc/bag_bloc.dart';
import 'package:style_venue/features/favorites/bloc/favorites_bloc.dart';
import 'package:style_venue/product/components/product_rating_bar.dart';
import 'package:style_venue/product/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class FavoriteProductCard extends StatelessWidget {
  const FavoriteProductCard({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        children: [
          _buildProductTile(context),
          _buildAddToCartButton(context),
        ],
      ),
    );
  }

  Column _buildProductTile(BuildContext context) {
    return Column(
      children: [
        PrimaryListTile(
          childWidget: Row(
            children: [
              _buildProductImage(),
              _buildProductDetails(context),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  TileImageCard _buildProductImage() {
    return TileImageCard(image: product.image);
  }

  Expanded _buildProductDetails(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: context.paddingLow,
        child: Column(
          children: [
            _buildTitle(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    product.category!.toTitleCase(),
                    style: context.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _buildPrice(context)
          ],
        ),
      ),
    );
  }

  Row _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 5,
          child: Text(
            product.title!,
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          child: IconButton(
              onPressed: () {
                context
                    .read<FavoritesBloc>()
                    .add(FavoritesProductRemoved(product));
                PrimarySnackbar.show(
                    context,
                    CustomMessage(
                        translationKey:
                        LocaleKeys.common_messages_favorite_remove,
                        icon: Lottie.asset(AssetPaths.animRemoved,
                            repeat: false)));
              },
              icon: Icon(
                Icons.clear,
                color: context.colors.background,
              )),
        )
      ],
    );
  }

  Padding _buildPrice(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '${product.price}\$',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.colors.onBackground,
              ),
            ),
          ),
          Expanded(flex: 4, child: ProductRatingBar(product: product)),
          const Spacer(),
        ],
      ),
    );
  }

  Align _buildAddToCartButton(BuildContext context) {
    return Align(
      alignment: const Alignment(1.05, 1.1),
      child: CircularIconButton(
        iconData: Icons.shopping_bag,
        iconColor: Colors.white,
        voidCallback: () =>
            context.read<BagBloc>().add(BagProductAdded(product)),
      ),
    );
  }
}