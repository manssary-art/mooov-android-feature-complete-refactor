import 'package:core/core.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';


extension ResponsiveBreakpointsDataExt on ResponsiveBreakpointsData {
  Breakpoint breakpointOf(String name) => breakpoints.firstWhere((e) => e.name == name);
  Breakpoint? breakpointOfOrNull(String name) => breakpoints.firstOrNull((e) => e.name == name);
}
