import 'package:easy_localization/easy_localization.dart';
import 'package:style_venue/core/constants/lorem_ipsum.dart';
import 'package:style_venue/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:style_venue/core/extensions/string_case_extension.dart';

class PrimaryExpansionTile extends StatelessWidget {
  const PrimaryExpansionTile(
      this.translationKey, {
        super.key,
        this.widgets,
      });
  final String translationKey;
  final List<Widget>? widgets;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      expandedAlignment: Alignment.topLeft,
      iconColor: context.colors.onPrimary,
      collapsedIconColor: context.colors.onSecondary,
      textColor: context.colors.onPrimary,
      collapsedTextColor: context.colors.onSecondary,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        translationKey.tr().toCapitalized(),
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      children: widgets ??
          [
            const SizedBox(
              child: Text(
                LoremIpsum.loremIpsum1,
              ),
            )
          ],
    );
  }
}