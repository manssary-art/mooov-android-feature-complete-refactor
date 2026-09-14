import 'package:flutter/material.dart';
import 'package:generated_assets/generated_assets.dart';

TextTheme _buildTextTheme(TextTheme newBase) {
  return newBase
      .copyWith(
        displayLarge: newBase.displayLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 32,
        ),
        displayMedium: newBase.displayLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
        displaySmall: newBase.displaySmall?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
        headlineLarge: newBase.headlineLarge?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
        headlineMedium: newBase.headlineMedium?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        headlineSmall: newBase.headlineSmall?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
        labelLarge: newBase.labelLarge?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        labelMedium: newBase.labelMedium?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
        labelSmall: newBase.labelSmall?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 11,
        ),
        titleLarge: newBase.titleLarge?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w300,
        ),
        titleMedium: newBase.titleMedium?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
        titleSmall: newBase.titleSmall?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w300,
        ),
        bodyLarge: newBase.bodyLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w200,
        ),
        bodyMedium: newBase.bodyMedium?.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w200,
        ),
        bodySmall: newBase.bodySmall?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w200,
        ),
      )
      .apply(
        displayColor: ColorName.neutral80,
        bodyColor: ColorName.neutral80,
        fontFamily: FontFamily.poppins,
      );
}

const Map<TargetPlatform, PageTransitionsBuilder> _pageTransitionBuilders = <TargetPlatform, PageTransitionsBuilder>{
  TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
  TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
  TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
};

const ColorScheme colorScheme = ColorScheme.light(
  brightness: Brightness.light,
  primary: ColorName.primary,
  onPrimary: ColorName.neutral100,
  primaryContainer: ColorName.primary100,
  onPrimaryContainer: ColorName.primary600,
  background: ColorName.neutral0,
  onBackground: ColorName.neutral100,
  surface: ColorName.neutral5,
  onSurface: ColorName.neutral100,
  error: ColorName.error,
  onError: ColorName.neutral0,
  errorContainer: ColorName.error,
  onErrorContainer: ColorName.error,
  secondary: ColorName.primary400,
  onSecondary: ColorName.neutral0,
  secondaryContainer: ColorName.primary200,
  onSecondaryContainer: ColorName.primary700,
);

IconThemeData iconTheme(IconThemeData origin) {
  return origin.copyWith(
    color: ColorName.neutral80,
  );
}

ButtonThemeData get buttonTheme {
  return const ButtonThemeData(
    colorScheme: colorScheme,
    textTheme: ButtonTextTheme.normal,
    buttonColor: ColorName.neutral100,
  );
}

ThemeData get theme {
  var baseTheme = ThemeData.light(useMaterial3: true);
  final baseTextTheme = _buildTextTheme(baseTheme.textTheme);

  baseTheme = baseTheme.copyWith(
    brightness: Brightness.light,
    dialogBackgroundColor: ColorName.neutral0,
    iconTheme: iconTheme(baseTheme.iconTheme),
    primaryIconTheme: iconTheme(baseTheme.primaryIconTheme),
    primaryColor: ColorName.primary,
    primaryColorLight: ColorName.neutral0,
    hintColor: ColorName.neutral40,
    unselectedWidgetColor: ColorName.neutral40,
    buttonTheme: buttonTheme,
    scaffoldBackgroundColor: ColorName.neutral0,
    textTheme: baseTextTheme,
    primaryTextTheme: baseTextTheme,
    colorScheme: colorScheme,
  );

  baseTheme = baseTheme.copyWith(
    cardTheme: baseTheme.cardTheme.copyWith(
      elevation: 2,
      surfaceTintColor: ColorName.neutral0,
      color: ColorName.neutral0,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
    ),
  );

  baseTheme = baseTheme.copyWith(
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
      backgroundColor: ColorName.neutral0,
    ),
  );

  baseTheme = baseTheme.copyWith(
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: baseTheme.primaryColor,
      unselectedItemColor: baseTheme.disabledColor,
      selectedLabelStyle: baseTextTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
        color: baseTheme.primaryColor,
      ),
      unselectedLabelStyle: baseTextTheme.bodyLarge?.copyWith(
        fontWeight: FontWeight.w300,
        fontSize: 12.0,
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
  );

  baseTheme = baseTheme.copyWith(
    dividerTheme: baseTheme.dividerTheme.copyWith(
      color: ColorName.neutral80,
      thickness: 0.1,
    ),
  );

  baseTheme = baseTheme.copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: _pageTransitionBuilders,
    ),
  );

  baseTheme = baseTheme.copyWith(
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        backgroundColor: baseTheme.colorScheme.primary,
        foregroundColor: baseTheme.colorScheme.onPrimary,
        textStyle: baseTextTheme.headlineLarge,
      ),
    ),
  );

  baseTheme = baseTheme.copyWith(
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(60),
        backgroundColor: null,
        foregroundColor: baseTextTheme.headlineLarge!.color,
        textStyle: baseTextTheme.headlineLarge,
      ),
    ),
  );

  return baseTheme;
}
