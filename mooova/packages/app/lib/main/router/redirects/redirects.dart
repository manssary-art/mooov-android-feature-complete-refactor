import 'package:go_router/go_router.dart';

GoRouterRedirect redirects(
  List<GoRouterRedirect> redirects,
) =>
    (context, state) async {
      for (final value in redirects) {
        final location = await value(context, state);
        if (location != null) {
          return location;
        }
      }
      return null;
    };
