import 'package:easy_localization/easy_localization.dart';
import 'package:style_venue/core/components/cards/primary_grid_image.dart';
import 'package:style_venue/core/constants/asset_paths.dart';
import 'package:style_venue/core/extensions/context_extension.dart';
import 'package:style_venue/core/extensions/string_case_extension.dart';
import 'package:style_venue/core/utils/lang/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildTopBox(context)),
        Expanded(
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Expanded(child: _buildSaleBox(context)),
                      Expanded(child: _buildBlackBox(context)),
                    ],
                  ),
                ),
                Expanded(child: _buildHoodiesBox(context))
              ],
            ),
          ),
        ),
      ],
    );
  }
}

PrimaryGridImage _buildTopBox(BuildContext context) {
  return PrimaryGridImage(
      imagePath: AssetPaths.image1,
      childWidget: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              LocaleKeys.home_title.tr().toTitleCase(),
              style: context.textTheme.headlineMedium!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )),
      ));
}

PrimaryGridImage _buildSaleBox(BuildContext context) {
  return PrimaryGridImage(
    height: context.height / 4,
    childWidget: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(LocaleKeys.home_sale.tr().toTitleCase(),
            style: context.textTheme.headlineMedium!.copyWith(
              color: context.colors.onPrimary,
              fontWeight: FontWeight.bold,
            )),
      ),
    ),
  );
}

PrimaryGridImage _buildBlackBox(BuildContext context) {
  return PrimaryGridImage(
      height: context.height / 4,
      imagePath: AssetPaths.image3,
      childWidget: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            LocaleKeys.home_black.tr().toTitleCase(),
            style: context.textTheme.headlineMedium!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ));
}

PrimaryGridImage _buildHoodiesBox(BuildContext context) {
  return PrimaryGridImage(
    height: context.height / 2,
    imagePath: AssetPaths.image2,
    childWidget: Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          LocaleKeys.home_hoodies.tr().toTitleCase(),
          style: context.textTheme.headlineMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}