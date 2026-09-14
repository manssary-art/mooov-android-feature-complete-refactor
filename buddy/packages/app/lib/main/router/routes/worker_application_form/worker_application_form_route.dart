import 'package:design_system/design_system.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../../screens/worker_application_form/worker_application_form_screen.dart'
    deferred as lazy_worker_application_form_screen;
import '../../ext/go_router_ext.dart';
import '../../redirects/authentication_redirect.dart';
import '../../transitions/fade_transition_page.dart';
import '../authentication/authentication_route.dart';
import '../profile/profile_route.dart';
import '../utilities/country_picker_route.dart';
import '../utilities/date_picker_route.dart';
import '../utilities/image_picker_route.dart';

const _routePath = '/worker-application-form';

String workerApplicationFormPath() => Uri(
      path: _routePath,
    ).toString();

RouteBase workerApplicationFormRoute({
  required GlobalKey<NavigatorState>? parentNavigatorKey,
}) =>
    GoRoute(
      path: _routePath,
      parentNavigatorKey: parentNavigatorKey,
      redirect: requireAuthenticatedRedirect(go: '/', push: authenticationPath()),
      pageBuilder: (context, state) => FadeTransitionPage(
        key: state.pageKey,
        child: DeferredBuilder(
          loadLibrary: lazy_worker_application_form_screen.loadLibrary,
          builder: (context) {
            return lazy_worker_application_form_screen.WorkerApplicationFormScreen(
              onNavBack: () => context.popOrGo(location: profilePath()),
              onNavToImagePicker: () => showImagePickerBottomModalSheet(context: context),
              onNavToCountryPicker: (initial) => showCountryPickerBottomModalSheet(context: context, initial: initial),
              onNavToDatePicker: (initial) => showDatePickerBottomModalSheet(context: context, initial: initial),
            );
          },
        ),
      ),
    );
