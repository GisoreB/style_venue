import 'package:easy_localization/easy_localization.dart';
import 'package:style_venue/core/extensions/context_extension.dart';
import 'package:style_venue/core/extensions/string_case_extension.dart';
import 'package:style_venue/core/utils/lang/generated/locale_keys.g.dart';
import 'package:style_venue/features/shop/cubit/shop_cubit.dart';
import 'package:style_venue/product/components/app_bar/search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ShopAppBar({super.key})
      : preferredSize = const Size.fromHeight(kToolbarHeight * 2);
  @override
  final Size preferredSize;
  @override
  ShopAppBarState createState() => ShopAppBarState();
}

class ShopAppBarState extends State<ShopAppBar> {
  final List<String> actionsList = [
    LocaleKeys.shop_sort_types_popular.tr().toTitleCase(),
    LocaleKeys.shop_sort_types_newest.tr().toTitleCase(),
    LocaleKeys.shop_sort_types_reviews.tr().toTitleCase(),
    LocaleKeys.shop_sort_types_price_low.tr(),
    LocaleKeys.shop_sort_types_price_high.tr()
  ];
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.secondary,
      elevation: 5,
      child: Column(
        children: [
          _buildHeader(context),
          _buildActions(),
        ],
      ),
    );
  }

  AppBar _buildHeader(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.secondary,
      elevation: 0,
      iconTheme: IconThemeData(color: context.colors.onPrimary),
      titleTextStyle: context.textTheme.headlineSmall!
          .copyWith(color: context.colors.onPrimary),
      title: Center(
        child: Text(
          LocaleKeys.shop_title.tr().toTitleCase(),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () => showSearch(
                context: context,
                delegate: CustomSearchDelegate(hintText: 'Search')),
            icon: const Icon(
              Icons.search,
            ))
      ],
    );
  }

  Container _buildActions() {
    return Container(
      color: context.colors.secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(
            width: 10,
          ),
          Icon(
            Icons.sort,
            color: context.colors.onBackground,
          ),
          BlocBuilder<ShopCubit, ShopState>(
            builder: (context, state) {
              return Text(
                actionsList[state.selectedIndex ?? 0],
                style: TextStyle(
                  color: context.colors.onBackground,
                ),
              );
            },
          ),
          const Spacer(),
          IconButton(
              color: context.colors.onBackground,
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return _buildSheet(context, actionsList);
                    });
              },
              icon: const Icon(Icons.swap_vert)),
          const Spacer(),
          IconButton(
              color: context.colors.onBackground,
              onPressed: () => context.read<ShopCubit>().changeView(),
              icon: BlocBuilder<ShopCubit, ShopState>(
                builder: (context, state) {
                  return Icon(
                    state.isGrid ? Icons.list : Icons.grid_view_rounded,
                  );
                },
              ))
        ],
      ),
    );
  }

  Container _buildSheet(BuildContext context, List<String> actionsList) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          _buildSheetTitle(context),
          const SizedBox(
            height: 40,
          ),
          _buildSortTypes(actionsList, context),
        ],
      ),
    );
  }

  Text _buildSheetTitle(BuildContext context) {
    return Text(
      LocaleKeys.shop_sort.tr().toTitleCase(),
      style: context.textTheme.headlineSmall!.copyWith(),
    );
  }

  Expanded _buildSortTypes(List<String> actionsList, BuildContext context) {
    final int selectedIndex = context.read<ShopCubit>().index;
    return Expanded(
      child: GestureDetector(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: actionsList
              .map((action) => BlocBuilder<ShopCubit, ShopState>(
            builder: (context, state) {
              return BlocProvider.value(
                value: BlocProvider.of<ShopCubit>(context),
                child: GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    context
                        .read<ShopCubit>()
                        .selectIndex(actionsList.indexOf(action));
                    await context.read<ShopCubit>().fetchAllProducts(
                      params: context
                          .read<ShopCubit>()
                          .parameters,
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: context.paddingLowHorizontal,
                          height: 50,
                          color: actionsList.indexOf(action) ==
                              selectedIndex
                              ? Colors.red
                              : Colors.white,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              action,
                              style:
                              context.textTheme.bodyLarge!.copyWith(
                                color: actionsList.indexOf(action) ==
                                    selectedIndex
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ))
              .toList(),
        ),
      ),
    );
  }
}