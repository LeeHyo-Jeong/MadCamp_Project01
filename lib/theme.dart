import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4286238975),
      surfaceTint: Colors.white,
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283812095),
      onPrimaryContainer: Color(4286238975),
      secondary: Color(4284505443),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4294571259),
      onSecondaryContainer: Color(4283716184),
      tertiary: Color(4278216330),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283812095),
      onTertiaryContainer: Color(4286238975),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294310655),
      onSurface: Color(4279639072),
      onSurfaceVariant: Color(4282206288),
      outline: Color(4285364609),
      outlineVariant: Color(4290562257),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020725),
      inversePrimary: Color(4286238975),
      primaryFixed: Color(4291029247),
      onPrimaryFixed: Color(4286238975),
      primaryFixedDim: Color(4286238975),
      onPrimaryFixedVariant: Color(4286238975),
      secondaryFixed: Color(4293321192),
      onSecondaryFixed: Color(4280032032),
      secondaryFixedDim: Color(4291413452),
      onSecondaryFixedVariant: Color(4282926667),
      tertiaryFixed: Color(4291029247),
      onTertiaryFixed: Color(4286238975),
      tertiaryFixedDim: Color(4286238975),
      onTertiaryFixedVariant: Color(4286238975),
      surfaceDim: Color(4292205536),
      surfaceBright: Color(4294310655),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293915898),
      surfaceContainer: Color(4293521140),
      surfaceContainerHigh: Color(4293126638),
      surfaceContainerHighest: Color(4292797416),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278208611),
      surfaceTint: Color(4278216330),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278222249),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282663495),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285952889),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278208611),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4278222249),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294310655),
      onSurface: Color(4279639072),
      onSurfaceVariant: Color(4281943116),
      outline: Color(4283785576),
      outlineVariant: Color(4285627524),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020725),
      inversePrimary: Color(4286238975),
      primaryFixed: Color(4278222249),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278215558),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285952889),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4284308321),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4278222249),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278215558),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292205536),
      surfaceBright: Color(4294310655),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293915898),
      surfaceContainer: Color(4293521140),
      surfaceContainerHigh: Color(4293126638),
      surfaceContainerHighest: Color(4292797416),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278199605),
      surfaceTint: Color(4278216330),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278208611),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4280492326),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282663495),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278199605),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4278208611),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294310655),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4279903532),
      outline: Color(4281943116),
      outlineVariant: Color(4281943116),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281020725),
      inversePrimary: Color(4292472831),
      primaryFixed: Color(4278208611),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278202692),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4282663495),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4281150513),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4278208611),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278202692),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292205536),
      surfaceBright: Color(4294310655),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293915898),
      surfaceContainer: Color(4293521140),
      surfaceContainerHigh: Color(4293126638),
      surfaceContainerHighest: Color(4292797416),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4288732415),
      surfaceTint: Color(4278783763),
      onPrimary: Color(4278203721),
      primaryContainer: Color(4278237173),
      onPrimaryContainer: Color(4278199090),
      secondary: Color(4294967295),
      onSecondary: Color(4281413685),
      secondaryContainer: Color(4292334554),
      onSecondaryContainer: Color(4282400324),
      tertiary: Color(4288732415),
      onTertiary: Color(4278203721),
      tertiaryContainer: Color(4278237173),
      onTertiaryContainer: Color(4278199090),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279112728),
      onSurface: Color(4292797416),
      onSurfaceVariant: Color(4290562257),
      outline: Color(4287074971),
      outlineVariant: Color(4282206288),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797416),
      inversePrimary: Color(4286238975),
      primaryFixed: Color(4291029247),
      onPrimaryFixed: Color(4278197804),
      primaryFixedDim: Color(4286238975),
      onPrimaryFixedVariant: Color(4286238975),
      secondaryFixed: Colors.black87,
      onSecondaryFixed: Color(4280032032),
      secondaryFixedDim: Color(4291413452),
      onSecondaryFixedVariant: Color(4282926667),
      tertiaryFixed: Color(4291029247),
      onTertiaryFixed: Color(4278197804),
      tertiaryFixedDim: Color(4286238975),
      onTertiaryFixedVariant: Color(4278209641),
      surfaceDim: Color(4279112728),
      surfaceBright: Color(4281612862),
      surfaceContainerLowest: Color(4278783763),
      surfaceContainerLow: Color(4279639072),
      surfaceContainer: Color(4279902244),
      surfaceContainerHigh: Color(4280625967),
      surfaceContainerHighest: Color(4281349690),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4288732415),
      surfaceTint: Color(4286238975),
      onPrimary: Color(4278198833),
      primaryContainer: Color(4278237173),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294967295),
      onSecondary: Color(4281413685),
      secondaryContainer: Color(4292334554),
      onSecondaryContainer: Color(4280295204),
      tertiary: Color(4288732415),
      onTertiary: Color(4278198833),
      tertiaryContainer: Color(4278237173),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279112728),
      onSurface: Color(4294507519),
      onSurfaceVariant: Color(4290825429),
      outline: Color(4288259245),
      outlineVariant: Color(4286154125),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797416),
      inversePrimary: Color(4278210154),
      primaryFixed: Color(4291029247),
      onPrimaryFixed: Color(4278194973),
      primaryFixedDim: Color(4286238975),
      onPrimaryFixedVariant: Color(4286238975),
      secondaryFixed: Color(4293321192),
      onSecondaryFixed: Color(4279373845),
      secondaryFixedDim: Color(4291413452),
      onSecondaryFixedVariant: Color(4281808187),
      tertiaryFixed: Color(4291029247),
      onTertiaryFixed: Color(4278194973),
      tertiaryFixedDim: Color(4286238975),
      onTertiaryFixedVariant: Color(4278783763),
      surfaceDim: Color(4279112728),
      surfaceBright: Color(4281612862),
      surfaceContainerLowest: Color(4278783763),
      surfaceContainerLow: Color(4279639072),
      surfaceContainer: Color(4279902244),
      surfaceContainerHigh: Color(4280625967),
      surfaceContainerHighest: Color(4281349690),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294507519),
      surfaceTint: Color(4286238975),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4287091967),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294967295),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4292334554),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294507519),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4287091967),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279112728),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294507519),
      outline: Color(4290825429),
      outlineVariant: Color(4290825429),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292797416),
      inversePrimary: Color(4287091967),
      primaryFixed: Color(4291685375),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4287091967),
      onPrimaryFixedVariant: Color(4287091967),
      secondaryFixed: Color(4293584364),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4291676624),
      onSecondaryFixedVariant: Color(4279703066),
      tertiaryFixed: Color(4291685375),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4287091967),
      onTertiaryFixedVariant: Color(4278783763),
      surfaceDim: Color(4279112728),
      surfaceBright: Color(4281612862),
      surfaceContainerLowest: Color(4278783763),
      surfaceContainerLow: Color(4279639072),
      surfaceContainer: Color(4279902244),
      surfaceContainerHigh: Color(4280625967),
      surfaceContainerHighest: Color(4281349690),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surfaceTint,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
