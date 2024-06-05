import 'package:style_venue/core/constants/enums/app_theme_enum.dart';
import 'package:style_venue/core/utils/theme/dark/app_theme_dark.dart';
import 'package:style_venue/core/utils/theme/light/app_theme_light.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(isDark: false));
  void toggleSwitch(bool value) => emit(state.copyWith(changeTheme: value));
}