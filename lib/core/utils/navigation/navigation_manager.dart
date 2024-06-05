import 'package:style_venue/core/base/view/base_view.dart';
import 'package:style_venue/features/splash/splash_view.dart';
import 'package:style_venue/features/success/view/success_view.dart';
import 'package:flutter/cupertino.dart';

class NavigationManager {
  static final routes = <String, Widget Function(BuildContext)>{
    SplashView.id: (context) => const SplashView(),
    BaseView.id: (context) => const BaseView(),
    SuccessView.id: (context) => const SuccessView(),
    // ProductDetailView.id: (context) => const ProductDetailView(),
  };
}