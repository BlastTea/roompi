part of 'widgets.dart';

class RoompiMaterialApp extends StatelessWidget {
  const RoompiMaterialApp({
    super.key,
    this.home,
    this.title = '',
  });

  final Widget? home;
  final String title;

  @override
  Widget build(BuildContext context) => MWidgetTheme(
        dialogTheme: const MWidgetDialogThemeData(
          errorTitleText: 'Gagal',
        ),
        child: MWidgetDynamicColorBuilder(
          builder: (context, theme, darkTheme, themeMode, colorScheme) {
            ColorScheme effectiveColorScheme = colorScheme!.copyWith(
                surface: kColorWhite,
                primary: const Color(0xFF51563D),
                secondary: const Color(0xFF8B8F7E),
                );

            TextTheme effectiveTextTheme = TextTheme(
              bodyLarge: kTextStyleBodyLarge.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w800),
              bodyMedium: kTextStyleBodyMedium.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w600),
              bodySmall: kTextStyleBodySmall.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w600),
              displayLarge: kTextStyleDisplayLarge.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w600),
              displayMedium: kTextStyleDisplayMedium.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w600),
              displaySmall: kTextStyleDisplaySmall.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w600),
              headlineLarge: kTextStyleHeadlineLarge.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w600),
              headlineMedium: kTextStyleHeadlineMedium.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w600),
              headlineSmall: kTextStyleHeadlineSmall.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w600),
              labelLarge: kTextStyleLabelLarge.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w600),
              labelMedium: kTextStyleLabelMedium.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w600),
              labelSmall: kTextStyleLabelSmall.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w600),
              titleLarge: kTextStyleTitleLarge.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w600),
              titleMedium: kTextStyleTitleMedium.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w400),
              titleSmall: kTextStyleTitleSmall.copyWith(fontFamily: kFontFamily, color: effectiveColorScheme.primary, fontWeight: FontWeight.w600),
            );

            // TODO: Implement color for disabled state
            // FilledButtonThemeData effectiveFilledButtonTheme = FilledButtonThemeData(
            //   style: ButtonStyle(
            //     elevation: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.pressed) ? 0.0 : 8.0),
            //     textStyle: WidgetStatePropertyAll(effectiveTextTheme.headlineSmall),
            //     foregroundColor: const WidgetStatePropertyAll(kColorWhite),
            //     padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0)),
            //     shape: const WidgetStatePropertyAll(
            //       RoundedRectangleBorder(
            //         borderRadius: kBorderRadius,
            //       ),
            //     ),
            //   ),
            // );

            InputDecorationTheme effectiveInputDecorationTheme = InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: kBorderRadius,
                borderSide: BorderSide(
                  color: effectiveColorScheme.primary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: kBorderRadius,
                borderSide: BorderSide(
                  color: effectiveColorScheme.primary,
                ),
              ),
              floatingLabelStyle: effectiveTextTheme.bodyLarge!.copyWith(color: effectiveColorScheme.primary),
              labelStyle: effectiveTextTheme.bodyLarge!.copyWith(color: effectiveColorScheme.primary),
            );

            DividerThemeData effectiveDividerTheme = const DividerThemeData(
              color: kColorDivider,
            );

            return MaterialApp(
              title: title,
              theme: theme.copyWith(
                colorScheme: effectiveColorScheme,
                scaffoldBackgroundColor: effectiveColorScheme.surface,
                textTheme: effectiveTextTheme,
                // filledButtonTheme: effectiveFilledButtonTheme,
                inputDecorationTheme: effectiveInputDecorationTheme,
                dividerTheme: effectiveDividerTheme,
              ),
              darkTheme: darkTheme.copyWith(
                colorScheme: effectiveColorScheme,
                scaffoldBackgroundColor: effectiveColorScheme.surface,
                textTheme: effectiveTextTheme,
                // filledButtonTheme: effectiveFilledButtonTheme,
                inputDecorationTheme: effectiveInputDecorationTheme,
                dividerTheme: effectiveDividerTheme,
              ),
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              navigatorKey: navigatorKey,
              scaffoldMessengerKey: scaffoldMessengerKey,
              home: home,
            );
          },
        ),
      );
}
