import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ignore: non_constant_identifier_names
CustomTransitionPage FadeTransitionPage({
  required Widget child,
  required ValueKey<String> key,
}) =>
    CustomTransitionPage(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
