import 'package:go_router/go_router.dart';

GoRouterRedirect canPopRedirect({
  required String Function(GoRouterState state) redirect,
}) =>
    (context, state) {
      final goRouter = GoRouter.maybeOf(context);
      if (goRouter == null || goRouter.location == state.path) {
        return redirect(state);
      }

      return null;
    };
