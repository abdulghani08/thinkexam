import 'package:flutter/material.dart';

enum Breakpoint { mobile, tablet, desktop }

class ResponsiveHelper {
  static Breakpoint getBreakpoint(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    if (width < 600) {
      return Breakpoint.mobile;
    } else if (width < 1024) {
      return Breakpoint.tablet;
    } else {
      return Breakpoint.desktop;
    }
  }

  static bool isMobile(BuildContext context) {
    return getBreakpoint(context) == Breakpoint.mobile;
  }

  static bool isTablet(BuildContext context) {
    return getBreakpoint(context) == Breakpoint.tablet;
  }

  static bool isDesktop(BuildContext context) {
    return getBreakpoint(context) == Breakpoint.desktop;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static EdgeInsets getPadding(BuildContext context) {
    final breakpoint = getBreakpoint(context);
    
    switch (breakpoint) {
      case Breakpoint.mobile:
        return const EdgeInsets.all(16);
      case Breakpoint.tablet:
        return const EdgeInsets.all(24);
      case Breakpoint.desktop:
        return const EdgeInsets.all(32);
    }
  }

  static double getCardWidth(BuildContext context) {
    final breakpoint = getBreakpoint(context);
    final width = getWidth(context);
    
    switch (breakpoint) {
      case Breakpoint.mobile:
        return width - 32;
      case Breakpoint.tablet:
        return (width - 48) / 2;
      case Breakpoint.desktop:
        return (width - 64) / 3;
    }
  }

  static int getGridColumns(BuildContext context) {
    final breakpoint = getBreakpoint(context);
    
    switch (breakpoint) {
      case Breakpoint.mobile:
        return 1;
      case Breakpoint.tablet:
        return 2;
      case Breakpoint.desktop:
        return 3;
    }
  }
}

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, Breakpoint breakpoint) builder;

  const ResponsiveBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveHelper.getBreakpoint(context);
    return builder(context, breakpoint);
  }
}

class ResponsiveValue<T> {
  final T mobile;
  final T? tablet;
  final T? desktop;

  const ResponsiveValue({
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  T getValue(BuildContext context) {
    final breakpoint = ResponsiveHelper.getBreakpoint(context);
    
    switch (breakpoint) {
      case Breakpoint.mobile:
        return mobile;
      case Breakpoint.tablet:
        return tablet ?? mobile;
      case Breakpoint.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}
