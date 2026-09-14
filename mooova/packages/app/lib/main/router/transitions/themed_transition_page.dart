import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemedTransitionPage<T> extends Page<T> {
  /// Constructor for a page with custom transition functionality.
  ///
  /// To be used instead of MaterialPage or CupertinoPage, which provide
  /// their own transitions.
  const ThemedTransitionPage({
    required this.child,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    this.maintainState = true,
    this.fullscreenDialog = false,
    this.opaque = true,
    this.barrierDismissible = false,
    this.barrierColor,
    this.barrierLabel,
    this.webTargetPlatform = TargetPlatform.android,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  /// The content to be shown in the Route created by this page.
  final Widget child;

  /// A duration argument to customize the duration of the custom page
  /// transition.
  ///
  /// Defaults to 300ms.
  final Duration transitionDuration;

  /// A duration argument to customize the duration of the custom page
  /// transition on pop.
  ///
  /// Defaults to 300ms.
  final Duration reverseTransitionDuration;

  /// Whether the route should remain in memory when it is inactive.
  ///
  /// If this is true, then the route is maintained, so that any futures it is
  /// holding from the next route will properly resolve when the next route
  /// pops. If this is not necessary, this can be set to false to allow the
  /// framework to entirely discard the route's widget hierarchy when it is
  /// not visible.
  final bool maintainState;

  /// Whether this page route is a full-screen dialog.
  ///
  /// In Material and Cupertino, being fullscreen has the effects of making the
  /// app bars have a close button instead of a back button. On iOS, dialogs
  /// transitions animate differently and are also not closeable with the
  /// back swipe gesture.
  final bool fullscreenDialog;

  /// Whether the route obscures previous routes when the transition is
  /// complete.
  ///
  /// When an opaque route's entrance transition is complete, the routes
  /// behind the opaque route will not be built to save resources.
  final bool opaque;

  /// Whether you can dismiss this route by tapping the modal barrier.
  final bool barrierDismissible;

  /// The color to use for the modal barrier.
  ///
  /// If this is null, the barrier will be transparent.
  final Color? barrierColor;

  /// The semantic label used for a dismissible barrier.
  ///
  /// If the barrier is dismissible, this label will be read out if
  /// accessibility tools (like VoiceOver on iOS) focus on the barrier.
  final String? barrierLabel;

  /// Target transition platform when app is running on web
  final TargetPlatform webTargetPlatform;

  @override
  Route<T> createRoute(BuildContext context) => _ThemedTransitionPageRoute<T>(this);
}

class _ThemedTransitionPageRoute<T> extends PageRoute<T> {
  final ThemedTransitionPage<T> _page;

  _ThemedTransitionPageRoute(this._page) : super(settings: _page);

  @override
  bool get barrierDismissible => _page.barrierDismissible;

  @override
  Color? get barrierColor => _page.barrierColor;

  @override
  String? get barrierLabel => _page.barrierLabel;

  @override
  Duration get transitionDuration => _page.transitionDuration;

  @override
  Duration get reverseTransitionDuration => _page.reverseTransitionDuration;

  @override
  bool get maintainState => _page.maintainState;

  @override
  bool get fullscreenDialog => _page.fullscreenDialog;

  @override
  bool get opaque => _page.opaque;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: _page.child,
      );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final theme = Theme.of(context);
    final builders = theme.pageTransitionsTheme.builders;
    TargetPlatform platform = theme.platform;

    if (kIsWeb) {
      platform = _page.webTargetPlatform;
    } else if (CupertinoRouteTransitionMixin.isPopGestureInProgress(this)) {
      platform = TargetPlatform.iOS;
    }

    PageTransitionsBuilder? matchingBuilder = builders[platform];
    matchingBuilder ??= const FadeUpwardsPageTransitionsBuilder();
    return matchingBuilder.buildTransitions<T>(
      this,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
