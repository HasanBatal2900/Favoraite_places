import 'package:favoriate_places/screen/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 102, 6, 247),
    background: const Color.fromARGB(255, 56, 49, 66),
    brightness: Brightness.dark);
final theme = ThemeData().copyWith(
  colorScheme: colorScheme,
  scaffoldBackgroundColor: colorScheme.background,
  useMaterial3: true,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleLarge: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold, color: Colors.white),
    titleMedium: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold, color: Colors.white),
    titleSmall: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold, color: Colors.white),
  ),
  primaryTextTheme: const TextTheme(
    titleLarge: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
  ),
);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const PlacesListScreen(),
    );
  }
}
