import "package:favoriate_places/screen/new_place.dart";
import 'package:flutter/material.dart';

final newPageBuilder = PageRouteBuilder(
  transitionDuration: const Duration(milliseconds: 500),
  transitionsBuilder: (context, animation, secondaryAnimation, child) {
    animation = CurvedAnimation(parent: animation, curve: Curves.easeInQuint);
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  },
  pageBuilder: (context, animation, secondaryAnimation) {
    return const NewPlace();
  },
);
