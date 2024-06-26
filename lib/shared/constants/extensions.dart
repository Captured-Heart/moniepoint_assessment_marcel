import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension PaddingExtension on Widget {
  Widget padAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget padSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget padOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }
}

extension AlignmentExtension on Widget {
  Widget alignCenterLeft({
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  Widget alignCenterRight({
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  Widget alignTopLeft({
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      alignment: Alignment.topLeft,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  Widget alignTopRight({
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      alignment: Alignment.topRight,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  Widget alignBottomLeft({
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      alignment: Alignment.bottomLeft,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  Widget alignBottomRight({
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      alignment: Alignment.bottomRight,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  Widget debugBorder({Color? color}) {
    if (kDebugMode) {
      return DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: color ?? Colors.red, width: 4),
        ),
        child: this,
      );
    } else {
      return this;
    }
  }

  Widget onTapWidget({VoidCallback? onTap, VoidCallback? onLongPress, required String tooltip}) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        child: this,
      ),
    );
  }
}

extension ColumnChildrenSpacing on List<Widget> {
  List<Widget> columnInPadding(double height) {
    return expand(
      (element) => [
        element,
        SizedBox(
          height: height,
        )
      ],
    ).toList();
  }

  List<Widget> rowInPadding(double width) {
    return expand(
      (element) => [
        element,
        SizedBox(
          width: width,
        )
      ],
    ).toList();
  }
}

extension MediaQuerySizeExtension on BuildContext {
  double sizeWidth(double w) {
    return MediaQuery.sizeOf(this).width * w;
  }

  double sizeHeight(double h) {
    return MediaQuery.sizeOf(this).height * h;
  }

  Offset center(Offset f) {
    return MediaQuery.sizeOf(this).center(f);
  }

  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
}

extension WidgetAnimation on Widget {
  Animate fadeInFromTop({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 300.ms)
          .move(
            duration: animationDuration ?? 300.ms,
            begin: offset ?? const Offset(0, -10),
          )
          .fade(duration: animationDuration ?? 300.ms);

  Animate fadeInFromBottom({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 300.ms)
          .move(
            duration: animationDuration ?? 300.ms,
            begin: offset ?? const Offset(0, 10),
          )
          .fade(duration: animationDuration ?? 300.ms);

  // write fadeInFromRight

  Animate fadeInFromLeft({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 300.ms)
          .move(
            duration: animationDuration ?? 300.ms,
            begin: offset ?? const Offset(-10, 0),
          )
          .fade(duration: animationDuration ?? 300.ms);

  Animate fadeInFromRight({
    Duration? delay,
    Duration? animationDuration,
    Offset? offset,
  }) =>
      animate(delay: delay ?? 300.ms)
          .move(
            duration: animationDuration ?? 300.ms,
            begin: offset ?? const Offset(10, 0),
          )
          .fade(duration: animationDuration ?? 300.ms);

  Animate fadeIn({
    Duration? delay,
    Duration? animationDuration,
    Curve? curve,
  }) =>
      animate(delay: delay ?? 300.ms).fade(
        duration: animationDuration ?? 300.ms,
        curve: curve ?? Curves.decelerate,
      );

  Animate scale({
    Duration? delay,
    Duration? animationDuration,
    Curve? curve,
  }) =>
      animate(
        delay: delay ?? 300.ms,
      ).scale(
        duration: animationDuration ?? 300.ms,
        curve: curve ?? Curves.easeOut,
      );

  Animate scaleFromLeft({
    Duration? delay,
    Duration? animationDuration,
    Curve? curve,
  }) =>
      animate(
        delay: delay ?? 300.ms,
      ).scale(
        duration: animationDuration ?? 3100.ms,
        curve: curve ?? Curves.easeOut,
        begin: const Offset(0, -20),
        // end: const Offset(0, 0),
        // alignment: Alignment.bottomLeft,
      );

  Animate slideInFromBottom({
    Duration? delay,
    Duration? animationDuration,
    Curve? curve,
    double? begin,
  }) =>
      animate(
        delay: delay ?? 300.ms,
      ).slideY(
        duration: animationDuration ?? 300.ms,
        begin: begin ?? 0.2,
        end: 0,
        curve: curve ?? Curves.linear,
      );
}
